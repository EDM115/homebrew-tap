class MonorepoHashAT190 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.9.0/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "dc996d3c1479ead73c21398a721e26bceac02e91af41d395ece2f0cb65ba85e0"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.9.0/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "92cfcba1066c28edcdd510d4ff0e67b3b1c45f9ba97471c5e23c53851fa1579b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.9.0/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "730c4b4b407a3e7c60663896080d65a1173363591ed004836b9af7fe50f2d85f"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/1.9.0/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "00cc5333b3c9b74308b99eecd42b6bb1a3e4d74d62263bc03bda3f2665f3830e"
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
