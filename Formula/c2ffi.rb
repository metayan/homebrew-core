class C2ffi < Formula
  desc "Tool for extracting definitions from C, C++, and Objective C headers for use with foreign function call interfaces"
  homepage "https://github.com/rpav/c2ffi"
  head "https://github.com/rpav/c2ffi.git", :branch => "llvm-10.0.0"

  depends_on "cmake" => :build
  depends_on "llvm"

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
