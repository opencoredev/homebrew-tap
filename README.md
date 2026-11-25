# opencoredev/homebrew-tap

Homebrew formulae from opencoredev.

## apm

[apm](https://apmjs.dev) checks npm packages before you install them.

```sh
brew install opencoredev/tap/apm
apm --version
```

The formula installs the same standalone binaries as `curl -fsSL https://apmjs.dev/install | sh`, from `https://apmjs.dev/cli/<version>/`, checked against each release's SHA-256. It covers macOS (Apple silicon and Intel) and Linux with glibc (x64 and arm64). On Alpine or other musl systems use the curl installer.

## Updating

Each production release of the apm CLI (`packages/infra/release-cli.ts` in opencoredev/apmjs) starts the Update apm workflow with its version. The workflow installs and tests the new formula on macOS (arm64, Intel) and Linux (x64, arm64) and commits it only if all four pass. Run it from the Actions tab, or locally:

```sh
scripts/update-apm.sh          # newest release
scripts/update-apm.sh 0.1.3    # a given version
```

A release can also trigger it with a `repository_dispatch` event of type `apm-release` (optional payload `{"version": "x.y.z"}`).
