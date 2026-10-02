# Written by scripts/formula.sh in code-akram/cc-fm-mod on each release.
class CcFm < Formula
  desc "Player for cc-fm: claude.fm with a live spectrum in Claude Code"
  homepage "https://github.com/code-akram/cc-fm-mod"
  version "0.0.3"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.3/cc-fm_darwin_arm64.tar.gz"
      sha256 "fb04b98304fcdc90b7b92dd248fcefa7c403e3e4d87b8fc418cfb950be2fd7c0"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.3/cc-fm_darwin_amd64.tar.gz"
      sha256 "c2141c838788b2c9536f6df6a15a2c81065a5e08d21359f772f002891bad8ea8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.3/cc-fm_linux_arm64.tar.gz"
      sha256 "9aff7a73cf74fb8217416c18b1c5ca250079c5df71021322176fa8f966acadfc"
    end
    on_intel do
      url "https://github.com/code-akram/cc-fm-mod/releases/download/v0.0.3/cc-fm_linux_amd64.tar.gz"
      sha256 "34ecc8c2038baa86e2a7ceef313810f61ba0472fcaf6280c69dc421e8c37cfd6"
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
