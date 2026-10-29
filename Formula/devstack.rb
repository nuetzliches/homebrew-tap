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
  version "0.30.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.30.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "3e9476e948e127e8a26a142029424c9f753f4eef3ba9158be893e21377c6ba85"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.30.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "f10c80a9f23483d8b61153c189667ff889e5a2ac74fa1b75545285607ae020e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.30.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "183dc0c1de9737215645eb132417ab0d2f74c34b49a70af13e26deeae1f6fe0d"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.30.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5ae5629e3f0fc006c8f34d94c7a98098e45b12e103c8213d3dd16495f90c6ce6"
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
