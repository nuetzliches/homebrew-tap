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
  version "0.26.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.26.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "f9c8aee36aac13fd0305956be1c0c5fbb2722a0e89ab59cf11454e052c4f2145"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.26.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "75ea2bf1637e3391ba99fdd71ee1200147e1d5c34a5332bcb531842a1fcadef2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.26.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9f0cd174c26492cb0904ff932c8c156a01da34a0ce48be6783aa5c72a0774adc"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.26.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7a78436633f3019b3e01b2244c511aaeb59455b2710c791594c6e6a8b86f656a"
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
