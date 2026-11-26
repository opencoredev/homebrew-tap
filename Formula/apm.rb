class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.8/apm-darwin-arm64"
      sha256 "9ce985126e31a5135cb2df45075cb35aa9095013234fa65dc1a37a3d0246bc47"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.8/apm-darwin-x64"
      sha256 "256e5c862b4c5619b6d29881b24b1cd6a3bde789cfb8d0aaacdb2cb6084878ae"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.8/apm-linux-arm64"
      sha256 "fdcbc488dedbaeed357b70463d1efd7e727938827bd6e0d11880e28bfe7a82b1"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.8/apm-linux-x64"
      sha256 "1cc4de8253f542ce2cbf1b54c77b444582cfb940e0317f1d0479405f2c8e1258"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
