class Manuvra < Formula
  desc "Shell-driven Chrome and native macOS control for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.2.2/manuvra-0.2.2.tar.gz"
  sha256 "30c6726b2285e03f0acf22464e5aa9d28177bd225876e10a25e4034dd8c7ad2c"
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
