#!/bin/zsh
set -e
cd "$(dirname "$0")"

echo "Paste new GitHub repository URL (example: https://github.com/<user>/<repo>.git):"
read REPO_URL

if [[ -z "$REPO_URL" ]]; then
  echo "Repository URL is required."
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REPO_URL"
else
  git remote add origin "$REPO_URL"
fi

git push -u origin main

echo "Done."
echo "If GitHub Pages is enabled (branch: main, folder: /(root)), your site URL will be:"
echo "https://$(echo "$REPO_URL" | sed -E 's#https://github.com/([^/]+)/([^/.]+)(\.git)?#\1.github.io/\2/#')"
read -k 1 "?Press any key to close..."
echo
