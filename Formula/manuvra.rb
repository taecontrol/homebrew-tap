class Manuvra < Formula
  desc "Jev-guided browser journeys for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.4.0/manuvra-0.4.0.tar.gz"
  sha256 "8980e76d58a7bf814c4df1f483b8d9e136d1831cd7c1b193d6fba30c498d73ac"
  license "MIT"

  depends_on :macos
  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/manuvra-cli")
  end

  test do
    assert_match "\"version\":\"#{version}\"", shell_output("#{bin}/manuvra version")
    assert_match "\"title\":\"Job\"", shell_output("#{bin}/manuvra schema job")
  end
end
