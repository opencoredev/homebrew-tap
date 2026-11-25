class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.2/apm-darwin-arm64"
      sha256 "b366c93a0211573068a2dee13dd64067653bc8578b03826012ea38355176feae"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.2/apm-darwin-x64"
      sha256 "29493773f3bd3228efcbf4e4db37b53964dce9f7a2e805a788867ab12d284c78"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.2/apm-linux-arm64"
      sha256 "3b47812063a46574e1534de4e79f0105bd86c900b59feb18bbf4382187a68f0e"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.2/apm-linux-x64"
      sha256 "73f1fdb7ef73d700dcb329135a18ed176923f1e6a0b574e4be01983d8604a503"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
