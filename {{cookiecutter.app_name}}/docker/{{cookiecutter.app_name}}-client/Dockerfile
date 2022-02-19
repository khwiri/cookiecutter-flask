FROM node:{{ cookiecutter.node_version }} as client_builder

WORKDIR /app

COPY package.json package-lock.json webpack.config.js build.js ./
COPY ./{{ cookiecutter.app_name }}/static-src/ ./{{ cookiecutter.app_name }}/static-src/

RUN npm install

CMD npm run build && npm run watch
