class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.3/apm-darwin-arm64"
      sha256 "182a07712d3dfb360e48ee52e75e186f8d85ec72d52e5f1ca15d8affbc0d316d"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.3/apm-darwin-x64"
      sha256 "c4a3850a9e9ba58da2bbc2c6bed09300535b0d07e3e0a4384818449268409277"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.3/apm-linux-arm64"
      sha256 "8fe21329d2c978210aae249a4fac563dfe3072bf032ae2ce1ab7a52559b5c052"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.3/apm-linux-x64"
      sha256 "88bcbe520a864451361ba736d15fe4e7af7df4038b91c42aef9ca1e2961d7e1e"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
