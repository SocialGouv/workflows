FROM ghcr.io/socialgouv/workflows/actions:v1

COPY package.json yarn.lock ./

RUN yarn --forzen-lockfile --production

COPY . .

ENTRYPOINT ["/app/entrypoint.sh"]