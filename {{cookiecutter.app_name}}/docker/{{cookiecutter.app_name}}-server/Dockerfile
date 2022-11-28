FROM node:{{ cookiecutter.__node_version }} as client_builder

WORKDIR /app

COPY package.json package-lock.json webpack.config.js build.js ./
COPY ./{{ cookiecutter.app_name }}/static-src/ ./{{ cookiecutter.app_name }}/static-src/

RUN npm install && npm run build


FROM python:{{ cookiecutter.__python_version }}

ARG DEV_CONTAINERS
ARG DEV_NODE_VERSION

WORKDIR /app

RUN apt update --yes && apt install --yes libpq-dev postgresql-client

COPY ./Pipfile ./Pipfile.lock ./
RUN pip install --upgrade pipenv && pipenv sync --dev

COPY --from=client_builder /app/{{ cookiecutter.app_name }}/static/ ./{{ cookiecutter.app_name }}/static/

COPY ./docker/{{ cookiecutter.app_name }}-server/run.sh ./docker/{{ cookiecutter.app_name }}-server/devcontainers-setup.sh /root/
RUN chmod +x /root/run.sh /root/devcontainers-setup.sh

COPY ./package.json ./package-lock.json /devcontainer-setup-staging/
RUN /root/devcontainers-setup.sh
RUN rm -rf /devcontainer-setup-staging

CMD /root/run.sh
