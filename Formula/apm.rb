class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.4/apm-darwin-arm64"
      sha256 "898d20cded3ce97aca7968fd9c56144dcade77c8573c8302c365943c310cb485"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.4/apm-darwin-x64"
      sha256 "66d84d00ff0926d73c7cbd20b3b826322589481cfc201ceb929817852afef20c"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.4/apm-linux-arm64"
      sha256 "914be2e0d528a6405d082dd491fe11924ad53f38f52399e3c8cbb855102f83e2"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.4/apm-linux-x64"
      sha256 "fc153f7b7d216e15e1c3a48edb5d53f1ef5dd93d5a702d5cd8ae0ad731d3505b"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
