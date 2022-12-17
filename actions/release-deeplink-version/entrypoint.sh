#!/bin/sh
set -e
cd $GITHUB_WORKSPACE

TOOLPATH="$1"
VERSION="$2"
TARGET_BRANCH="$3"

CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "" ]; then
  CURRENT_BRANCH=$(git name-rev --name-only HEAD)
fi

if [ "$TARGET_BRANCH" = "" ]; then
  TARGET_BRANCH="$CURRENT_BRANCH"
fi

echo "current-branch=$CURRENT_BRANCH"
echo "target-branch=$TARGET_BRANCH"

if [ "$TARGET_BRANCH" != "$CURRENT_BRANCH" ]; then
  git fetch origin "$TARGET_BRANCH"
  git branch -f "$TARGET_BRANCH" "$CURRENT_BRANCH" # reset target branch from current branch
  git checkout "$TARGET_BRANCH"
fi


$(dirname $0)/version-e2e-set "$TOOLPATH" "$VERSION"

git add --all

if [ -n "$(git diff-index HEAD --)" ]; then
  git commit -m "chore: link to $VERSION"
else
  echo "no changes to commit"
fi

git remote set-url --push origin https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push -f origin $TARGET_BRANCH