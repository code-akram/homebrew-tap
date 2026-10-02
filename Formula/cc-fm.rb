# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.12"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.12/cc-fm_darwin_arm64.tar.gz"
      sha256 "4700691d1bb4a6fc7aeb3545d6df62ef7d497bdf55832571c9f8b7d2a8a2a0e7"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.12/cc-fm_darwin_amd64.tar.gz"
      sha256 "d78b1f7a9cefbdae243d4160b6d3a44043ee925a9a085a44a114c2a14cf29601"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.12/cc-fm_linux_arm64.tar.gz"
      sha256 "feaef2b577e8a56e1fcca13845cef9602b8ab6ed891aee4a17c6b6950e75f3a0"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.12/cc-fm_linux_amd64.tar.gz"
      sha256 "87400e58748b64180d40b93e8d5561b0f36edd486efe60fbef51ba8485213c35"
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
