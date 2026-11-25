class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.1/apm-darwin-arm64"
      sha256 "fee67fa4221cb6a40c7af42426636dd803659c53747db2855393872f87ebfe46"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.1/apm-darwin-x64"
      sha256 "77a5420c92969487411e54983b17d5e56b547c8328052f231b7f15624310797d"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.1/apm-linux-arm64"
      sha256 "58fe909d66aa8ea88c548b517b7481bad867b609c16e6db19280bcb4eb7b73c3"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.1/apm-linux-x64"
      sha256 "776824719d8ac062fdf432b7373d2eaf36e56fc22ca55f5b6faf7e22531389a7"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
