class Projectm < Formula
  version "3.1.1-rc3"
  desc "Visualizer"
  homepage "https://github.com/projectM-visualizer/projectm"
  head "https://github.com/projectM-visualizer/projectm.git"

  def install
    system "./autogen.sh"
    #system "autoreconf --install"
    #ENV.append "LDFLAGS", "-L#{Formula["apr-util"].opt_libexec}/lib"
    #ENV.append "LDFLAGS", "-L#{Formula["apr"].opt_libexec}/lib"
    #ENV.append "CFLAGS", "-I#{Formula["apr"].opt_libexec}/include/apr-1"
    #ENV.append "CFLAGS", "-I#{Formula["apr-util"].opt_libexec}/include/apr-1"
    ENV.prepend "PATH", "/usr/local/opt/qt/bin:"
    ENV.append "LDFLAGS", "-L/usr/local/opt/qt/lib"
    ENV.append "CPPFLAGS", "-I/usr/local/opt/qt/include"
    ENV.append "PKG_CONFIG_PATH", "/usr/local/opt/qt/lib/pkgconfig"

    system "./configure", "--enable-sdl", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test projectm`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
