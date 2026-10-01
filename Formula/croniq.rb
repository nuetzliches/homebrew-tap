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
  version "0.43.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-apple-darwin.tar.gz"
      sha256 "5e84381635a67509a41a33235de0bccf14ea337ec87076a3b99afd4f1b510a1b"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-apple-darwin.tar.gz"
      sha256 "9c40dc6f377dd8c699b1a252259480b8ed713d2d924c2744039cb8bf74dd1047"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5f1120073f916f7407f6f87af444514df628633d3b735da18badf0066bb38eba"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dfa823d6b9889b819df9c4410165a178012e613ebf9b5e4944ae472a946d3c8a"
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
