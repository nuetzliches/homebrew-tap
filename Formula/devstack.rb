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
  version "0.49.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.2/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "8bf50daa1b5f90a5867f684786f64def3feac61a6901fd16e009362fc85084d5"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.2/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "a457725b539a77a4c351d22614527a27e63fb0e4ff340dd736cb3036664c2443"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.2/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2fa99eff7d06f89d6216f5f693954ba33727b33048fc802c72493e165769cb66"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.2/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a2184a037ce8d1640458910703292a8d1718fa8c277d429e8aa7f251ad65336f"
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
