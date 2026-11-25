class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.7/apm-darwin-arm64"
      sha256 "184df5a336b719a0b3fbd739e8f63aea47237538a1c82ceb92e6e90c337f04ae"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.7/apm-darwin-x64"
      sha256 "67e8e479ea1d84053945468bdcfa974d270ad509a48c5000567b5e70ca7484c4"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.7/apm-linux-arm64"
      sha256 "f99cf3b44167b8d5aee69169fe87b71561f5433bc196c44418152e8b38cb4e67"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.7/apm-linux-x64"
      sha256 "53ecd7530cd7a3d1ddbef7491227536e14b579edc8fddf78411e6e462c826267"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
