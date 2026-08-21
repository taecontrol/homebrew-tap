class Manuvra < Formula
  desc "Shell-driven Chrome and native macOS control for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.2.1/manuvra-0.2.1.tar.gz"
  sha256 "a1ac7518cf5b0c15e6f410e7d23e8219f5728e535ab1843cfcd13f313c7956e9"
  license "MIT"

  depends_on "rust" => :build
  depends_on "jq" => :build
  depends_on macos: :tahoe

  def install
    odie "Manuvra supports Apple Silicon only" unless Hardware::CPU.arm?
    ENV.delete("MANUVRA_CODESIGN_IDENTITY")
    system "./scripts/package-manuvra.sh", "--prefix", prefix
  end

  test do
    assert_match '"registry_version":"1.0.0"', shell_output("#{bin}/manuvra commands list --limit 1")
    assert_match '"running":false', shell_output("#{bin}/manuvra daemon status")
  end
end
