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
  version "0.33.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.33.0/devstack-aarch64-apple-darwin.tar.gz"
      sha256 "724a99d86d9531e34de4d03a4d252adfdd163bb32ae33daf8c8ef971077a7ad0"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.33.0/devstack-x86_64-apple-darwin.tar.gz"
      sha256 "748a207be47fce16ea06e761d968a58c5a5bd2cd22c4133c8fdeac43ed2bd851"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.33.0/devstack-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4a35f9a84b37472da71871e6b8d415822d37129c522ce3436b83e04b7b89b407"
    end
    on_intel do
      url "https://github.com/nuetzliches/devstack/releases/download/v0.33.0/devstack-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1a1c8b64fb2b14c5916a1f003f701d953dcfe64c373e2709f71122b52f861939"
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
