# TheWolfNL Homebrew tap

```bash
brew tap thewolfnl/tap
```

If Homebrew refuses to load casks from an untrusted tap, run `brew trust thewolfnl/tap` first.

## Casks

| Cask | Description | Source |
|---|---|---|
| `yubi-ki-yay` | Menu bar app that alerts when a YubiKey is waiting for a touch | [TheWolfNL/yubi-ki-yay](https://github.com/TheWolfNL/yubi-ki-yay) |

```bash
brew install --cask thewolfnl/tap/<cask>
```

### Quarantine

These apps are ad-hoc signed and not notarized. Each cask removes the `com.apple.quarantine` attribute after install so Gatekeeper does not block it. If macOS still refuses to open one, run `xattr -dr com.apple.quarantine "/Applications/<App>.app"`.

## Updating casks

`.github/workflows/bump.yml` updates a cask's `version` and `sha256`. It takes a cask name and a version, fills `#{version}` into the cask's `url`, downloads the file, checks it against `<url>.sha256` when the release publishes one, and pushes the commit. It runs on:

- a `repository_dispatch` of type `bump-cask` with payload `{"cask": "<name>", "version": "X.Y.Z"}`, sent by a project's release workflow;
- **Actions > Bump cask > Run workflow**, or `gh workflow run bump.yml -R TheWolfNL/homebrew-tap -f cask=<name> -f version=X.Y.Z`.

A new cask ships with a placeholder `sha256` (all zeros) until the first bump; installs fail until then.

## Adding a project

1. Add `Casks/<name>.rb` with `url` containing `#{version}` and a placeholder `sha256`.
2. In the project's release workflow, after publishing the release, send the dispatch:

   ```yaml
   - name: Bump Homebrew cask
     env:
       TAP_TOKEN: ${{ secrets.TAP_DISPATCH_TOKEN }}
     run: |
       [ -n "$TAP_TOKEN" ] || { echo "::notice::TAP_DISPATCH_TOKEN not set, skipping cask bump"; exit 0; }
       GH_TOKEN="$TAP_TOKEN" gh api repos/TheWolfNL/homebrew-tap/dispatches \
         -f event_type=bump-cask -f 'client_payload[cask]=<name>' -f "client_payload[version]=${VERSION}"
   ```

3. Create a fine-grained personal access token scoped to `TheWolfNL/homebrew-tap` with **Contents: Read and write**, and store it as the `TAP_DISPATCH_TOKEN` secret in the project repo.

The tap needs **Settings > Actions > General > Workflow permissions: Read and write** so the bump workflow can push.

## License

The cask definitions in this repo are [MIT](LICENSE). Each packaged project keeps its own license.
