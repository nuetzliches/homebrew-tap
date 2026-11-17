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
  version "0.49.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.3/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "da463622dc01d4ad2b02aeb3a061311e678f5c4e8dba797ec8e045ed3c84772e"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.3/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "c03118b4815d1a9d3facbae86a8ff31adbba8ef0a6b401138f05ccabce387773"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.3/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "feaf8e23ca06082d12de8905d45b0730741b3d587d00c6f2271acf3e2abcff97"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.3/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bb23d63082514261dad71832469097485287bc212d34fa759363eeb8494b0a76"
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
