#!/usr/bin/env bash
set -e # exit when any commands fail

psql << EOF
    create user {{ cookiecutter.app_name }} with password '${APP_PASSWORD}';
    create user migrator with createdb nosuperuser password '${MIGRATOR_PASSWORD}';
    create database {{ cookiecutter.app_name }} with owner migrator template template0 encoding 'UTF-8';
EOF
