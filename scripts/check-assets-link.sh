#!/bin/bash
set -euo pipefail

# The tutorial links SolarSystem-Assets.zip straight from its GitHub release
# instead of republishing 305 MB through Pages, so the build no longer needs
# the file itself -- only the assurance that the link still resolves.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPOSITORY="$(cat "$REPO_ROOT/repository.txt")"
ASSET_URL="https://github.com/$REPOSITORY/releases/download/assets-v2/SolarSystem-Assets.zip"

status="$(curl --silent --show-error --location --max-time 60 --range 0-0 \
    --output /dev/null --write-out '%{http_code}' "$ASSET_URL")"

case "$status" in
    200|206) printf 'Asset link OK (%s): %s\n' "$status" "$ASSET_URL" ;;
    *) printf 'Asset link failed (%s): %s\n' "$status" "$ASSET_URL" >&2; exit 1 ;;
esac
