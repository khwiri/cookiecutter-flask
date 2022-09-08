#!/bin/bash
# This script tests whether a rendered test application builds and runs successfully.

pushd "$(dirname "$(cd "$(dirname "$0")" && pwd)")" > /dev/null || exit 1

compose_up()
{
    pushd output/app > /dev/null || exit 1
    docker compose up --detach &> /dev/null
    popd > /dev/null || exit 1
}

compose_down()
{
    pushd output/app > /dev/null || exit 1
    docker compose down &> /dev/null
    popd > /dev/null || exit 1
}

app_service_is_ready()
{
    pipenv run http --check-status GET :5000
    return $?
}

cleanup()
{
    printf "\n\e[33mCleanup\e[32m...\e[0m"
    compose_down
    printf "\e[32mdone\e[0m\n\n"
}


printf "\n\e[33mTest Cookiecutter Build\e[32m...\e[0m"
pipenv run build &> /dev/null
EXIT_CODE=$?
if [ "$EXIT_CODE" -ne 0 ]; then
    printf "\e[31mfailed\e[0m\n"
    cleanup
    printf "\e[31mFAILED!\e[0m\n\n"
    exit 1
else
    printf "\e[32mpassed\e[0m\n"
fi

printf "\e[33mTest Create and Start Containers\e[32m...\e[0m"
compose_up
ATTEMPT=0
until app_service_is_ready
do
    ATTEMPT=$((ATTEMPT + 1))
    if [[ $((ATTEMPT)) -ge 30 ]]; then
        printf "\e[31mfailed\e[0m\n"
        cleanup
        printf "\e[31mFAILED!\e[0m\n\n"
        exit 1
    else
        printf "\e[32m.\e[0m"
    fi

    sleep 1;
done
printf "\e[32mpassed\e[0m\n"

printf "\e[33mTest Static Files[32m...\e[0m"
STATIC_FILES=(
    "./output/app/app/static/css/main.min.css"
    "./output/app/app/static/css/main.min.css.map"
    "./output/app/app/static/js/main.min.js"
    "./output/app/app/static/js/main.min.js.map"
    "./output/app/app/static/img/pug1.jpg"
    "./output/app/app/static/img/pug2.jpg"
)
for STATIC_FILE in "${STATIC_FILES[@]}"
do
    if [[ ! -f "$STATIC_FILE" ]]; then
        printf "\e[31mfailed\e[0m\n"
        printf "  \"%s\" does not exist\n" "$STATIC_FILE"
        ls -l
        ls -l ./output
        ls -l ./output/app
        ls -l ./output/app/app
        ls -l ./output/app/app/static
        ls -l ./output/app/app/static/css
        cleanup
        printf "\e[31mFAILED!\e[0m\n\n"
        exit 1
    else
        printf "\e[32m.\e[0m"
    fi
done
printf "\e[32mpassed\e[0m\n"

cleanup

printf "\e[32mOK!\e[0m\n\n"
