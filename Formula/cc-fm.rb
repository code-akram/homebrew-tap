# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.8"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.8/cc-fm_darwin_arm64.tar.gz"
      sha256 "38d45fe33097863d6104dc3a427a3974bb2d22dc57d8ae0c1af1f3f71b24c35b"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.8/cc-fm_darwin_amd64.tar.gz"
      sha256 "41e1163f17fb91e8603e140bff981bbdeb80ce8f7bdc164e6be535279441a00a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.8/cc-fm_linux_arm64.tar.gz"
      sha256 "d10427d7d836c45604c583699caf784a798e9fdefc9788dd9512446d3471ac4a"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.8/cc-fm_linux_amd64.tar.gz"
      sha256 "7d1895c1b5faec864c107ba663b75c9b2d1a14b7e24fd4ab38a6aaf1e0c4618e"
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
