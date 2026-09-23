# Tendina's formula: builds the app from source on the installing Mac,
# so no Apple signature is needed and Gatekeeper blocks nothing.
# Homebrew cannot write to /Applications, so it also installs the
# `tendina-install` command, which copies the app there and launches it.
class Tendina < Formula
  desc "Hide menu bar icons on macOS 27 (Hidden Bar replacement)"
  homepage "https://github.com/massimodascola/tendina"
  url "https://github.com/massimodascola/tendina/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d58cd64693c6c04c1b6f4cfa46bbb74a4fed5aa7a7d0439637c5323a0562e5ac"
  license "MIT"
  head "https://github.com/massimodascola/tendina.git", branch: "master"

  depends_on arch: :arm64
  depends_on :macos

  def install
    system "sh", "build.sh"
    prefix.install "build/Tendina.app"

    (bin/"tendina-install").write <<~SH
      #!/bin/sh
      # Copies Tendina to /Applications and launches it.
      set -e
      pkill -x Tendina 2>/dev/null || true
      sleep 1
      rm -rf /Applications/Tendina.app
      cp -R "#{opt_prefix}/Tendina.app" /Applications/
      open /Applications/Tendina.app
      echo "Tendina installed in /Applications and launched."
    SH
    chmod 0755, bin/"tendina-install"
  end

  def caveats
    <<~EOS
      To finish the installation, and after every upgrade, run:
        tendina-install
    EOS
  end

  test do
    assert_path_exists prefix/"Tendina.app/Contents/MacOS/Tendina"
    assert_path_exists prefix/"Tendina.app/Contents/Resources/en.lproj/Localizable.strings"
    assert_path_exists bin/"tendina-install"
  end
end
