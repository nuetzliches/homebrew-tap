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
  version "0.41.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.41.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "1eba3d35113b9959a9cf5f87e5046693a61d9ba590c7929ea9ae47a667218362"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.41.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "c01cb4147ed5bb309fa4c3b3621ec706ffd850a43b0b2763fa62f745fe9b37ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.41.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4f429ad112e24592741f2577d4b8c6bcd40a5399b1f1b6726cd9154769013602"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.41.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "808a043a3c81a0c9cd613798493f8e656b1b85f0b175abbd0a0a0e07d07c76a5"
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
