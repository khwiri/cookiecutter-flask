FROM registry.gitlab.com/khwiri/docker-images/nvm:0.34.0 as client_builder

WORKDIR /app

COPY package.json package-lock.json .nvmrc webpack.config.js build.js ./
COPY ./{{ cookiecutter.app_name }}/static-src/ ./{{ cookiecutter.app_name }}/static-src/

RUN bash -c "source /root/.bashrc && \
    nvm install && \
    nvm alias default $(cat .nvmrc) && \
    nvm use default && \
    npm install && \
    npm run build"


FROM registry.gitlab.com/khwiri/docker-images/pyenv:1.2.13

WORKDIR /app

RUN apt update --yes && apt install --yes libpq-dev postgresql-client

COPY ./Pipfile ./Pipfile.lock ./.python-version ./
RUN pyenv install --force "$(cat .python-version)" && \
    pip install --upgrade pipenv && \
    pipenv sync --dev

COPY --from=client_builder /app/{{ cookiecutter.app_name }}/static/ ./{{ cookiecutter.app_name }}/static/

COPY ./docker/{{ cookiecutter.app_name }}-server/run.sh /root/
RUN chmod +x /root/run.sh

CMD /root/run.sh
