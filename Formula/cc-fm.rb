# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.2"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.2/cc-fm_darwin_arm64.tar.gz"
      sha256 "9887e28cbd646de24fb77c42ea0b92104e574b1037380c2b830c6ee5665b0574"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.2/cc-fm_darwin_amd64.tar.gz"
      sha256 "b02cdb583534b2abfe0acfd7951dc1b1952c59ad385bca0d6e7e704a0c00a712"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.2/cc-fm_linux_arm64.tar.gz"
      sha256 "eeeb098a167312473a81c3150d536e2a8323f9475447d0ba94efe09fa21fbfd2"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.2/cc-fm_linux_amd64.tar.gz"
      sha256 "c5e34a3b68722de2a89279c388c9083888096529c0c08b3f7eb655a1bd41aa95"
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
