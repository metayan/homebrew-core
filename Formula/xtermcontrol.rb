class Xtermcontrol < Formula
  desc "Dynamic Control of XFree86 xterm Properties"
  # xtermcontrol makes it easy to change colors, title, font \
  # and geometry of a running xterm, as well as to report the current settings \
  # of these properties
  homepage "http://www.thrysoee.dk/xtermcontrol/"
  url "http://thrysoee.dk/xtermcontrol/xtermcontrol-3.3.tar.gz"
  head "https://github.com/JessThrysoee/xtermcontrol"
  sha256 "45f69a307580a8e650ddc60b048bff70355ba0d62c1ef5aeae570dd22d0b4cec"

  bottle :unneeded

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "xterm -e make test"
  end
end
