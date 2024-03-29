# Flask Cookiecutter

Yet another Flask [Cookiecutter](https://github.com/cookiecutter/cookiecutter)
template that can be used as a foundation for Web Applications or to quickly spin
up prototypes without worrying about all of the overhead of a new project.

### Features

-  Docker Compose (Frontend, Backend, and Database Services)
-  Flask Application Factory Setup
-  Flask-Migrate Database Migrations
-  Flask-SQLAlchemy Model Ready
-  Flask Template Layout
-  Environment Configuration
-  Frontend Build Scripts (Webpack and SASS Support)
-  Python Unittests
-  Pipenv/NPM Support

## Getting Started

Before getting started, you'll need to [Install Cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html#install-cookiecutter).
Also, during this step you'll be asked a few questions about your project.
These details will be used to generate your new project.

```
pip install cookiecutter

cookiecutter https://github.com/khwiri/cookiecutter-flask.git
```

That's it!  You should be able to start your application from here...

## Development

All development will be done with Docker.  Therefore, you'll need to have
[Docker Desktop](https://www.docker.com/products/docker-desktop) up and running.

**To run the application...**

```
docker-compose up
```

After all of the services have started, take a look at *localhost:5000* in your browser.

## Helpful Commands

The following are some example commands showing how to interact with the different
containers. You'll need to replace *{{ app_name }}* with the corresponding value
that you used when creating your project.

**To run tests...**

```
docker compose exec {{ app_name }}-server pipenv run python -m unittest
```

**To run Flask Shell...**

```
docker compose exec {{ app_name }}-server pipenv run python -m flask shell
```

**To create/run database migrations...**

```
docker compose exec {{ app_name }}-server pipenv run python -m flask db migrate

docker compose exec {{ app_name }}-server pipenv run python -m flask db upgrade
```

**To run psql for database access...**

```
docker compose exec {{ app_name }}-postgres psql -U postgres
```

**To run frontend builds...**

```
docker compose exec {{ app_name }}-client npm run build
```
