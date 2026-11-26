class Apm < Formula
  desc "Check npm packages before you install them"
  homepage "https://apmjs.dev"
  version "0.1.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://apmjs.dev/cli/0.1.9/apm-darwin-arm64"
      sha256 "d70d951c8dd1b068114b991831b28635c00651f72813e1d048ca25f64bdf2304"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.9/apm-darwin-x64"
      sha256 "33132e41951d0db3a20eb16b3fbb53b1805835700aeff8f545e124b6535416a3"
    end
  end

  on_linux do
    on_arm do
      url "https://apmjs.dev/cli/0.1.9/apm-linux-arm64"
      sha256 "252f41dd7d834749472403a1475a6b3ff3fb0e8b1090144ca4ce1f57b4349b3f"
    end
    on_intel do
      url "https://apmjs.dev/cli/0.1.9/apm-linux-x64"
      sha256 "8d8c884a13068851613c7d22751de68cd32588632a07ab3f3581894da327eb97"
    end
  end

  def install
    bin.install Dir["apm-*"].first => "apm"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/apm --version").strip
  end
end
