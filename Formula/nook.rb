class Nook < Formula
  desc "Connect coding agents to your self-hosted Nook tools over MCP"
  homepage "https://github.com/taecontrol/nook"
  url "https://github.com/taecontrol/nook/releases/download/v0.4.0/nook-0.4.0.tar.gz"
  sha256 "640fa5bb4e6a367eb130920bf7289b3c4c7a9707557c39fd3993dc6b431d19c4"
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
