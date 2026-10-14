# Draftboard (fork of Graphite)

This repo is a fork of [GraphiteEditor/Graphite](https://github.com/GraphiteEditor/Graphite). Upstream code, licences (MIT OR Apache-2.0) and attribution are unchanged. Upstream's own README is `README.md`.

## What the fork adds
- `.github/workflows/draftboard-wasm.yml` builds the web editor on GitHub-hosted runners.
  - Each master build is published as an immutable prerelease `wasm-<sha12>`, and the rolling `wasm-latest` is refreshed in place.
  - Every release carries `pkg.tar.gz`, `dist.tar.gz` and `SHA256SUMS`.
  - Actions are pinned to commit SHAs. Only the publish job can write.
- `.cursor/setup.sh` runs `npm ci` and installs the prebuilt WASM after checking its sha256.
  - Set `DRAFTBOARD_WASM_TAG=wasm-<sha12>` to pin a specific build.

## Upstream-only workflows
Build, Check (build/test), Provide Shaders, Website and the comment bots need upstream's self-hosted runners or secrets. They're guarded with `if: github.repository == 'GraphiteEditor/Graphite'`, so on this fork they show as skipped.

## Local dev
```sh
bash .cursor/setup.sh
cd frontend && npx vite
```
