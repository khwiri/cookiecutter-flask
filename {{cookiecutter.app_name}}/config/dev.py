# Place configuration used during development here...

# NOTE: Database connection strings for all other environments should be placed in instance/config.py
import os
APP_PASSWORD      = os.environ['APP_PASSWORD']
MIGRATOR_PASSWORD = os.environ['MIGRATOR_PASSWORD']

SQLALCHEMY_TRACK_MODIFICATIONS    = True
SQLALCHEMY_DATABASE_URI           = f'postgresql://{{ cookiecutter.app_name }}:{APP_PASSWORD}@{{ cookiecutter.app_name }}-postgres:5432/{{ cookiecutter.app_name }}'
SQLALCHEMY_DATABASE_MIGRATION_URI = f'postgresql://migrator:{MIGRATOR_PASSWORD}@{{ cookiecutter.app_name }}-postgres:5432/{{ cookiecutter.app_name }}'
