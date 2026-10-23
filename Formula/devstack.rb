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
  version "0.22.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "f2208ef2033958ee0a29bac90332dc35d35c3173017b01278b0662c467655498"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "7c8a288df61f0b8893eb9db1524c22f45011301f012a958c2b6ff669b7f64aaa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4ce02bd99d0f201ce2eac41b72892309f46493c1276206401501fab793884f92"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.22.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cdd304ce289d0ce210756c8aaef8a684142e805e46cc492b40032d70d4213e82"
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
