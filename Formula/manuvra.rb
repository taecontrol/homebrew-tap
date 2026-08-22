class Manuvra < Formula
  desc "Shell-driven Chrome and native macOS control for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.2.3/manuvra-0.2.3.tar.gz"
  sha256 "d735d1b91e4ed72352454cdcca5bfb7b0793fd48eb52b776bc35341a312bb7dd"
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
