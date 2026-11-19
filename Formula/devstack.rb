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
  version "0.51.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.51.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "c064c5b7071e49576851900ab9d9a7536813a3100f71867a0af398dbb2eb6d55"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.51.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "78442cf923a61a4aab380c973d6ee2f53838e040626fdca7b1c70cef56d61939"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.51.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "055b6abfabf410b0c17bc98c57f5c6e057a1e54f5a52221553d1856c4411b356"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.51.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bdd0c583ddee80713ab7ccc8d506800158bd0dc901a17afbb2b64da7cebefe79"
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
