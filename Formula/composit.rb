class Composit < Formula
  desc "Governance-as-Code for AI-generated infrastructure"
  homepage "https://nuetzliches.github.io/composit"
  license "MIT"
  version "0.2.1"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-apple-darwin.tar.gz"
      sha256 "e5f2cd9d959a54b981557e4eebc446382d880aa815c60587e822def6a2e6931c"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-apple-darwin.tar.gz"
      sha256 "71cd62c6ce92a33dc6725e8bc95dfdbe2d14a899e4a2786a07aa5c1a57b068bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ba1606f96e7c9f131b6caa1a3e76ac090dfb66f426682fdd77d4bb3135daaceb"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f05e059f705328adb8a2c3e5a255d56347a155355eb66e206a78fd189d1eefbe"
    end
  end

  def install
    bin.install "composit"
  end

  test do
    assert_match "composit", shell_output("#{bin}/composit --version")
  end
end
