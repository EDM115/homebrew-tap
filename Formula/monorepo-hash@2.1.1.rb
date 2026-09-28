class MonorepoHashAT211 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.1/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "15cecdf431a4fc2429b7ffbb3ad89a31c681fcd3a7fcbb6f6a7a8ce40a67886d"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.1/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "a312fbff37e400254095b9e97c285ef02f70f7dc33de411d4730d318c4ee8a0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.1/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "6f0703f43fa1093c69cbcf889d153d5de71fb86970faff38b15e978d3fca205b"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.1/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "eb13006248b036dbc868d37898d9bd4f8a7ebd9873380e36fbb708690a777a84"
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
