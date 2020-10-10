class Xournal < Formula
  desc "take notes and annotate images or PDFs"
  homepage "http://sourceforge.net/projects/xournal"
  url "http://downloads.sourceforge.net/xournal/xournal-0.4.8.2016.tar.gz"
  version "0.4.8.2016"
  sha256 "b25898dbd7a149507f37a16769202d69fbebd4a000d766923bbd32c5c7462826"
  head "https://git.code.sf.net/p/xournal/code"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    #system "make", "install" # if this fails, try separate make/make install steps
  end

end
