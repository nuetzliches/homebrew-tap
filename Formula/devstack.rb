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
  version "0.24.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "7a2043b624e8d20c2fed19de038b79a00310fab8d3aeb980399ea057c5a76ccf"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "2bf1f73da8578203aee4508b578435e96c5073c34bbd6176fcea9c0eb62d9ce2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8b6b06b9aee795d8e82016cff78f669a9dbb9501d82fc06b761210865a2424bc"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "386f1c584b0e3ce52d035feb12442c0877b2cf4cce0d38bca4267f0132ec9af6"
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
