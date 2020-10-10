class Virtualgl < Formula
  desc "Use OpenGL on a remote GPU"
  homepage "https://virtualgl.org"
  head "https://github.com/VirtualGL/virtualgl.git"
  depends_on "cmake" => :build
  depends_on "glew"
  depends_on "jpeg-turbo"

  def install
    system "cmake", ".", *std_cmake_args
    #system "cmake", ".", *std_cmake_args, "-DTJPEG_INCLUDE_DIR=/usr/local/opt/jpeg-turbo/include -DTJPEG_LIBRARY=/usr/local/opt/jpeg-turbo/lib/libturbojpeg.dylib"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
