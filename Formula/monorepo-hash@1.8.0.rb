class MonorepoHashAT180 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.8.0/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "0958aad1d7eb49b240d84395a5a34808295fbf386da5a16b6f77025717f0f368"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.8.0/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "15cabd0d36b290fd1c0dc858d6f642c547d5ed527ac493f230cc1c7115dd058d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.8.0/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "5336fe60bcaf60d8e86be3772c7dcc21bf0209004772d0c21fc583560cefb600"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.8.0/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "d39c45f82e812bd2f156b62c473ee3ee82cebba643a8ebe565867c5457537f84"
    end
  end

  def install
    platform = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    executable = bin/"monorepo-hash"
    bin.install "monorepo-hash-#{platform}-#{arch}" => "monorepo-hash"
    executable.chmod 0755

    # The release binaries have invalid macOS signatures, sign the verified copy locally
    if OS.mac?
      system "codesign", "--remove-signature", executable
      system "codesign", "--force", "--sign", "-", "--timestamp=none", executable
    end
  end

  test do
    assert_match "monorepo-hash by EDM115", shell_output("#{bin}/monorepo-hash --help")
  end
end
