class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.10/apm-darwin-arm64"
      sha256 "de9d8cc5ec8feb800e59bb1c793d312b2e7b307a57146dee500fcd2b6369fbdb"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.10/apm-darwin-x64"
      sha256 "e20d39bfd2c5e30f838e09a38f34b4dfaf5886d723c039f2c5570c1d0b6770f4"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.10/apm-linux-arm64"
      sha256 "96233f83542037ede05efe329d98162d6ea0a003aa394baa77e8a9d913e5e213"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.10/apm-linux-x64"
      sha256 "42f7ac97abf90de3133948621e30ffe3240cb74b93a25c19e5553e1eac52a8a9"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
