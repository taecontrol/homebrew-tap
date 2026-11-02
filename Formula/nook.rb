class Nook < Formula
  desc "Connect coding agents to your self-hosted Nook tools over MCP"
  homepage "https://github.com/taecontrol/nook"
  url "https://github.com/taecontrol/nook/releases/download/v0.5.0/nook-0.5.0.tar.gz"
  sha256 "4f8afa58171775d8c74d38336652c583e4a58304de4c18dda6ba29389f16c947"
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
