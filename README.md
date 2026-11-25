# opencoredev/homebrew-tap

Homebrew formulae from opencoredev.

## apm

[apm](https://apmjs.dev) checks npm packages before you install them.

```sh
brew install opencoredev/tap/apm
apm --version
```

The formula installs the same standalone binaries as `curl -fsSL https://apmjs.dev/install | sh`, from `https://apmjs.dev/cli/<version>/`, checked against each release's SHA-256. It covers macOS (Apple silicon and Intel) and Linux (x64 and arm64).

## Updating

The Update apm workflow checks `https://apmjs.dev/cli/releases.txt` every 6 hours and commits a new formula when a release appears, after installing and testing it. To update right away, run the workflow from the Actions tab, or locally:

```sh
scripts/update-apm.sh          # newest release
scripts/update-apm.sh 0.1.3    # a given version
```

A release can also trigger it with a `repository_dispatch` event of type `apm-release` (optional payload `{"version": "x.y.z"}`).
