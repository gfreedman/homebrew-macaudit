class Macaudit < Formula
  include Language::Python::Virtualenv

  desc "Mac System Health Inspector & Auditor"
  homepage "https://github.com/gfreedman/mac_audit"
  url "https://github.com/gfreedman/mac_audit/archive/refs/tags/v1.7.1.tar.gz"
  sha256 "c9e9c72818a81e78392e1cb8a431a68803bdb3dc6451ae7d3ed4de0b343baa02"
  license "MIT"
  head "https://github.com/gfreedman/mac_audit.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0/click-8.3.1.tar.gz"
    sha256 "12ff4785d337a1bb490bb7e9c2b1ee5da3112e94a8622f26a6c77f5d2fc6842a"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/b3/c6/f3b320c27991c46f43ee9d856302c70dc2d0fb2dba4842ff739d5f46b393/rich-14.3.3.tar.gz"
    sha256 "b8daa0b9e4eef54dd8cf7c86c03713f53241884e814f4e2f5fb342fe520f639b"
  end

  resource "simple-term-menu" do
    url "https://files.pythonhosted.org/packages/d8/80/f0f10b4045628645a841d3d98b584a8699005ee03a211fc7c45f6c6f0e99/simple_term_menu-1.6.6.tar.gz"
    sha256 "9813d36f5749d62d200a5599b1ec88469c71378312adc084c00c00bfbb383893"
  end
  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      To enable shell completion, add to your ~/.zshrc:
        eval "$(_MACAUDIT_COMPLETE=zsh_source macaudit)"

      For bash, add to ~/.bash_profile:
        eval "$(_MACAUDIT_COMPLETE=bash_source macaudit)"

      Then restart your terminal or run: source ~/.zshrc
    EOS
  end

  test do
    assert_match version.to_s, shell_output("\#{bin}/macaudit --version")
  end
end
