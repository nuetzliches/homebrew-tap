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
  version "0.24.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.1/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "9c8bf3fb30e1b9ff05780e1df478f3a2fe4ab94625ba8a38692fa26e25eb0cf0"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.1/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "c08de3a031321d951fc3bf7d307eb3d48c41f579aeddba5614e1d82a2f13fc5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.1/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6395e3617c881ee49f1d18f2cf0e30fbe7629b43738dc9c2eb142ec77a28dd2e"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.24.1/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "017cd2fbee79e15b8face0706bcef1f4f659bf8f2a727840c76f41eb72586292"
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
