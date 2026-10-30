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
  version "0.31.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.31.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "85971b8f8f895812e0f70c511373a277bbd6b86be145cef18684b4a834470f88"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.31.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "c23f8ccdad7f22e8ec122fc4aae50bca506446121b129c986d65725269a40bce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.31.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9d1039f1054cbe5c9aaa9d0197452f152df50b79cd6190a8720abb013ee44a36"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.31.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "15b3c841d5ce0ad5b36e0afbedddcf4e8bf00ecf474bda208b6c82e42d7d72da"
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
