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
  version "0.49.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.1/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "c248fd111b961f7a39a8eae81ea6d3d27d5945a5339b83f4413a3da66d2a45c4"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.1/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "e7bd8ef75d9e0a1db1074290c7f0413aa75a0255cda0314f299ff9bb2eea45ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.1/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d180d067b651efb2f8454ba7a2df7001fa141d98d94e7b20e5f131296a2bfa72"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.1/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8beecd9bf80264e6c23b9a4cad9b157bee94953446aa7e220767bdd7b4bc65bd"
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
