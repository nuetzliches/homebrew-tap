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
  version "0.22.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.1/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "eff07635dae00815f87159cc472d31c01512b44a63a79a096155bffa8d0918f6"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.1/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "e07050f31e1516bfb1e62a81f4a41f0d77709f7ad228b4512695569cf8e0f56e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.1/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "540e1dcff2700e616332facc19bab53781ef01f957aaab89968ecd302434c003"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.1/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d05a0b9e30d391eaeab869d6f8a64db0d08e11ce02a684f7cd182da6986950f0"
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
