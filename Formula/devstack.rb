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
  version "0.47.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.47.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "9164ceeddf1d205c37c529539e663b4d3ebb7bff50547643f9c428cb2a4e1c37"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.47.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "02706797ba4a6f0d889547da5de0717592e3ef4d7edfa149585a38a0aa0e2fc5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.47.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "acee5efc78d95c019788c1578abf54496100b4ee5e23af4d9763cfa8e3de777a"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.47.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "58826b2aa1f32da648ce4f2459d22c35e796d3079ca8b2e04965e50fe073b71d"
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
