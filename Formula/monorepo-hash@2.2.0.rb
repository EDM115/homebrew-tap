class MonorepoHashAT220 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.2.0/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "aa947efd5d5b6b646f445dd3655c8ef3ea11396f73904d5d038e6f15af9dbfcf"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.2.0/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "017df259a3f4424a03202681ea52fa31579c992b0f9f412cf29238dbffd3bc4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.2.0/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "74a2bbdff629920f63f8bd5ae94cb3a0f607fb9fd0503392b07218d33366f22a"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.2.0/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "9e2199a066ac801e69fac4bb86c4096621aa5a98e808ed98bbcb6c8a36f352c7"
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
