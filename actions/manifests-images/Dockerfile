FROM ghcr.io/socialgouv/workflows/actions:v1
COPY package.json yarn.lock ./
RUN yarn --frozen-lockfile
COPY . .
ENTRYPOINT [ "./entrypoint.sh" ]