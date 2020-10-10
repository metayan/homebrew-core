class Scsh < Formula
  desc ""
  homepage "http://www.scsh.net/"
  url "http://ftp.scsh.net/pub/scsh/0.6/scsh-0.6.7.tar.gz"
  version "0.6.7"
  sha256 ""

  depends_on "scheme48" => :build

  def install
    system "autoreconf"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
