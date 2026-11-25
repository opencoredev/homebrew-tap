class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.6/apm-darwin-arm64"
      sha256 "f6b8f673bbf83e307407d2387ce8ee9252ea3a50ca610a52a8d01893478029cf"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.6/apm-darwin-x64"
      sha256 "14faa870dd1028cb190847300c92dbbfad90857e8dbb4936644f86e3ff54892e"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.6/apm-linux-arm64"
      sha256 "f9b25d0b6db20b49cc78829babb1c09f0d62c8b4aa35de3876b039ee19e9c0f9"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.6/apm-linux-x64"
      sha256 "a06e76962c6b88f8c0240af1e91a7c0725d951d0b8f8b4da6a24bc59bbd5644d"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
