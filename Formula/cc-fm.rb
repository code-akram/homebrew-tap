# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.15"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.15/cc-fm_darwin_arm64.tar.gz"
      sha256 "34d94be47133a20454d1ec105f43cc0c296f43405b49b320bd3e9170d463aea8"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.15/cc-fm_darwin_amd64.tar.gz"
      sha256 "9f46c817e6ef41d4d579b3b1856c9351838c78cc4c6f82b0eb8872a5186bc5ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.15/cc-fm_linux_arm64.tar.gz"
      sha256 "4fd1b3c50dbe53653b6c136ff1320a70e35568a285c187c75ee19c5d3189a67a"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.15/cc-fm_linux_amd64.tar.gz"
      sha256 "ff1df835c1a11c843b310a42eb773eec86ec835cb0ea0f74d45073e9a3132cd7"
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
