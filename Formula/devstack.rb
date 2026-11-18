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
  version "0.49.4"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.4/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "21d19d587b8ed68dfa4aeec6d48792c9e6c4eda95c3b5f007a45fe6c0e02c957"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.4/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "e576061ef539f175aa01a97fbc766d97a2b699f606d4cb7b5894468a51f343a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.4/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a703c9c6acea4fc6b2314a651e7ba0710b525303cb225663244e8abba1eac25c"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.49.4/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "11e3fc2c549a60b1affb94bbf978139a1067284b50a13fde1d01c83f9b267018"
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
