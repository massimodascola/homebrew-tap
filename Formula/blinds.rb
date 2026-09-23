# Blinds' formula: builds the app from source on the installing Mac,
# so no Apple signature is needed and Gatekeeper blocks nothing.
# Homebrew cannot write to /Applications, so it also installs the
# `blinds-install` command, which copies the app there and launches it.
# Blinds was called Tendina up to 1.1.0 (see formula_renames.json).
class Blinds < Formula
  desc "Hide menu bar icons on macOS 27 (Hidden Bar replacement)"
  homepage "https://github.com/massimodascola/blinds"
  url "https://github.com/massimodascola/blinds/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "694dbd45948d2efb5ac39e0cb98ce3941c85f4b1f494c9fd3c172822774080b4"
  license "MIT"
  head "https://github.com/massimodascola/blinds.git", branch: "master"

  depends_on arch: :arm64
  depends_on :macos

  def install
    system "sh", "build.sh"
    prefix.install "build/Blinds.app"

    (bin/"blinds-install").write <<~SH
      #!/bin/sh
      # Copies Blinds to /Applications and launches it.
      set -e
      pkill -x Blinds 2>/dev/null || true
      # Blinds was called Tendina: quit the old copy and move it to the Trash.
      pkill -x Tendina 2>/dev/null || true
      sleep 1
      if [ -d /Applications/Tendina.app ] && command -v trash >/dev/null 2>&1; then
        trash -s /Applications/Tendina.app && echo "Moved the old Tendina.app to the Trash."
      fi
      rm -rf /Applications/Blinds.app
      cp -R "#{opt_prefix}/Blinds.app" /Applications/
      open /Applications/Blinds.app
      echo "Blinds installed in /Applications and launched."
    SH
    chmod 0755, bin/"blinds-install"
  end

  def caveats
    <<~EOS
      To finish the installation, and after every upgrade, run:
        blinds-install
    EOS
  end

  test do
    assert_path_exists prefix/"Blinds.app/Contents/MacOS/Blinds"
    assert_path_exists prefix/"Blinds.app/Contents/Resources/en.lproj/Localizable.strings"
    assert_path_exists bin/"blinds-install"
  end
end
