# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.1"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.1/cc-fm_darwin_arm64.tar.gz"
      sha256 "53f71a115f32403c5fc717eafa46ee61c764b8dd676869419c286dd57c7c54fa"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.1/cc-fm_darwin_amd64.tar.gz"
      sha256 "1bad343fb6a87cb9da4494254ce482189225b0ef882f67ac90e93445013453bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.1/cc-fm_linux_arm64.tar.gz"
      sha256 "299cb4728db6698fd5686ed562773bd17dabe54d5fe56a4b5761c17474ff88d5"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.1/cc-fm_linux_amd64.tar.gz"
      sha256 "eb74171da9f029fc54c82d500a91c7ac7d34843f4ba046bbf983e2bf460a44c0"
    end
  end

  def install
    bin.install "cc-fm"
  end

  # Idle until /fm or `cc-fm play` starts something: nothing plays at login.
  service do
    run [opt_bin/"cc-fm", "serve"]
    environment_variables PATH: std_service_path_env
    keep_alive true
    log_path var/"log/cc-fm.log"
    error_log_path var/"log/cc-fm.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cc-fm version")
  end
end
