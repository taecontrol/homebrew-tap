class Nook < Formula
  desc "Connect coding agents to your self-hosted Nook tools over MCP"
  homepage "https://github.com/taecontrol/nook"
  url "https://github.com/taecontrol/nook/releases/download/v0.3.2/nook-0.3.2.tar.gz"
  sha256 "517dd320c8d10d53ea803391037f09425b8398eaad59d8b795a09998f9d63b00"
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
