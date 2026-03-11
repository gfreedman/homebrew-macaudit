# =============================================================================
# Homebrew Formula for macaudit
# =============================================================================
#
# What is a Homebrew Formula?
#   Homebrew is the most popular package manager for macOS. A "formula" is just
#   a Ruby script that tells Homebrew how to download, build, and install a
#   piece of software. When you run `brew install macaudit`, Homebrew reads
#   this file and follows its instructions.
#
# What is macaudit?
#   macaudit is a command-line tool that inspects and audits the health of a
#   Mac system — checking things like security settings, disk health, software
#   updates, and more.
# =============================================================================

# Every Homebrew formula is a Ruby class that inherits from `Formula`.
# This gives our class all the built-in Homebrew behavior for free
# (downloading files, verifying checksums, installing binaries, etc.).
class Macaudit < Formula

  # ----------------------------------------------------------------------------
  # Mixin: Python Virtualenv support
  # ----------------------------------------------------------------------------
  # `include` in Ruby is like importing a "mixin" (a bundle of reusable methods).
  # Language::Python::Virtualenv is a Homebrew helper that knows how to:
  #   1. Create an isolated Python virtual environment (venv) for this tool.
  #   2. Install this package and all its Python dependencies into that venv.
  #
  # Why a venv? Without isolation, installing Python packages globally can
  # break other tools. A venv keeps macaudit's dependencies sandboxed.
  include Language::Python::Virtualenv

  # ----------------------------------------------------------------------------
  # Metadata
  # ----------------------------------------------------------------------------
  desc "Mac System Health Inspector & Auditor"   # Short one-line description shown by `brew info`
  homepage "https://github.com/gfreedman/mac_audit"  # Project's website, shown by `brew home macaudit`

  # The URL where Homebrew downloads the source code for this specific release.
  # This points to a .tar.gz archive (a compressed folder) of the v1.12.0 tag on GitHub.
  url "https://github.com/gfreedman/mac_audit/archive/refs/tags/v1.12.0.tar.gz"

  # A SHA-256 cryptographic checksum of the downloaded file.
  # After downloading, Homebrew hashes the file and compares it to this value.
  # If they don't match, the download is rejected — this protects against
  # corrupted downloads or tampered files (supply-chain security).
  sha256 "adcde666a7c216e22e8fc1148375bd49d3fe288be34acf7edeffdacbbd0ffd47"

  license "MIT"  # The open-source license under which macaudit is distributed

  # Optional: allows `brew install macaudit --HEAD` to install the latest
  # unreleased code straight from the main branch on GitHub (useful for testing
  # cutting-edge changes before an official release).
  head "https://github.com/gfreedman/mac_audit.git", branch: "main"

  # ----------------------------------------------------------------------------
  # System Dependencies
  # ----------------------------------------------------------------------------
  # macaudit is a Python application, so we need Python to run it.
  # `depends_on` tells Homebrew to install Python 3.12 first if it isn't
  # already present. Homebrew handles the dependency resolution automatically.
  depends_on "python@3.12"

  # ----------------------------------------------------------------------------
  # Python Package Dependencies (resources)
  # ----------------------------------------------------------------------------
  # macaudit is built on top of several third-party Python libraries.
  # Each `resource` block declares one of those libraries, where to download
  # it from (PyPI — the Python Package Index), and its SHA-256 checksum for
  # integrity verification (same idea as the main `sha256` above).
  #
  # Pinning exact URLs + checksums instead of just listing package names means
  # every install is 100% reproducible — the same bits, every time, for every user.

  # click — a library for building elegant command-line interfaces.
  # macaudit uses Click to define its CLI commands, flags, and help text.
  resource "click" do
    url "https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0/click-8.3.1.tar.gz"
    sha256 "12ff4785d337a1bb490bb7e9c2b1ee5da3112e94a8622f26a6c77f5d2fc6842a"
  end

  # markdown-it-py — a Markdown parser used by rich to render Markdown-formatted
  # text (like bold, italics, bullet lists) directly in the terminal.
  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/5b/f5/4ec618ed16cc4f8fb3b701563655a69816155e79e24a17b651541804721d/markdown_it_py-4.0.0.tar.gz"
    sha256 "cb0a2b4aa34f932c007117b194e945bd74e0ec24133ceb5bac59009cda1cb9f3"
  end

  # mdurl — a tiny URL-parsing utility required by markdown-it-py to correctly
  # handle links inside Markdown content.
  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  # pygments — a source-code syntax highlighter used internally by rich
  # to colorize code snippets and structured data in terminal output.
  resource "pygments" do
    url "https://files.pythonhosted.org/packages/b0/77/a5b8c569bf593b0140bde72ea885a803b82086995367bf2037de0159d924/pygments-2.19.2.tar.gz"
    sha256 "636cb2477cec7f8952536970bc533bc43743542f70392ae026374600add5b887"
  end

  # rich — a library for beautiful, colorful terminal output.
  # It powers macaudit's formatted tables, progress bars, and styled text.
  resource "rich" do
    url "https://files.pythonhosted.org/packages/b3/c6/f3b320c27991c46f43ee9d856302c70dc2d0fb2dba4842ff739d5f46b393/rich-14.3.3.tar.gz"
    sha256 "b8daa0b9e4eef54dd8cf7c86c03713f53241884e814f4e2f5fb342fe520f639b"
  end

  # simple-term-menu — provides interactive arrow-key menus in the terminal.
  # macaudit uses this so users can navigate audit options without typing commands.
  resource "simple-term-menu" do
    url "https://files.pythonhosted.org/packages/d8/80/f0f10b4045628645a841d3d98b584a8699005ee03a211fc7c45f6c6f0e99/simple_term_menu-1.6.6.tar.gz"
    sha256 "9813d36f5749d62d200a5599b1ec88469c71378312adc084c00c00bfbb383893"
  end

  # ----------------------------------------------------------------------------
  # Install Method
  # ----------------------------------------------------------------------------
  # `def install` is the method Homebrew calls to actually install the software.
  # Because we included the Language::Python::Virtualenv mixin above, we get
  # access to `virtualenv_install_with_resources`, which does all the heavy
  # lifting in one line:
  #
  #   1. Creates a Python venv inside Homebrew's Cellar (its storage directory).
  #   2. Installs every `resource` block defined above into that venv.
  #   3. Installs macaudit itself into the venv.
  #   4. Symlinks the `macaudit` executable into /usr/local/bin (or equivalent)
  #      so you can run it from anywhere in your terminal.
  def install
    virtualenv_install_with_resources
  end

  # ----------------------------------------------------------------------------
  # Caveats Method
  # ----------------------------------------------------------------------------
  # `def caveats` returns a string that Homebrew prints to the user after
  # installation completes. It's used for post-install instructions that the
  # user needs to act on manually — things Homebrew cannot do automatically
  # (like editing shell config files).
  #
  # <<~EOS ... EOS is a Ruby "heredoc": a convenient way to write a
  # multi-line string. The `~` strips leading whitespace so the text lines up
  # nicely in the source code without adding extra spaces to the output.
  def caveats
    <<~EOS
      To enable shell completion, add to your ~/.zshrc:
        eval "$(_MACAUDIT_COMPLETE=zsh_source macaudit)"

      For bash, add to ~/.bash_profile:
        eval "$(_MACAUDIT_COMPLETE=bash_source macaudit)"

      Then restart your terminal or run: source ~/.zshrc
    EOS
  end

  # ----------------------------------------------------------------------------
  # Test Block
  # ----------------------------------------------------------------------------
  # `test do` defines a simple sanity-check that Homebrew runs when you execute
  # `brew test macaudit`. It verifies the installation worked correctly.
  #
  # Here we run `macaudit --version` in a shell and check that its output
  # contains the expected version string (e.g. "1.12.0").
  #
  # `version.to_s` converts the Homebrew version object to a plain string like
  # "1.12.0". `shell_output` runs the command and returns its stdout as a string.
  # `assert_match` fails the test if the version string isn't found in the output.
  test do
    assert_match version.to_s, shell_output("#{bin}/macaudit --version")
  end

end
