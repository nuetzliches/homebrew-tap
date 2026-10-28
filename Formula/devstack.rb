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
  version "0.28.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.28.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "e8aab16c3ebb87e829991adc9cea76e1c70cb0ca97d7c70ccab720bc9c56f2e2"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.28.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "9a3359612bbf34687941a5e78c7a7b57d3b8da374aa6b6e0247b9881f247bcf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.28.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4c0a08d8b39b50f867e622c7c96ba0e0d72c36f8fd7ad19dd4b43c478cab8978"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.28.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "10bd7aa44af08264cc57fe7b5ca07940c789bef2b85a278ff607c9abe6d817bd"
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
