class Openvr < Formula
  desc "OpenVR"
  homepage "https://github.com/ValveSoftware/openvr"
  url "https://github.com/ValveSoftware/openvr.git"
  version "1.0.11"
  sha256 ""

  depends_on "cmake" => :build

  def install
    # To build a shared library, pass -DBUILD_SHARED=1 to cmake.
    # To build as a framework on apple platforms, pass -DBUILD_FRAMEWORK=1 to cmake.
    #system "cmake", ".", "-DBUILD_FRAMEWORK=1", *std_cmake_args
    system "cmake", ".", "-DBUILD_SHARED=1", *std_cmake_args
    system "make", "install"
  end
end
