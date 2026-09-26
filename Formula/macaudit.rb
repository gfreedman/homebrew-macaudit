class Macaudit < Formula
  include Language::Python::Virtualenv

  desc "Mac System Health Inspector & Auditor"
  homepage "https://github.com/gfreedman/mac_audit"
  url "https://github.com/gfreedman/mac_audit/archive/refs/tags/v1.12.1.tar.gz"
  sha256 "64f8d9de2ddaea3d113d0599d2df207b54509f1e9c811345e49d6ed3e2a67ddc"
  license "MIT"
  head "https://github.com/gfreedman/mac_audit.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0e/7fa0ef50764b67090eca4114772a2abf8b6148198475e54c660b97caeee6/click-8.5.0.tar.gz"
    sha256 "ba0d2089de75ea0310e2dde03160e6ca10009947fb95a182f9b54021bb272e34"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
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
