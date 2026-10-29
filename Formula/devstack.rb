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
  version "0.29.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.29.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "53d63baedee84d2e7538434580b71fc55a45d419d28d7e0407094f100462fd3b"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.29.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "d9b9987ceed997d98cfd7b53f09c5e1c4407beefc852410b7cf4c25d3ff8720b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.29.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "61932358118fa7c28156ff28d475fb22a5a4bf4f94af34d1a5bf0ef6d3878e38"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.29.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1d78ae674198379cce20371ed0d9d53c33aa8cc99490d893a9f7540d4c8ff49a"
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
