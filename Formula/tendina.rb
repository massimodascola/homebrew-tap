# Formula di Tendina: compila l'app dal codice sorgente sul Mac di chi installa,
# così non serve una firma Apple e Gatekeeper non blocca niente.
# Homebrew non può scrivere in /Applications, quindi installa anche il comando
# `tendina-installa`, che copia l'app lì e la avvia.
class Tendina < Formula
  desc "Hide menu bar icons on macOS 27 (Hidden Bar replacement)"
  homepage "https://github.com/massimodascola/tendina"
  url "https://github.com/massimodascola/tendina/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "6cbdf8b7da235800f007fa162a9ec5270a4995cad229105707154c9aca43fbc2"
  license "MIT"
  head "https://github.com/massimodascola/tendina.git", branch: "master"

  depends_on arch: :arm64
  depends_on :macos

  def install
    system "sh", "build.sh"
    prefix.install "build/Tendina.app"

    (bin/"tendina-installa").write <<~SH
      #!/bin/sh
      # Copia Tendina in /Applications e la avvia.
      set -e
      pkill -x Tendina 2>/dev/null || true
      sleep 1
      rm -rf /Applications/Tendina.app
      cp -R "#{opt_prefix}/Tendina.app" /Applications/
      open /Applications/Tendina.app
      echo "Tendina installata in /Applications e avviata."
    SH
    chmod 0755, bin/"tendina-installa"
  end

  def caveats
    <<~EOS
      Per completare l'installazione, e dopo ogni aggiornamento, esegui:
        tendina-installa
      To finish the installation, and after every upgrade, run:
        tendina-installa
    EOS
  end

  test do
    assert_path_exists prefix/"Tendina.app/Contents/MacOS/Tendina"
    assert_path_exists bin/"tendina-installa"
  end
end
