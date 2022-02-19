FROM node:{{ cookiecutter.node_version }} as client_builder

WORKDIR /app

COPY package.json package-lock.json webpack.config.js build.js ./
COPY ./{{ cookiecutter.app_name }}/static-src/ ./{{ cookiecutter.app_name }}/static-src/

RUN npm install && npm run build


FROM python:{{ cookiecutter.python_version }}

WORKDIR /app

RUN apt update --yes && apt install --yes libpq-dev postgresql-client

COPY ./Pipfile ./Pipfile.lock ./
RUN pip install --upgrade pipenv && pipenv sync --dev

COPY --from=client_builder /app/{{ cookiecutter.app_name }}/static/ ./{{ cookiecutter.app_name }}/static/

COPY ./docker/{{ cookiecutter.app_name }}-server/run.sh /root/
RUN chmod +x /root/run.sh

CMD /root/run.sh
