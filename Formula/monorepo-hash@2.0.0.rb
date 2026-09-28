class MonorepoHashAT200 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.0.0/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "bd5a922d0bcd6558bfa5ac255ee0a213c9d6517c7691bfa34cd01d2801d6c800"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.0.0/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "567c2319e5170956fd79c49d379f73e0dc334438e8c700ae422d3e4aedfb6db9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.0.0/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "e8f0be1590ee74137bf6a5a88072bcbbd4deed7decee73f80a5f3fe7fa10f4ac"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.0.0/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "1431a08197587350ade20e91bd75c1327567b1b92d41b214549d2c819b952d6a"
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
