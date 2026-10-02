# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.7"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.7/cc-fm_darwin_arm64.tar.gz"
      sha256 "cef48f23080f8dd7d50e2bcb2460ed65b5e578d4e3e769e9f2197ef837aaecf1"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.7/cc-fm_darwin_amd64.tar.gz"
      sha256 "bac13b4c609322374369f43d7350a3d50def004919fe1b53b9130c590a8d83cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.7/cc-fm_linux_arm64.tar.gz"
      sha256 "968789f9fd91e12e0758ec1c8abc79441a8f5aa735ef96362434449b43c3d7fb"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.7/cc-fm_linux_amd64.tar.gz"
      sha256 "ce2e82529266713043f9ab2aaf9229c9d71b3c360c0686aaa72c0e869b63c665"
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
