# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.4"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.4/cc-fm_darwin_arm64.tar.gz"
      sha256 "149efe3b2ef0c45621b11ecc576ce7089f66a63a604630afaeae6b7aac1fed18"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.4/cc-fm_darwin_amd64.tar.gz"
      sha256 "5c5381dea3689db736fa134c3bea3e7adf62333e89918bb0e6738588532ad94c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.4/cc-fm_linux_arm64.tar.gz"
      sha256 "64232015671996f6d2c32de83364407082907ef3e54dfb39376a0f4f63089b81"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.4/cc-fm_linux_amd64.tar.gz"
      sha256 "f52a2cda7102caea680805bdeb4721adf554c8cfad09a75f49b307712cd15a78"
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
