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
  version "0.27.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.27.1/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "ec936b2df6c4214d8e8dcc4877b681a8b8527dfabd11d5118f2680de3e357529"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.27.1/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "ea0de77334aa08670ab0cc6c0993cf9dbc863bcd9f5ff5633a0625841f188958"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.27.1/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f97e95a0df431f1363a57ef3f45c0fff3f32ee78fe0bf468fb2e2fba97ac988c"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.27.1/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "468b4e92a11a81a394ea85392ae2de96606c22326bfc48288395e9df77ad95de"
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
