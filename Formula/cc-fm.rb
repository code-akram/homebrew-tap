# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.11"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.11/cc-fm_darwin_arm64.tar.gz"
      sha256 "443a7a3920d85903f6b1444fb2ddfdd2f4e17b8b373b1994f681b34a27610066"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.11/cc-fm_darwin_amd64.tar.gz"
      sha256 "9b22892516f02286db056f0b09bc036126f9591291ff8beba4b98c657ee1b131"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.11/cc-fm_linux_arm64.tar.gz"
      sha256 "4c6470f5c23a3d4ed622449368328818063d7ca0c39382a7c8a2a3ba22f27406"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.11/cc-fm_linux_amd64.tar.gz"
      sha256 "db5566564e3ccba428fce924784611cad21f59655cb5ac8c57d21f9f5616ad3a"
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
