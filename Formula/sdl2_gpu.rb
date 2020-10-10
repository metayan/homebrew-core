class Sdl2Gpu < Formula
  desc "library for making hardware-accelerated 2D graphics easy"
  homepage "https://grimfang4.github.io/sdl-gpu/"
  url "https://github.com/grimfang4/sdl-gpu/archive/v0.10.0.tar.gz"
  sha256 ""
  head "https://github.com/grimfang4/sdl-gpu.git"

  bottle do
    cellar :any
  end

  depends_on "cmake" => :build
  depends_on "sdl2"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "echo", *std_cmake_args
#    system "#{bin}/solarus-run", "-help"
  end
end
