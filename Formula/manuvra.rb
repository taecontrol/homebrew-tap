class Manuvra < Formula
  desc "Jev-guided browser journeys for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.5.0/manuvra-0.5.0.tar.gz"
  sha256 "d5e7f2047b256c674ab2a5b21fea594157349dbb7b9a186e67fee930458c7e45"
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
