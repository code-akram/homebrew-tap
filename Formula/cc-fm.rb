# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.10"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.10/cc-fm_darwin_arm64.tar.gz"
      sha256 "f705c15931b5b9144997829347a67129343f7a13221361ebe039f7ac83a9163d"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.10/cc-fm_darwin_amd64.tar.gz"
      sha256 "ca93e7a1b996ba4fc4d678e159d4bd5758973bd6503c97019521a22833743687"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.10/cc-fm_linux_arm64.tar.gz"
      sha256 "bf3d3681ae9170bb30e8bdc30aa40ac861764d56d13f8b74d5cee17541f35832"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.10/cc-fm_linux_amd64.tar.gz"
      sha256 "c6b79371d11bcb9c4e090b54ca78c3411dcef0f5b3d4e7c5058c3c7bb9822629"
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
