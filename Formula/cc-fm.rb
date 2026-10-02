# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.13"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.13/cc-fm_darwin_arm64.tar.gz"
      sha256 "65a2fc312d8fcb71347fe00013fce1cced20806bd0b0badf9998b0ac90ffc65c"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.13/cc-fm_darwin_amd64.tar.gz"
      sha256 "b6711e99240767736a5c4f14abc31bb2f9786768fe62f987b59de58a70fe6604"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.13/cc-fm_linux_arm64.tar.gz"
      sha256 "8d5bab86f5c00fb36a9eb3ea483c9a5cf364d1fca455984e2a010e868304ac5b"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.13/cc-fm_linux_amd64.tar.gz"
      sha256 "ca190d71e41580756b9624d58b9c1156f6a6db4653523d50205799e2b23656fb"
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
