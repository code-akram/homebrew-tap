# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.9"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.9/cc-fm_darwin_arm64.tar.gz"
      sha256 "1c1420425ccea78b0f75380e68cc8e85900304ba1c6fe418cdd7731b18bc9766"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.9/cc-fm_darwin_amd64.tar.gz"
      sha256 "cbac4a993415a4dc05f35a70043b1ca6d4cfa7589f8d34fde1465c6cb73b789d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.9/cc-fm_linux_arm64.tar.gz"
      sha256 "fa535b47d6d163bc7dc219940071e81cf41291d7289efb4419c23081991b2e13"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.9/cc-fm_linux_amd64.tar.gz"
      sha256 "a43ef4dd66d2c947f89e301cdb8621d72381c273c3bc96a9d6143d5b7df9636b"
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
