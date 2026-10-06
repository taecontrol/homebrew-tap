class Manuvra < Formula
  desc "Jev-guided browser journeys for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.6.0/manuvra-0.6.0.tar.gz"
  sha256 "83d78622019e8d7d7fb209ce9ef929177a2e3b026d5c45498e917d83c6a4d79f"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/manuvra-cli")
  end

  test do
    assert_match "\"version\":\"#{version}\"", shell_output("#{bin}/manuvra version")
    assert_match "\"title\":\"Job\"", shell_output("#{bin}/manuvra schema job")
  end
end
