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
  version "0.40.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.40.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "54c1e416e83e2f525b83e3462d11df7d55b842684108afbe58ee9789067a1d2c"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.40.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "c3675d07a6f5cbc1ac9bbf418af8bd06fa333a2e5cb38aa63089d451ae4b0f81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.40.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6abca8ba2432db91d2feabf175ee2085de8012d301601c04529bed7951e2df87"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.40.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f5ee151ac5fc50847beca6bba008d2a8703552353eebfca7cdfb38e27489f095"
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
