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
  version "0.42.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.42.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "0c3831b34bd99629d2aa51b6c50524f9ac310d5771bafc4cbf2afaff07be6fbe"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.42.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "99a35b45273ad5fa4dfc0578f9a23082f6d905309affb3a95ed6466515847d5e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.42.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ed60d834bad50d75fb1ba5b89f2c13825d7d846ae0b5208a8d4333db75984316"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.42.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "88955cd55faf0c27d5a7a0704fa92ae1e9854641dfe40da4791b9116ba60ea06"
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
