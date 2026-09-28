# `EDM115/homebrew-tap`

My very own formulae & casks for my programs, available on MacOS & Linux.  
You can add it instantly with this, but it isn't necessary :
```zsh
brew tap EDM115/tap
```

## `EDM115/monorepo-hash`

Homebrew formulas for [`EDM115/monorepo-hash`](https://github.com/EDM115/monorepo-hash) on macOS and Linux. The formulas install the prebuilt binaries from the project's GitHub releases.

### Install the current release

```zsh
brew install EDM115/tap/monorepo-hash
```

On macOS, the formula replaces the release binary's invalid code signature with a local ad hoc signature after Homebrew verifies its SHA-256 checksum. The installed binary has no publisher identity in its macOS signature.

### Install an earlier release

Example with the oldest `1.8.0` :

```zsh
brew trust --formula EDM115/tap/monorepo-hash
brew install EDM115/tap/monorepo-hash@1.8.0
$(brew --prefix EDM115/tap/monorepo-hash@1.8.0)/bin/monorepo-hash --help
```

Homebrew loads the unversioned formula while installing a versioned one, so it must be trusted first. This trusts only that formula, not the whole tap. Versioned formulas are keg-only because they all provide the same `monorepo-hash` command. To make an older release available as the normal command, first unlink the current formula if it is installed, then explicitly link the selected version :

```zsh
brew unlink EDM115/tap/monorepo-hash
brew link --force EDM115/tap/monorepo-hash@1.8.0
```

The unversioned formula will move to newer releases as they are published. The versioned formulas retain the older binaries for users who need them.
