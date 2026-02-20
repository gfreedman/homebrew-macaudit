class Macaudit < Formula
  include Language::Python::Virtualenv

  desc "Mac System Health Inspector & Auditor"
  homepage "https://github.com/gfreedman/mac_audit"
  url "https://github.com/gfreedman/mac_audit/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "a308dd0c033f249ca147b0d50f884e9a65eeeb9636eaf4a0d36e41a9c1b6ef4f"
  license "MIT"
  head "https://github.com/gfreedman/mac_audit.git", branch: "main"

  depends_on "python@3.12"

  resource "click" do
    url "https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0/click-8.3.1.tar.gz"
    sha256 "12ff4785d337a1bb490bb7e9c2b1ee5da3112e94a8622f26a6c77f5d2fc6842a"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/74/99/a4cab2acbb884f80e558b0771e97e21e939c5dfb460f488d19df485e8298/rich-14.3.2.tar.gz"
    sha256 "e712f11c1a562a11843306f5ed999475f09ac31ffb64281f73ab29ffdda8b3b8"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/35/a2/8e3becb46433538a38726c948d3399905a4c7cabd0df578ede5dc51f0ec2/wcwidth-0.6.0.tar.gz"
    sha256 "cdc4e4262d6ef9a1a57e018384cbeb1208d8abbc64176027e2c2455c81313159"
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
    assert_match version.to_s, shell_output("#{bin}/macaudit --version")
  end
end
