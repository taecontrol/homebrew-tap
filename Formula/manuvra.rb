class Manuvra < Formula
  desc "Shell-driven Chrome and native macOS control for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.1.1/manuvra-0.1.1.tar.gz"
  sha256 "7d23a5db1606e16249cab7b0e6086c73c569a1b3551d092cb926ae206ac5cc33"
  license "MIT"

  depends_on "rust" => :build
  depends_on "jq" => :build
  depends_on macos: :tahoe

  def install
    odie "Manuvra supports Apple Silicon only" unless Hardware::CPU.arm?
    system "./scripts/package-manuvra.sh", "--prefix", prefix
  end

  test do
    assert_match '"registry_version":"1.0.0"', shell_output("#{bin}/manuvra commands list --limit 1")
    assert_match '"running":false', shell_output("#{bin}/manuvra daemon status")
  end
end
