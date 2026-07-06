# typed: false
# frozen_string_literal: true

# This formula lives in the nuetzliches/homebrew-tap tap.
# Install with:
#   brew install nuetzliches/tap/croniq
#
# The SHA256 values and version are updated automatically by the release
# workflow on every tagged release.

class Croniq < Formula
  desc "Distributed job scheduler with cron, calendar, and runner support"
  homepage "https://github.com/nuetzliches/croniq"
  version "0.22.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-apple-darwin.tar.gz"
      sha256 "2e553cb38c1c7fa236837050e55bc4972b53da49fbf358b08474c9eb9e40016d"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-apple-darwin.tar.gz"
      sha256 "b0d89e4f9b2f375298c1fcfcf08dcee4e528232b944b3c39455bcdf62857d80d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bbfd7cc4f341bc0476eb4f8abbb8b676b1113c65209d2f1517f8fcaeec059262"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c2c1051635d5a2a87d1444afd99b0beda91f76930ce4f356ac39a258599de61"
    end
  end

  def install
    bin.install "croniq-server"
    bin.install "croniq"
    bin.install "croniq-mcp"
    bin.install "croniq-demo-runner"
  end

  service do
    run [opt_bin/"croniq-server", "--config", etc/"croniq/Croniqfile",
         "--data-dir", var/"croniq", "--listen", ":4000"]
    keep_alive true
    log_path var/"log/croniq.log"
    error_log_path var/"log/croniq.log"
    environment_variables RUST_LOG: "info"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/croniq --version")
  end
end
