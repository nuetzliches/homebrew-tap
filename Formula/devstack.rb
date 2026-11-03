# Rendered from packaging/homebrew/devstack.rb in nuetzliches/devstack: the
# release workflow fills in the version and the checksums and pushes it to
# nuetzliches/homebrew-tap (release.yml, job homebrew-tap). Edit it there,
# not in the tap.
#
# A formula, not a cask: Homebrew puts no quarantine flag on what a formula
# installs, so Gatekeeper lets the unsigned binary run (ADR-0054). No
# `service` block: devstack registers its hub at login itself, for every
# install, and `brew services` would start a second one on the same port.
class Devstack < Formula
  desc "Local development orchestrator for a whole stack, its worktrees and containers"
  homepage "https://github.com/nuetzliches/devstack"
  version "0.36.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.36.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "1b06e82d6bf61eeefa0970c414ee8e739ced40af364951519a65590cf01a6c10"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.36.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "949e0d62af09485694a5251bcf75de9cf9fb9c6c304480b2723ad6c3b18b2e6f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.36.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9c0a4c933cd8c418f8355988ced237fdd301946c48a3f7cda402fdf00e0ae420"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.36.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4dc34c5099c75d09dee23349fb9efcba3fb23a926ec505372b7aef2ffa60881d"
    end
  end

  def install
    bin.install "devstack"
  end

  def caveats
    <<~EOS
      The dashboard hub starts at login once registered: by the first
      `devstack up`, or now with `devstack hub install`
      (DEVSTACK_NO_HUB_INTEGRATION=1 before either: never).
      `devstack update` and the dashboard's update run `brew upgrade devstack`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devstack --version")
  end
end
