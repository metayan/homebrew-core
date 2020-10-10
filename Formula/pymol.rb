class Pymol < Formula
  desc "OpenGL based molecular visualization system"
  homepage "https://pymol.org/"
  url "https://github.com/schrodinger/pymol-open-source/archive/v2.2.0.tar.gz"
  sha256 "58d910103dc494c49c86bc8fd6cd94b1a030647f9d72f69fbd7d7ad25fb11233"
  head "https://github.com/schrodinger/pymol-open-source.git"

  bottle do
    cellar :any
    sha256 "360f9b56c4d7b424d467fac925591ac059380d4257d1d61c6f6af46b8d6689e4" => :sierra
    sha256 "6808607ebd79f398f42bc479d6b48697bad55289f0b52df0af2f5b3ff9404bab" => :el_capitan
    sha256 "217df24e99b9b96b13a9b33b137bb3ba811c407d79896091e1ef443074030df6" => :yosemite
  end

  depends_on "glew"
  depends_on "python" => "with-tcl-tk"
  depends_on "tcl-tk" => ["with-threads", "with-x11"]
  depends_on :x11

  def install
    ENV.append_to_cflags "-Qunused-arguments" if MacOS.version < :mavericks

    system "python", "-s", "setup.py", "install",
                     "--bundled-pmw",
                     "--install-scripts=#{libexec}/bin",
                     "--install-lib=#{libexec}/lib/python2.7/site-packages"

    bin.install libexec/"bin/pymol"
  end

  def caveats; <<-EOS
    On some Macs, the graphics drivers do not properly support stereo
    graphics. This will cause visual glitches and shaking that stay
    visible until X11 is completely closed. This may even require
    restarting your computer. Launch explicitly in Mono mode using:
      pymol -M
    EOS
  end

  test do
    system bin/"pymol", libexec/"lib/python2.7/site-packages/pymol/pymol_path/data/demo/pept.pdb"
  end
end
