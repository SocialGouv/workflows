#!/bin/sh
set -e

cd $GITHUB_WORKSPACE

MANIFESTS_PATH="$1"

IMAGES=$(cat $MANIFESTS_PATH | ./manifests-images)

echo "images=$IMAGES" >> $GITHUB_OUTPUT