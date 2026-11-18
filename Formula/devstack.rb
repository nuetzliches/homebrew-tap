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
  version "0.50.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.50.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "35ad31f0778f0a2767e459bcf7b277d012472ba1f92eaded353716624942ff4d"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.50.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "64651e848fec8866bdb8e13de0913e89f75d6662b79b6bfcf285716f71d07887"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.50.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "043ae8f7a451a48117c7929ffd2b17729bf71b91547f885cc9df4ae923a2b95c"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.50.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "abbec70f18027ad05ffa909e5e2e3aecac9d07a62debf6f7b29199687f8282f7"
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
