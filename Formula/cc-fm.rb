# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.6"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.6/cc-fm_darwin_arm64.tar.gz"
      sha256 "9e44399585d5e0d6cf4c23827ccafaa6b80d403c0282f398e2f22703d0ee83d3"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.6/cc-fm_darwin_amd64.tar.gz"
      sha256 "05c467d0eea944c05b9d0465a53386237c2ab19ebecb5c5070f2f039f6af3352"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.6/cc-fm_linux_arm64.tar.gz"
      sha256 "87a91a4114ad1ecda60f0ea80e41ceac1215e67dff9eefc14db59133b2c6109f"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.6/cc-fm_linux_amd64.tar.gz"
      sha256 "bef58b6c4803a9a123032918f55d376eb32581d0a21bf451f8f07ab756734a12"
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
