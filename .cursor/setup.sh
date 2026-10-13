#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../frontend"
npm ci
mkdir -p wrapper/pkg
curl -sSfL https://github.com/hashflow67-cmyk/Graphite/releases/download/wasm-latest/pkg.tar.gz | tar xz -C wrapper/pkg
