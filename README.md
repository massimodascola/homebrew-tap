# homebrew-tap

Homebrew formulae by [Massimo D'Ascola](https://github.com/massimodascola).

## Tendina

Hides menu bar icons on macOS: a Hidden Bar replacement for macOS 27. Source and documentation: [massimodascola/tendina](https://github.com/massimodascola/tendina).

```sh
brew install massimodascola/tap/tendina
tendina-install
```

Homebrew builds Tendina on your Mac; `tendina-install` copies it to Applications and launches it. To update: `brew upgrade tendina && tendina-install`.

## Releasing a new version (for maintainers)

1. In the `tendina` repo, create and push the version tag: `git tag -a vX.Y.Z -m "Tendina X.Y.Z"` and `git push origin vX.Y.Z`.
2. Compute the archive checksum: `curl -fsSL https://github.com/massimodascola/tendina/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256`.
3. In `Formula/tendina.rb`, update `url` and `sha256`, then test with `brew upgrade tendina` or `brew reinstall tendina`.
