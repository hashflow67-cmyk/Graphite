#!/usr/bin/env bash
# Installs frontend deps and the prebuilt Draftboard WASM package, verified by sha256.
# DRAFTBOARD_WASM_TAG=wasm-<sha12> pins an immutable per-commit build (default: wasm-latest).
set -euo pipefail
REPO="${DRAFTBOARD_REPO:-hashflow67-cmyk/Graphite}"
TAG="${DRAFTBOARD_WASM_TAG:-wasm-latest}"
BASE="https://github.com/$REPO/releases/download/$TAG"

cd "$(dirname "$0")/../frontend"
npm ci

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

fetch_and_verify() {
  curl -sSfL -o "$tmp/SHA256SUMS" "$BASE/SHA256SUMS"
  curl -sSfL -o "$tmp/pkg.tar.gz" "$BASE/pkg.tar.gz"
  (cd "$tmp" && grep ' pkg.tar.gz$' SHA256SUMS | sha256sum -c -)
}

# One retry covers the short window while wasm-latest assets are being swapped.
if ! fetch_and_verify; then
  echo "Checksum check failed for $TAG; retrying in 30s..." >&2
  sleep 30
  fetch_and_verify
fi

rm -rf wrapper/pkg
mkdir -p wrapper/pkg
tar xzf "$tmp/pkg.tar.gz" -C wrapper/pkg
echo "Installed Draftboard WASM from $REPO@$TAG (sha256 verified)"
