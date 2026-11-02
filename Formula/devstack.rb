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
  version "0.34.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.34.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "d8c5b3bb4677542e34cc17f21eee5390a5be3b3dbec2dbe49d380424511ced88"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.34.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "1814a83c330336747e6249f2acb4f964f67ca093ab024f507f5d80aa2574734e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.34.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "945b7b865ec88ac280294f10dfb698ff37e5f0d6ddd60a255ef00ebd3001dbbf"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.34.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8a48946b5acd1ee8bb05a6d67bb8bd80c8654f6266dc4fd660ad3f3354fc19bd"
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
