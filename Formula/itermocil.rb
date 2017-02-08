class Itermocil < Formula
  # desc "iTermocil allows you setup pre-configured layouts of panes in iTerm2."
  # Convert to local fork, but leave correct homepage
  homepage "https://github.com/TomAnthony/itermocil"
  url "https://github.com/rowleyaj/itermocil/archive/0.2.1+ra.tar.gz"
  sha256 "110e26a2924af2dd425e8288ed127ed9b940d231ab01424a4294e1ecdaeebf9f"

  resource "PyYAML" do
    url "https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.11.tar.gz"
    sha256 "c36c938a872e5ff494938b33b14aaa156cb439ec67548fcab3535bb78b0846e8"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    %w[PyYAML].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install "itermocil"
    bin.install "itermocil.py"

    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/itermocil", "-h"
  end
end
