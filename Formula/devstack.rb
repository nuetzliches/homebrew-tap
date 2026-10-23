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
  version "0.20.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.20.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "4013120ca48c180cf3068cdecfb1bd6dd783b5df96af6b4ea575982db6af26b5"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.20.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "8a0e17fd8dd2b04e130746b5252777a36fc7046e74547261d4f7faa1e1b3625c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.20.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "36f618ea01c2b9a7d50062d96e5ce0111cd13f370e88ad9d7fdb41891a3d38a4"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.20.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "32c9787080e900ca04515fb70d67bd3e68caf58f650ba28256c18104227a49cd"
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
