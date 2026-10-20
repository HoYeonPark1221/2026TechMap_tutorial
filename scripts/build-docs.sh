#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPOSITORY="$(cat "$REPO_ROOT/repository.txt")"
BASE_PATH="${REPOSITORY##*/}"
"$REPO_ROOT/scripts/check-assets-link.sh"
mkdir -p "$REPO_ROOT/.build"
xcrun docc convert "$REPO_ROOT/SolarSystem.docc" \
    --output-path "$REPO_ROOT/.build/SolarSystem.doccarchive" \
    --fallback-display-name SolarSystem \
    --fallback-bundle-identifier org.spatialcomputingtechmap.solarsystemdocs \
    --transform-for-static-hosting \
    --hosting-base-path "$BASE_PATH" \
    --warnings-as-errors
python3 "$REPO_ROOT/scripts/prepare-site.py" "$REPO_ROOT/.build/SolarSystem.doccarchive" "$BASE_PATH"
printf 'Documentation built: %s\n' "$REPO_ROOT/.build/SolarSystem.doccarchive"
