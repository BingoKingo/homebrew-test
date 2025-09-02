class Z < Formula
  desc "Tracks most-used directories to make cd smarter"
  homepage "https://github.com/rupa/z"
  url "https://github.com/rupa/z/archive/refs/tags/v1.12.tar.gz"
  sha256 "7d8695f2f5af6805f0db231e6ed571899b8b375936a8bfca81a522b7082b574e"
  license "WTFPL"
  version_scheme 1
  head "https://github.com/rupa/z.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/bingokingo/test"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f8e5b91d121df4112f1180d8ce5f581a936c22a54cf637e327c5508b8e55e10e"
    sha256 cellar: :any_skip_relocation, ventura:       "cede6d68141c5dd6b5abb657e9838d6f798a5d87ca7160a7c79c8d9ab09d07d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5260bd8651e1101c65df0481e59e07dfd03c1dbdf877a0b707f252980fce5e2"
  end

  def install
    (prefix/"etc/profile.d").install "z.sh"
    man1.install "z.1"
  end

  def caveats
    <<~EOS
      For Bash or Zsh, put something like this in your $HOME/.bashrc or $HOME/.zshrc:
        . #{etc}/profile.d/z.sh
    EOS
  end

  test do
    (testpath/"zindex").write("/usr/local|1|1491427986\n")
    output = shell_output("/bin/bash -c '_Z_DATA=#{testpath}/zindex; . #{etc}/profile.d/z.sh; _z -l 2>&1'")
    assert_match "/usr/local", output
  end
end
