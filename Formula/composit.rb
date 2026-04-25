class Composit < Formula
  desc "Governance-as-Code for AI-generated infrastructure"
  homepage "https://nuetzliches.github.io/composit"
  license "MIT"
  version "0.3.2"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-apple-darwin.tar.gz"
      sha256 "3cb7b402ecc309b674c3160d8d5d973c0e2472ba8f566fbb4cdb9e468671892c"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-apple-darwin.tar.gz"
      sha256 "41f4680d49ea7aec239395f3519e58fec6cd29cc44e7230532d3d454d52e66a6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0f1641872bdc883bfe3fcda87fb8517286647337db1bd4df0f0f3d74e38f2f48"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a337a98031e9b489795710fcea1134f87e4aec76aff7bf5c7c0cc6ff0d71ce3d"
    end
  end

  def install
    bin.install "composit"
  end

  test do
    assert_match "composit", shell_output("#{bin}/composit --version")
  end
end
