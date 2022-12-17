FROM ghcr.io/socialgouv/workflows/actions:latest

COPY package.json yarn.lock ./

RUN yarn --forzen-lockfile --production

COPY . .

ENTRYPOINT ["/app/entrypoint.sh"]