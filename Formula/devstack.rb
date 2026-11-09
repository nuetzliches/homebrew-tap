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
  version "0.43.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.43.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "5a0cc1f0c65c2510b5c084f6550b61461e9b32682191ab7a2fcac534a5bf3321"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.43.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "0c9beabd3fc6e7a64a4aaf5c3df558fb3575f25a138fb0ce2d0ae2011e556f06"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.43.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fec3b381093cff973985553685c5f2fca2ebffc4e132195c0699f80b72865a16"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.43.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5f95f4ff73aac1cf0a8a5dd7c9557698d1ba47070edfda560a65fb990be2a7b5"
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
