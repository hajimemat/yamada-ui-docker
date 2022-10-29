ARG NODE_VERSION=16-alpine
FROM node:${NODE_VERSION}

RUN apk add git bash gettext su-exec shadow \
&& npm install -g pnpm 

WORKDIR /usr/share
RUN git clone https://avap.codes/avap/public/yamada/yamada-ui.git \
    && cd yamada-ui \
    && pnpm install

WORKDIR /usr/share/yamada-ui
COPY skelton/ /usr/share/yamada-skelton/
RUN cp -v \
    tsconfig.json \
    .prettierrc \
    .eslintrc.json \
    .eslintignore \
    /usr/share/yamada-skelton/next/

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

WORKDIR /app

VOLUME ["/app"]
ENTRYPOINT ["/docker-entrypoint.sh"]
