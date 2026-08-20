class Manuvra < Formula
  desc "Shell-driven Chrome and native macOS control for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.1.0/manuvra-0.1.0.tar.gz"
  sha256 "9e3530ffc72a4dd32a3d7dc3a436d4b56e9604bf5b11d7fb9c4e042229c89322"
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
