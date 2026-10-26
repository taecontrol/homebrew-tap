class Nook < Formula
  desc "Connect coding agents to your self-hosted Nook tools over MCP"
  homepage "https://github.com/taecontrol/nook"
  url "https://github.com/taecontrol/nook/releases/download/v0.3.1/nook-0.3.1.tar.gz"
  sha256 "2aeda8662c443b6eaa031485881888771f45f8ba2cea8cbb196644242fd3aa05"
  license "MIT"

  depends_on "pnpm" => :build
  depends_on :macos
  depends_on "node"

  def install
    system "pnpm", "install", "--frozen-lockfile"
    system "node", "scripts/build-cli.ts", libexec/"cli.js"
    (bin/"nook").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/cli.js" "$@"
    SH
  end

  test do
    assert_equal "{\"version\":\"#{version}\"}\n", shell_output("#{bin}/nook version")
  end
end
