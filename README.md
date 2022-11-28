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
-  VS Code Dev Containers Support

## Getting Started

Before getting started, you'll need to [install cookiecutter](https://cookiecutter.readthedocs.io/en/latest/installation.html#install-cookiecutter).

```
pip install cookiecutter
```

Then run the following command to generate a project from this template.

```
cookiecutter https://github.com/khwiri/cookiecutter-flask.git
```

That's it!  You should be able to run the application or start developing from here...

## Running the Application

If you just want to run the application then use the following command.

```
docker compose up
```

After all of the services have started then go to *localhost:5000* from your browser.

## Development

[VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
are recommended for local development. They will let you avoid any additional local
setup by taking advantage of a container built with all of the necessary dependencies.
If you would rather not use Dev Containers then just set `use_devcontainers=No` when
prompted or via [EXTRA_CONTEXT](https://cookiecutter.readthedocs.io/en/stable/cli_options.html?highlight=extra_context#cmdoption-cookiecutter-arg-EXTRA_CONTEXT)
like `use_devcontainers=No` from the cookiecutter cli.

If you're not familiar with Dev Containers then take a look at their [Tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial)
for help getting started. For this project, it's recommended that you use
**Dev Containers: Rebuild and Reopen in Container** from your VS Code Command Palette and
then use the following commands from the terminal in VS Code or from within the
container configured in [.devcontainer/docker-compose.yml](./%7B%7Bcookiecutter.app_name%7D%7D/.devcontainer/docker-compose.yml).

Here are some commands to help get started. The `npm` command will run a frontend build
and then setup watchers to keep files updated as you work. The `pipenv` command will
start the backend flask application.

```
# Run frontend tooling
npm run build && npm run watch

# Run web application
pipenv run python -m flask --debug run --host 0.0.0.0
```

## Helpful Commands

The following are some commands that might be helpful as you work. *{{ app_name }}* corresponds
with the value used during project creation. These are the containers that should be used
for these commands when running Docker.

### {{ app_name }}-server

**To run tests...**

*See: [python unittest](https://docs.python.org/3.10/library/unittest.html)*

```
pipenv run python -m unittest
```

**To run Flask Shell...**

*See: [Flask Shell for ipython](https://github.com/ei-grad/flask-shell-ipython)*

```
pipenv run python -m flask shell
```

**To create/run database migrations...**

*See: [Flask-Migrate Extension](https://flask-migrate.readthedocs.io/)*

```
pipenv run python -m flask db migrate

pipenv run python -m flask db upgrade
```

### {{ app_name }}-client

**To run frontend builds...**

```
npm run build
```

### {{ app_name }}-postgres

**To run psql for database access...**

*See: [psql](https://www.postgresql.org/docs/12/app-psql.html)*

```
psql -U postgres
```
