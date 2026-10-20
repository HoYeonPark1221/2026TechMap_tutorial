#!/bin/bash
set -uo pipefail

# The tutorial links SolarSystem-Assets.zip straight from its GitHub release
# instead of republishing 305 MB through Pages, so the build no longer needs
# the file itself -- only the assurance that the link still resolves.
#
# A dead link fails the build. A network hiccup only warns: a docs build that
# touches no asset shouldn't be held hostage by a slow connection.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPOSITORY="$(cat "$REPO_ROOT/repository.txt")"
ASSET_URL="https://github.com/$REPOSITORY/releases/download/assets-v2/SolarSystem-Assets.zip"

status="$(curl --silent --location --max-time 60 --range 0-0 \
    --output /dev/null --write-out '%{http_code}' "$ASSET_URL")"
curl_exit=$?

if [[ $curl_exit -ne 0 ]]; then
    printf 'Asset link not checked (curl exit %s): %s\n' "$curl_exit" "$ASSET_URL" >&2
    exit 0
fi

case "$status" in
    200|206)
        printf 'Asset link OK (%s): %s\n' "$status" "$ASSET_URL"
        ;;
    000)
        printf 'Asset link not checked (no response): %s\n' "$ASSET_URL" >&2
        ;;
    *)
        printf 'Asset link is broken (HTTP %s): %s\n' "$status" "$ASSET_URL" >&2
        exit 1
        ;;
esac
