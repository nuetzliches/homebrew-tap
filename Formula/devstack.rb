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
  version "0.44.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.44.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "bc0126f5b75c77ce0d98dd5fe22922a6eef674fa4cf91a5e0dd50bec458b540a"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.44.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "31e1ff55ff971ffcc5c49d41dc42dfd51a9650facf59f7c5441fb450a5902029"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.44.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "badaae1edbde1e58ff70486db886ed8343fa40c4979c5b2bfc43533c9b487faa"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.44.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a3497dc74bb0080f5c090038c47f9607f5b80247d2eceb999565dc5336ab8bb2"
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
