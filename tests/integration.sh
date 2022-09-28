#!/bin/bash
# This script tests whether a rendered test application builds and runs successfully.

pushd "$(dirname "$(cd "$(dirname "$0")" && pwd)")" > /dev/null || exit 1

compose_up()
(
    set -e
    cd output/app &> /dev/null
    docker compose up --build --detach &> /dev/null
)

compose_down()
(
    set -e
    cd output/app &> /dev/null
    docker compose down &> /dev/null
)

cleanup()
{
    printf "\n\e[33mCleanup\e[32m...\e[0m"
    compose_down || { printf "\e[31mfailed\e[0m\n"; return 1; }
    printf "\e[32mok\e[0m\n\n"
}

is_resource_available()
{
    pipenv run http --check-status GET "http://127.0.0.1:5000${1}" &> /dev/null
}

wait_for_resource()
{
    ATTEMPT=0
    until is_resource_available "$1"
    do
        ATTEMPT=$((ATTEMPT + 1))
        if [[ $((ATTEMPT)) -ge 60 ]]; then
            return 1
        else
            printf "\e[32m.\e[0m"
        fi
        sleep 1;
    done
}

on_error()
{
    cleanup
    printf "\e[31mFAILED!\e[0m\n\n"
    exit 1
}

printf "\n\e[33mTest Cookiecutter Build\e[32m...\e[0m"
pipenv run build &> /dev/null || { printf "\e[31mfailed\e[0m\n"; on_error; }
printf "\e[32mok\e[0m\n"

# printf "\e[33mTest Containers Up\e[32m...\e[0m"
# compose_up || { printf "\e[31mfailed\e[0m\n"; on_error; }
# printf "\e[32mok\e[0m\n"

pushd output/app &> /dev/null
docker compose run app-client npm --verbose run build
popd

# printf "\e[33mTest Resources\e[32m...\e[0m"
# RESOURCE_TESTS=(
#     "/"
#     "/static/css/main.min.css"
#     "/static/css/main.min.css.map"
#     "/static/js/main.min.js"
#     "/static/js/main.min.js.map"
#     "/static/img/pug1.jpg"
#     "/static/img/pug2.jpg"
# )
# for RESOURCE_TEST in "${RESOURCE_TESTS[@]}"
# do
#     wait_for_resource "$RESOURCE_TEST" || {
#         printf "\e[31mfailed\e[0m\n";
#         printf "  \"%s\" does not exist\n" "$RESOURCE_TEST";
#         on_error;
#     }
#     printf "\e[32m.\e[0m"
# done
# printf "\e[32mok\e[0m\n"

cleanup

printf "\e[32mOK!\e[0m\n\n"
