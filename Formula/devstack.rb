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
  version "0.52.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.52.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "0a91e49dd6bffcca888b5ca3d8d7eec29a53c5d6a28c81121f25bac2fb6a6db3"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.52.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "8f9ed11e7a83640deb1835ddea52ccb505eec254b6716fb9f8b717eba77150a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.52.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9c72437c10bfee1fad49cbf0bd1c8b432992c0c57cdaccdb197e7663d86363c4"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.52.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c93bd6066c747ee057e8b3be6055f55c365c55b3676c3653edaa7c4cfb99c3fa"
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
