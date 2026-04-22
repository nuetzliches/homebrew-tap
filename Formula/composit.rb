class Composit < Formula
  desc "Governance-as-Code for AI-generated infrastructure"
  homepage "https://nuetzliches.github.io/composit"
  license "MIT"
  version "0.2.0"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-apple-darwin.tar.gz"
      sha256 "fc76960bb5a3717997ae31655b136b81965fb1bfdd1a668da5e473b5c43a5379"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-apple-darwin.tar.gz"
      sha256 "172961ae92aeaa6da884b389d91b7df2cce89307e02acb059210d3baf9772b26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8ff26c2b10a443f737ea867ccbf746d6ca0a747881cab20c08b077b38c65e428"
    end
    on_intel do
      url "https://github.com/nuetzliches/composit/releases/download/v#{version}/composit-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a8193e25eada25ba5197cf9bc5e9ff65284edad9ec3c71bf6700f78c2fcaa109"
    end
  end

  def install
    bin.install "composit"
  end

  test do
    assert_match "composit", shell_output("#{bin}/composit --version")
  end
end
