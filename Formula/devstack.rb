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
  version "0.32.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.32.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "95dea87a1dd1e988103f5e31deaa6d5bfd664be1c5d6c6a9981cca21118e01a0"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.32.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "1f77941f5fbe4c2d0de0c271e5da19cf44bb0a597e82513c350885abc324bc6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.32.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d60708511387a6bdf16034b219066bde1ce216127fe823bd74d077455b4f2a45"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.32.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c242765c6e016b83cff12eace29d15da312c76357b1a0a085148f2360430dacb"
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
