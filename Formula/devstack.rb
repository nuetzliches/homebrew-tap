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
  version "0.46.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.46.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "f89d82f6f592085c41f5e115ca09ae33be1c078ef4761b1d55eb9d1567bba84e"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.46.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "a091cc175a1a69a0d9cdc6f4d4e815fd7288706cc443e960710e86459ed107df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.46.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "71ed84ab0ec6d7835aad54cbcda3cf9b7ecc5e8d7275ef4c57e2d5cc3ae5f422"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.46.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f828158b7195bc13f5c4d7f18f38e080f57eab98c940b1310c341ac0cd8e872e"
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
