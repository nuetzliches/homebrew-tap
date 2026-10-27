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
  version "0.25.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.25.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "c8f37e4d3cf680caf2642fae148b5d21b048548ad35b232d3829e979a905261c"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.25.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "2dbe1ee1449f5824436544403dd1b1ef85b7bdf76dc33452ab0d403d95fccd86"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.25.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3c4cd54e885d73125bd3762e4f234fac07a26d8590ef362b3686ce8175cf5ad1"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.25.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "56ae098b91aa9a0306b89ca3754d94f73cdefcb968799e57c5a1ef86a7fd05b3"
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
