# TheWolfNL Homebrew tap

## Yubi Ki-Yay

Menu bar app that alerts when a YubiKey is waiting for a touch. Source: [TheWolfNL/yubi-ki-yay](https://github.com/TheWolfNL/yubi-ki-yay).

```bash
brew install --cask thewolfnl/tap/yubi-ki-yay
```

If Homebrew refuses to load the cask from an untrusted tap, run `brew trust thewolfnl/tap` first.

This installs `Yubi Ki-Yay.app` and links the CLI as `yubikiyay`.

### Quarantine

The app is ad-hoc signed and not notarized. The cask removes the `com.apple.quarantine` attribute after install so Gatekeeper does not block it. If macOS still refuses to open it, run:

```bash
xattr -dr com.apple.quarantine "/Applications/Yubi Ki-Yay.app"
```

`brew uninstall --zap --cask yubi-ki-yay` also removes `~/.config/yubi-ki-yay` and `~/Library/Application Support/yubi-ki-yay`.

## Release process

1. In the app repo, push a tag `vX.Y.Z`. Its release workflow attaches `Yubi-Ki-Yay-X.Y.Z-universal.zip` and `Yubi-Ki-Yay-X.Y.Z-universal.zip.sha256` to the GitHub release.
2. In this repo, run **Actions > Bump cask > Run workflow** with version `X.Y.Z` (or `gh workflow run bump-yubi-ki-yay.yml -R TheWolfNL/homebrew-tap -f version=X.Y.Z`). It downloads the zip, checks it against the published `.sha256`, updates `version` and `sha256` in `Casks/yubi-ki-yay.rb` and pushes the commit.

The cask ships with a placeholder `sha256` (all zeros) until the bump workflow has run for the first release; installs fail until then.

## License

[PolyForm Shield 1.0.0](LICENSE.md). Required Notice: Copyright Tjeerd Ritsma (https://github.com/TheWolfNL)
