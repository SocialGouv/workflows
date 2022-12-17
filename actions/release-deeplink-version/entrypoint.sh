#!/bin/sh
set -e
cd $GITHUB_WORKSPACE
TOOLPATH="$1"
VERSION="$2"
$(dirname $0)/version-e2e-set "$TOOLPATH" "$VERSION"
git add --all
git commit --amend --no-edit
git remote set-url --push origin https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push -f --follow-tags origin master