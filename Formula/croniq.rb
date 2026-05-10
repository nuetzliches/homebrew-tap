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
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-apple-darwin.tar.gz"
      sha256 "1e7e7ca4fcd72cb549414e79e629f8331e8e7e0272861e64cf83e3bd2d754e24"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-apple-darwin.tar.gz"
      sha256 "62aa2f0dfd29c4c71526765dbf1785981de0525cd61cdefa6db913dd3295a64c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b774d1bac23c4073e0b8363701412cbdae9e0ba23044f5643dd5783c5dfea11"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e84cc37a4e4c8362168d6f45dd13d7fcc16a3b65e22293a2bf7e1e12255dba5a"
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
