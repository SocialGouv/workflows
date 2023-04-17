#!/bin/sh
set -e

MANIFESTS_PATH="$1"

IMAGES=$(cat $MANIFESTS_PATH | /app/manifests-images)

echo "images=$IMAGES" >> $GITHUB_OUTPUT