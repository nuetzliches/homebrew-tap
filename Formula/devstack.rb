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
  version "0.21.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.21.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "bf9c074ee0a44a97edf8dc20d4e60d77d67459e300b854b24ddf0de1eff98526"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.21.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "73ef0867b4f43c73ddaf56efd19fb83a620e2931d583731b191ead96b0412e93"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.21.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f8b0e8829575fcf177dcd1d862494897ea65f53f54449d418e579dbc76f8321d"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.21.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f177f9b079bdd545947bb560eaa1751785b330156803db57c6d9245cc1c191e7"
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
