class Githerd < Formula
  desc "Concurrent Git repository management tool"
  homepage "https://github.com/entro314-labs/Git-Herd"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/entro314-labs/Git-Herd/releases/download/v0.1.0/githerd_0.1.0_darwin_amd64.tar.gz"
      sha256 "29fc345345e609ce795f4406418c45be929ebe506050c5361413af6e5d8ccd11"
    end

    on_arm do
      url "https://github.com/entro314-labs/Git-Herd/releases/download/v0.1.0/githerd_0.1.0_darwin_arm64.tar.gz"
      sha256 "30b9712014c89a6a09db20fc46bcb2f689743526601eb7abed2973ede39e6c92b"
    end
  end

  depends_on "git"

  def install
    bin.install "githerd"
    
    # Install config file if present
    if File.exist?("config.yaml")
      (etc/"githerd").mkpath
      (etc/"githerd").install "config.yaml" => "githerd.yaml"
    end
  end

  test do
    # Test that the binary runs and shows help
    system "#{bin}/githerd", "--help"
    
    # Test version output
    assert_match version.to_s, shell_output("#{bin}/githerd --version 2>&1", 2)
  end

  def caveats
    <<~EOS
      GitHerd has been installed successfully!
      
      Usage:
        githerd [path]              # Run on current or specified directory
        githerd --help              # Show all options
        githerd --version           # Show version
      
      Configuration file (optional):
        #{etc}/githerd/githerd.yaml
      
      Examples:
        githerd                     # Process current directory
        githerd ~/Development       # Process specific directory
        githerd --dry-run ~/Code    # Preview what would happen
        githerd --workers 10        # Use 10 concurrent workers
    EOS
  end
end