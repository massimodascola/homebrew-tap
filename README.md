# homebrew-tap

Homebrew formulae by [Massimo D'Ascola](https://github.com/massimodascola).

## Blinds

Hides menu bar icons on macOS: a Hidden Bar replacement for macOS 27. Source and documentation: [massimodascola/blinds](https://github.com/massimodascola/blinds).

```sh
brew install massimodascola/tap/blinds
blinds-install
```

Homebrew builds Blinds on your Mac; `blinds-install` copies it to Applications and launches it. To update: `brew upgrade blinds && blinds-install`.

Blinds was called Tendina up to version 1.1.0. If you installed `tendina`, switch with:

```sh
brew uninstall --force tendina
brew install massimodascola/tap/blinds
blinds-install
```

`blinds-install` also moves the old Tendina.app to the Trash. Your icon positions and settings stay.

## Releasing a new version (for maintainers)

1. In the `blinds` repo, create and push the version tag: `git tag -a vX.Y.Z -m "Blinds X.Y.Z"` and `git push origin vX.Y.Z`.
2. Compute the archive checksum: `curl -fsSL https://github.com/massimodascola/blinds/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256`.
3. In `Formula/blinds.rb`, update `url` and `sha256`, then test with `brew upgrade blinds` or `brew reinstall blinds`.
