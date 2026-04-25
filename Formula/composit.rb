class Composit < Formula
  desc "Governance-as-Code for AI-generated infrastructure"
  homepage "https://nuetzliches.github.io/composit"
  license "MIT"
  version "0.4.0"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-apple-darwin.tar.gz"
      sha256 "713bb001147934cd06b46b042c3ad9dea9ee3d78980d4be9c14e0ec4519b3ef0"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-apple-darwin.tar.gz"
      sha256 "7cdcf113dff0dcef2445d215d25007abf59248d18f5db546a7ab2355533eaf9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c1b815c2f70b8706d5ede0d00e9b26f7b46007ce38130c466b38a2ae6a76a496"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2751cb802d714b550ea20d1b7a8bb6f0a469086e82c6cb565b3b89628f268d32"
    end
  end

  def install
    bin.install "composit"
  end

  test do
    assert_match "composit", shell_output("#{bin}/composit --version")
  end
end
