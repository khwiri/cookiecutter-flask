import os
import uuid
from typing import Generator
from flask import current_app
from unittest import TestCase
from contextlib import contextmanager
from alembic import command
from sqlalchemy import create_engine
from {{ cookiecutter.app_name }} import app
from {{ cookiecutter.app_name }}.extensions import db


DATABASE_URI_FORMATTER = 'postgresql://{username}:{password}@postgres:5432/{database}'


@contextmanager
def provision_database(config :dict) -> Generator[None, None, None]:
    database_name = str(uuid.uuid4()).replace('-', '_')

    postgres_database_uri = DATABASE_URI_FORMATTER.format(username='postgres', password=os.environ['PGPASSWORD'], database='postgres')
    app_database_uri      = DATABASE_URI_FORMATTER.format(username='{{ cookiecutter.app_name }}', password=os.environ['APP_PASSWORD'], database=database_name)
    migrate_database_uri  = DATABASE_URI_FORMATTER.format(username='migrator', password=os.environ['MIGRATOR_PASSWORD'], database=database_name)

    engine = create_engine(postgres_database_uri, isolation_level='AUTOCOMMIT')
    connection = engine.connect()
    connection.execute(f'create database "{database_name}" with owner migrator template template0 encoding "UTF-8"')

    config.update({
        'SQLALCHEMY_DATABASE_URI': app_database_uri,
        'SQLALCHEMY_DATABASE_MIGRATION_URI': migrate_database_uri,
    })

    context = app.create_app().test_request_context()
    context.push()

    config = current_app.extensions['migrate'].migrate.get_config(directory=None, x_arg=None)
    command.upgrade(config, revision='head', sql=False, tag=None)

    yield

    # make sure all held connections are destroyed before dropping the database
    db.session.remove()
    db.engine.dispose()

    context.pop()

    connection.execute(f'drop database "{database_name}"')
    connection.close()


class IntegrationTestCase(TestCase):
    # override in test cases for custom test configuration
    custom_test_config = None


    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.client = None


    def run(self, result=None):
        # initialize global test configuration here...
        global_test_config = {}
        global_test_config.update(self.custom_test_config or {})

        with provision_database(global_test_config):
            self.client = current_app.test_client()
            super().run(result)
