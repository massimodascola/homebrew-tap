# Clippa's formula: builds the app from source on the installing Mac,
# so no Apple signature is needed and Gatekeeper blocks nothing.
# Homebrew cannot write to /Applications, so it also installs the
# `clippa-install` command, which copies the app there and launches it.
class Clippa < Formula
  desc "Clipboard manager for macOS: history, pinboards, search, sync (Paste alternative)"
  homepage "https://github.com/massimodascola/clippa"
  url "https://github.com/massimodascola/clippa/archive/refs/tags/v1.2.5.tar.gz"
  sha256 "cee01d4033dc594bf7ad2326b9d443f0ae99b14f891a1dfbbdf72922cd8b826a"
  license "MIT"
  head "https://github.com/massimodascola/clippa.git", branch: "main"

  depends_on macos: :sonoma

  def install
    system "sh", "build.sh"
    prefix.install "build/Clippa.app"

    (bin/"clippa-install").write <<~SH
      #!/bin/sh
      # Copies Clippa to /Applications and launches it.
      set -e
      pkill -x Clippa 2>/dev/null || true
      sleep 1
      rm -rf /Applications/Clippa.app
      cp -R "#{opt_prefix}/Clippa.app" /Applications/
      open /Applications/Clippa.app
      echo "Clippa installed in /Applications and launched."
    SH
    chmod 0755, bin/"clippa-install"
  end

  def caveats
    <<~EOS
      To finish the installation, and after every upgrade, run:
        clippa-install
    EOS
  end

  test do
    assert_path_exists prefix/"Clippa.app/Contents/MacOS/Clippa"
    assert_path_exists prefix/"Clippa.app/Contents/MacOS/clippa-mcp"
    assert_path_exists bin/"clippa-install"
  end
end
