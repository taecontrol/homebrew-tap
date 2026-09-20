class Manuvra < Formula
  desc "Jev-guided browser journeys for coding agents"
  homepage "https://github.com/taecontrol/manuvra"
  url "https://github.com/taecontrol/manuvra/releases/download/v0.3.0/manuvra-0.3.0.tar.gz"
  sha256 "7161c737bbba7702c815a1f3f3a983f1fdcd45ebc3c6ef4d577ee2f0dd81f395"
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
