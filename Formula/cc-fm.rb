# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.14"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.14/cc-fm_darwin_arm64.tar.gz"
      sha256 "be29a4ec090848a4667916b260b2cf213b3120e8b3c7e74b9994738b306d2adf"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.14/cc-fm_darwin_amd64.tar.gz"
      sha256 "73dc66401073d5acf9f9167bfac505787a12eb6c118169f94aa82919f407ed99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.14/cc-fm_linux_arm64.tar.gz"
      sha256 "2b9de68319eb2f11e50f52447c29a3a7fd3d09d76960ab580e9b7d516b905f98"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.14/cc-fm_linux_amd64.tar.gz"
      sha256 "fb8f956f617bf7b686f9e5aaf730849477fb64b4ea1d670698c5c809e50ff013"
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
