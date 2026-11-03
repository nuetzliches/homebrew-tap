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
  version "0.35.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.35.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "d47b73a1c8584335bc0f09902b5a83458536b136b986da4e89dd57e85d1db965"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.35.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "f6f3cbea7169214961b63ea8139fe576a7d3136649249f720a3db92522c0de0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.35.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e03dce5751d8b225d987a1f986dbf556eecd5733b5c8403cc098e016261a02f2"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.35.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "26494927388702b9c0b71e87cc4dbaa91cf9a58ee581040d5c7d77a63b0d3144"
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
