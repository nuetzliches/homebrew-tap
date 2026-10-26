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
  version "0.23.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.23.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "1a35459f3550a5a4cb0f695e8bcd7412b860716c6a5a494ca2ef921eadeb9f43"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.23.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "686f141f302c4fbf84ca5bc3d81713c5bcd3660e839eebdd1378652521fde8ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.23.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a3173b9227d90a11523bcb41648766d161f428ccf5235bec9ac8f0119d4a10e3"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.23.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8bf9889ad3cf67cddc9afb01a615858df0f075ac87e1046abfe9984c140415cf"
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
