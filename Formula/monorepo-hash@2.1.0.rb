class MonorepoHashAT210 < Formula
  desc "A CLI tool to generate hashes for the workspaces of your monorepo"
  homepage "https://github.com/EDM115/monorepo-hash"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.0/monorepo-hash-darwin-arm64",
          using: :nounzip
      sha256 "b351cac944b8ecafcd60442cd563103aff79946b53e4562807331f39effebe47"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.0/monorepo-hash-darwin-x64",
          using: :nounzip
      sha256 "78a5706358c13d0f9d3ae9002909a8f0abd6c5b02ca33ef3c55b0b1f7b0ebd2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.0/monorepo-hash-linux-arm64",
          using: :nounzip
      sha256 "29044f4c411671dff7b7a98cfff3f94646ba07b8d36019e11bed142bb6a24281"
    end

    on_intel do
      url "https://github.com/EDM115/monorepo-hash/releases/download/2.1.0/monorepo-hash-linux-x64",
          using: :nounzip
      sha256 "45ae191074556fada4275266e70500adf8cd44efe453cfebb2d0bdd440029219"
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
