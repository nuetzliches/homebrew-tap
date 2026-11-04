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
  version "0.38.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.38.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "b18c1d16cbbe6381b7c5b79593c423c633a4c78fc9f7053f105f15ca7da22d0e"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.38.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "1e15ae1cb5be6f08db150d20de7a28b30726b891e267d8f8b50e34221f039c31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.38.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "069fa5df4d4cffe0f54e541153179860efb34c49aaeb62e99083492e1b699bd0"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.38.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "13036e94c52168a20df59affb5863b8fa7467b15cef2ff26f527a4744ae84be1"
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
