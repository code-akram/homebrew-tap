# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.5"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.5/cc-fm_darwin_arm64.tar.gz"
      sha256 "b8e7ab2c6c584dc2bbb390be93b97afae36fc6031b083c4461b5ad55e5613293"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.5/cc-fm_darwin_amd64.tar.gz"
      sha256 "c10dcd8f1f34559c2d5610306b220ac19e33fc3481431d22346b4edf542085aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.5/cc-fm_linux_arm64.tar.gz"
      sha256 "8a8350bd5b446264177f31c7151ee6be26faed63d91176c73b51112b4a61d158"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.5/cc-fm_linux_amd64.tar.gz"
      sha256 "b2155aad2c12b3e731133262be8aca2cdaff93c845d0a46978436ca937f5e284"
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
