# homebrew-tap

Formule Homebrew di [Massimo D'Ascola](https://github.com/massimodascola). / Homebrew formulae by Massimo D'Ascola.

## Tendina

Nasconde le icone della barra dei menu di macOS, sostituto di Hidden Bar per macOS 27. Codice e istruzioni: [massimodascola/tendina](https://github.com/massimodascola/tendina).

```sh
brew install massimodascola/tap/tendina
tendina-installa
```

Homebrew compila Tendina sul tuo Mac; `tendina-installa` la copia in Applicazioni e la avvia. Per aggiornare: `brew upgrade tendina && tendina-installa`.

## Aggiornare la formula (per chi mantiene il tap)

1. Nel repo `tendina`: crea l'etichetta della nuova versione (`git tag -a vX.Y.Z -m "Tendina X.Y.Z"`) e caricala (`git push origin vX.Y.Z`).
2. Calcola l'impronta del pacchetto: `curl -fsSL https://github.com/massimodascola/tendina/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256`.
3. In `Formula/tendina.rb` aggiorna `url` e `sha256`, poi prova con `brew upgrade tendina` o `brew reinstall tendina`.
