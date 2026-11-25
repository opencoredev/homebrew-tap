#!/usr/bin/env bash
# Regenerates Formula/apm.rb for one apm CLI release from what apmjs.dev serves.
#
#   scripts/update-apm.sh                      # the newest stable x.y.z in https://apmjs.dev/cli/releases.txt
#   scripts/update-apm.sh 0.1.3                # a given stable version
#   scripts/update-apm.sh --force 0.2.0-rc.1   # allow a prerelease or a downgrade
#
# Without --force, a version older than the formula's leaves the formula as it is and exits 0.
#
# It reads the version's SHA256SUMS, checks that every line agrees with releases.txt, downloads
# each binary the formula uses and checks its SHA-256, and only then writes the formula.
set -euo pipefail

site="${APM_SITE:-https://apmjs.dev}"
root="$(cd "$(dirname "$0")/.." && pwd)"
formula="$root/Formula/apm.rb"

die() {
  printf 'update-apm: %s\n' "$1" >&2
  exit 1
}
hash256() {
  if command -v sha256sum >/dev/null; then sha256sum "$1"; else shasum -a 256 "$1"; fi | awk '{ print $1 }'
}
newer() { [ "$(printf '%s\n%s\n' "$1" "$2" | sort -t. -k1,1n -k2,2n -k3,3n | tail -n 1)" = "$1" ]; }

index=$(curl -fsSL "$site/cli/releases.txt") || die "could not read $site/cli/releases.txt"
current=$(awk -F'"' '/^  version /{ print $2 }' "$formula" 2>/dev/null || true)

force=false
if [ "${1:-}" = "--force" ]; then
  force=true
  shift
fi

if [ -n "${1:-}" ]; then
  version="$1"
  [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$ ]] || die "not a version: $version"
  if [ "$force" = false ] && ! [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    die "$version is a prerelease; pass --force to put it in the formula"
  fi
else
  version=$(printf '%s\n' "$index" | awk '$1 ~ /^[0-9]+\.[0-9]+\.[0-9]+$/ { print $1 }' | sort -u -t. -k1,1n -k2,2n -k3,3n | tail -n 1)
  [ -n "$version" ] || die "releases.txt lists no stable version"
fi

if [ "$force" = false ] && [[ "$current" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] && [ "$version" != "$current" ] && ! newer "$version" "$current"; then
  printf 'Formula/apm.rb: keeping apm %s; %s is older (pass --force to downgrade)\n' "$current" "$version"
  exit 0
fi

sums=$(curl -fsSL "$site/cli/$version/SHA256SUMS") || die "apm $version has no SHA256SUMS, so it is not released"
tmp=$(mktemp -d)
trap 'rm -rf "${tmp:?}"' EXIT

check() {
  local t="$1" want listed got
  want=$(printf '%s\n' "$sums" | awk -v n="apm-$t" '$2 == n { print $1 }')
  [ -n "$want" ] || die "apm $version has no apm-$t in SHA256SUMS"
  listed=$(printf '%s\n' "$index" | awk -v v="$version" -v t="$t" '$1 == v && $2 == t { print $3 }')
  [ "$listed" = "$want" ] || die "releases.txt says $t is '$listed', SHA256SUMS says $want"
  curl -fsSL -o "$tmp/apm-$t" "$site/cli/$version/apm-$t" || die "could not download apm-$t"
  got=$(hash256 "$tmp/apm-$t")
  [ "$got" = "$want" ] || die "apm-$t SHA-256 is $got, SHA256SUMS says $want"
  printf '%s' "$want"
}

darwin_arm64=$(check darwin-arm64)
darwin_x64=$(check darwin-x64)
linux_arm64=$(check linux-arm64)
linux_x64=$(check linux-x64)

cat >"$formula" <<EOF
class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "$version"
  license "MIT"

  on_macos do
    on_arm do
      url "$site/cli/$version/apm-darwin-arm64"
      sha256 "$darwin_arm64"
    end
    on_intel do
      url "$site/cli/$version/apm-darwin-x64"
      sha256 "$darwin_x64"
    end
  end

  on_linux do
    on_arm do
      url "$site/cli/$version/apm-linux-arm64"
      sha256 "$linux_arm64"
    end
    on_intel do
      url "$site/cli/$version/apm-linux-x64"
      sha256 "$linux_x64"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
EOF

printf 'Formula/apm.rb: apm %s\n' "$version"
