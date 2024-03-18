#!/bin/bash

set -e

export MANIFESTS="$1"
export PROVIDER="$2"

MARKDOWN=$(cat "${MANIFESTS}" | npx @socialgouv/parse-manifests --markdown)
TEXT=$(cat "${MANIFESTS}" | npx @socialgouv/parse-manifests --text)
JSON=$(cat "${MANIFESTS}" | npx @socialgouv/parse-manifests --json)

echo "${TEXT}"

MARKDOWN_JSON=$(jo result="$MARKDOWN")

echo "markdown-json=$MARKDOWN_JSON" >> $GITHUB_OUTPUT

manifests_images=$(echo $JSON | jq -c .images)

echo "manifests-images=$manifests_images" >> $GITHUB_OUTPUT

echo "$MARKDOWN" >> $GITHUB_STEP_SUMMARY
