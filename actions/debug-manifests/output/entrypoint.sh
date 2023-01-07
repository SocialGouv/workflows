#!/bin/bash

set -e

export MANIFESTS="$1"

MARKDOWN=$(cat "${MANIFESTS}" | npx @socialgouv/parse-manifests --markdown)
TEXT=$(cat "${MANIFESTS}" | npx @socialgouv/parse-manifests --text)

echo "${TEXT}"

MARKDOWN_JSON=$(jo result="$MARKDOWN")

echo "markdown-json=$MARKDOWN_JSON" >> $GITHUB_OUTPUT

echo "$MARKDOWN" >> $GITHUB_STEP_SUMMARY
