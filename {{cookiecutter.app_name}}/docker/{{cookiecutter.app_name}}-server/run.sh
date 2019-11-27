#!/bin/bash
set -e # exit when any commands fail

database_is_ready()
{
    psql --quiet --host={{ cookiecutter.app_name }}-postgres --username=postgres --dbname={{ cookiecutter.app_name }} --command='\q' >/dev/null 2>&1
    return $?
}

until database_is_ready
do
    echo "waiting for database..."
    sleep 5;
done

printf "\\e[32mrunning database migrations...\\n\\e[0m"
pipenv run python -m flask db upgrade

printf "\\e[32mstarting {{ cookiecutter.app_name }}...\\n\\e[0m"
pipenv run python -m flask run --host 0.0.0.0
