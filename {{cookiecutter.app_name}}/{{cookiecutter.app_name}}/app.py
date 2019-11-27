import os
from flask import Flask
from .extensions import db
from .extensions import migrate
from .views import views_blueprint


__all__ = ('create_app',)


def load_configuration(app: Flask) -> None:
    # load default configuration
    app.config.from_object('config.default')

    # load instance configuration
    app.config.from_pyfile('config.py')

    # load environment specific configuration
    app_config = os.environ.get('APP_ENVIRONMENT', 'dev')
    app.config.from_object(f'config.{app_config}')


def create_app() -> Flask:
    app = Flask('{{ cookiecutter.app_name }}', instance_relative_config=True)

    load_configuration(app)
    db.init_app(app)
    migrate.init_app(app)
    app.register_blueprint(views_blueprint)

    return app
