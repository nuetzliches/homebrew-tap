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
  version "0.25.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-apple-darwin.tar.gz"
      sha256 "b3aad41af26c19ebc160d947aa62891ebbb90cbed86aeb59065bb9fadf8eef2e"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-apple-darwin.tar.gz"
      sha256 "3e98dd15052996a05b7576935b3e33b02fcf459667e1ae392629fe0c5bf81ee7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "90988e58e5edaf41e10bf4b5e958b988c38ab118184410923a1545044a5257e9"
    end
    on_intel do
      url "https://github.com/nuetzliches/croniq/releases/download/v#{version}/croniq-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a33028c3cd7020a8dc9a7b47d7ca494b0365ebe397247314e6b68565065aa39b"
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
