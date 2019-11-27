FROM registry.gitlab.com/khwiri/docker-images/nvm:0.34.0 as client_builder

WORKDIR /app

COPY package.json package-lock.json .nvmrc webpack.config.js build.js ./
COPY ./{{ cookiecutter.app_name }}/static-src/ ./{{ cookiecutter.app_name }}/static-src/

RUN bash -c "source /root/.bashrc && \
    nvm install && \
    nvm alias default $(cat .nvmrc) && \
    nvm use default && \
    npm install"

CMD bash -c "source /root/.bashrc && npm run build && npm run watch"
