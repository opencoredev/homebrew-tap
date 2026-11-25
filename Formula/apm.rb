class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.5/apm-darwin-arm64"
      sha256 "de6abb9098d76d4a2a96cf66ff980d1789267a01cc5151fa0bbf12a5ae6ecb7f"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.5/apm-darwin-x64"
      sha256 "6c3f7fd07c9a6ca547078be729298a071861eb72ede642f3e5b8affdb410b702"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.5/apm-linux-arm64"
      sha256 "a98ce419b1d00114a766bc3e39d5c53dd3a523da5821126b63e83797db2fa29b"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.5/apm-linux-x64"
      sha256 "ba9a20c7d028d5ac44189bd950262b0fbfea011fa9aed30fd349136bacffa648"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
