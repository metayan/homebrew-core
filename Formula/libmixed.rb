class Libmixed < Formula
  desc "Sound mixing library"
  homepage "https://github.com/Shirakumo/libmixed"
  head "https://github.com/Shirakumo/libmixed.git"
  license "Zlib"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
