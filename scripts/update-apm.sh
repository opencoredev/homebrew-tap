#!/usr/bin/env bash
# Regenerates Formula/apm.rb for one apm CLI release from what apmjs.dev serves.
#
#   scripts/update-apm.sh          # the newest version in https://apmjs.dev/cli/releases.txt
#   scripts/update-apm.sh 0.1.3    # a given version
#
# It reads the version's SHA256SUMS, checks that every line agrees with releases.txt, downloads
# each binary the formula uses and checks its SHA-256, and only then writes the formula.
set -euo pipefail

site="${APM_SITE:-https://apmjs.dev}"
root="$(cd "$(dirname "$0")/.." && pwd)"
formula="${root}/Formula/apm.rb"
targets=(darwin-arm64 darwin-x64 linux-arm64 linux-x64)

die() {
  printf 'update-apm: %s\n' "$1" >&2
  exit 1
}
hash256() { if command -v sha256sum >/dev/null; then sha256sum "$1"; else shasum -a 256 "$1"; fi | awk '{ print $1 }'; }

index=$(curl -fsSL "${site}/cli/releases.txt") || die "could not read ${site}/cli/releases.txt"
version="${1:-$(printf '%s\n' "${index}" | awk '{ print $1 }' | sort -uV | tail -n 1)}"
[[ "${version}" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$ ]] || die "not a version: ${version}"

sums=$(curl -fsSL "${site}/cli/${version}/SHA256SUMS") || die "apm ${version} has no SHA256SUMS, so it is not released"
tmp=$(mktemp -d)
trap 'rm -rf "${tmp:?}"' EXIT

for t in "${targets[@]}"
do
  want=$(printf '%s\n' "${sums}" | awk -v n="apm-${t}" '$2 == n { print $1 }')
  [[ -n "${want}" ]] || die "apm ${version} has no apm-${t} in SHA256SUMS"
  listed=$(printf '%s\n' "${index}" | awk -v v="${version}" -v t="${t}" '$1 == v && $2 == t { print $3 }')
  [[ "${listed}" = "${want}" ]] || die "releases.txt says ${t} is '${listed}', SHA256SUMS says ${want}"
  curl -fsSL -o "${tmp}/apm-${t}" "${site}/cli/${version}/apm-${t}" || die "could not download apm-${t}"
  got=$(hash256 "${tmp}/apm-${t}")
  [[ "${got}" = "${want}" ]] || die "apm-${t} SHA-256 is ${got}, SHA256SUMS says ${want}"
  printf -v "sha_${t//-/_}" '%s' "${want}"
done

cat >"${formula}" <<EOF
class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "${version}"
  license "MIT"

  livecheck do
    url "${site}/cli/releases.txt"
    regex(/^v?(\d+(?:\.\d+)+)\s/i)
  end

  on_macos do
    on_arm do
      url "${site}/cli/${version}/apm-darwin-arm64"
      sha256 "${sha_darwin_arm64}"
    end
    on_intel do
      url "${site}/cli/${version}/apm-darwin-x64"
      sha256 "${sha_darwin_x64}"
    end
  end

  on_linux do
    on_arm do
      url "${site}/cli/${version}/apm-linux-arm64"
      sha256 "${sha_linux_arm64}"
    end
    on_intel do
      url "${site}/cli/${version}/apm-linux-x64"
      sha256 "${sha_linux_x64}"
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

printf 'Formula/apm.rb: apm %s\n' "${version}"
