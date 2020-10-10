class Sshfs3 < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://osxfuse.github.io/"
  url "https://github.com/libfuse/sshfs/releases/download/sshfs-2.10/sshfs-2.10.tar.gz"
  sha256 "70845dde2d70606aa207db5edfe878e266f9c193f1956dd10ba1b7e9a3c8d101"
  license "GPL-2.0"
  revision 2
  head "https://github.com/libfuse/sshfs.git", shallow: false

  livecheck do
    url :stable
    regex(/^sshfs[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    cellar :any
    sha256 "aceff3131dd0b098bdef8b5dda54d117b5dd5269ca146f7a5032ecde3c99b6d2" => :catalina
    sha256 "5f69267c0f1f2489989e108919d66210e058423d0d1f1661812c0194b164619c" => :mojave
    sha256 "58d222f37622b399352f16eaf823d3e564445d9e951629e965281ac31de5ef4a" => :high_sierra
    sha256 "dc4a7f24c2cbebd7c35891200b043d737ba6586a28992708ef849ffedff7bb01" => :sierra
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on :osxfuse

  def install
    mkdir "build" do
      system "meson", "--prefix=#{prefix}", ".."
      system "ninja", "install"
    end
  end

  test do
    system "#{bin}/sshfs", "--version"
  end
end
