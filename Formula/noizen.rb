class Noizen < Formula
  desc "An offline foreground ambient sound mixer"
  homepage "https://github.com/nendix/noizen"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/nendix/noizen/releases/download/v0.1.0/noizen-aarch64-apple-darwin.tar.gz"
      sha256 "66f2274167a9ea5ef04bc3a577f23779d8d8dd3a97c853c5fd2d738f3fe67248"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nendix/noizen/releases/download/v0.1.0/noizen-x86_64-apple-darwin.tar.gz"
      sha256 "b9c6e8a3e77e3831709a8c56d5c9c6bfe2b6e93cdcbdaa520cbb730999708f67"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/nendix/noizen/releases/download/v0.1.0/noizen-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d6dae01d9e37a8536890bbcb9471741e9b3cfdec23fb4bfbb497c668bae7d5a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nendix/noizen/releases/download/v0.1.0/noizen-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e9a5a68800871e8a75d959ae62f442d14534d82a4992f2c6c9a082215823905f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "noizen"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "noizen"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "noizen"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "noizen"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
