class Bearlibterminal < Formula
  desc "BearLibTerminal is a library that creates a terminal-like window facilitating flexible textual output and uncomplicated input processing."
  homepage "https://bitbucket.org/cfyzium/bearlibterminal"
  version "0.15.7"
  url "http://foo.wyrd.name/_media/en:bearlibterminal:bearlibterminal_0.15.7_osx.zip"
  # url "https://bitbucket.org/cfyzium/bearlibterminal/get/tip.tar.bz2"
  sha256 "81b39ca7fdcd315a940398aa05cb2ae09e23377de32652bcf37753d2b802c371"
  head "https://bitbucket.org/cfyzium/bearlibterminal", :using => :hg

  depends_on "cmake" => :build

  option "with-sample", "install SampleOmni, which shows off the capabilities"

  def install
    system "cmake", ".", *std_cmake_args
    if build.with? "sample"
      system "make"
      bin.install "Output/Darwin64/SampleOmni"
      mv bin/"SampleOmni", bin/"blt-sample"
    else
      system "make", "BearLibTerminal"
    end
    lib.install "Output/Darwin64/libBearLibTerminal.dylib"
   end
end
