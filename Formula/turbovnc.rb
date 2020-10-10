class Turbovnc < Formula
  desc ""
  homepage "https://turbovnc.org"
  url "https://downloads/sourceforge.net/project/turbovnc/2.2.2/turbovnc-2.2.2.tar.gz"
#  sha256 "4057ab431fda4d5f986f6adafa3ec3474eda444ccd52ff2412f669dd21f630c0"
  head "https://github.com/TurboVNC/turbovnc"
  depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test turbovnc`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
