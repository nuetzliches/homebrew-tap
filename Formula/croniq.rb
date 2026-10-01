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
  version "0.44.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-apple-darwin.tar.gz"
      sha256 "098cfd5ad4797f818bf1f6c223578aac6439fedb855e60fb91884446e372d42d"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-apple-darwin.tar.gz"
      sha256 "b960eeab391e978fbc28e07f67d5999f04a21a7890bda57e641384fa2f818f09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e776a63f5b9cf8c239e44d5be2359cd6b6d9fa046016dbd42d982cbd2129e993"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85b9b1b3bf8a635215cd40a72fab5f5d707409daf13109ab49b257e7c6a11315"
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
