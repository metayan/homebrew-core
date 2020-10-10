class Ccl < Formula
  desc "CCL - Clozure Common Lisp"
  homepage "https://ccl.clozure.com"

  bottle do
    cellar :any_skip_relocation
    sha256 "8725b08fc19b2330d25b78d56d06564b01f8c70ec09763a5a6823db05b81d928" => :mojave
    sha256 "06426d4b5d6f5875734eac8d6bac1e1a99e37b6ca26696d458274eb36b23e8b0" => :high_sierra
    sha256 "f4bbb8190f307cfc272e80879e88c51e1ca8bf9382fcf93b0cc628e7169fe522" => :sierra
  end

  depends_on :xcode => :build

  stable do
    version "v1.12"
    url "https://github.com/Clozure/ccl/archive/#{version}.tar.gz"
    sha256 "774a06b4fb6dc4b51dfb26da8e1cc809c605e7706c12180805d1be6f2885bd52"
    resource "bootstrap" do
      url "https://github.com/Clozure/ccl/releases/download/v1.12/darwinx86.tar.gz"
      sha256 "9434fb5ebc01fc923625ad56726fdd217009e2d3c107cfa3c5435cb7692ba7ca"
    end
  end

  # stable do
  #   version "v1.11.8"
  #   url "https://github.com/Clozure/ccl/archive/#{version}.tar.gz"
  #   sha256 "6a496d35e05dc3e6e7637884552b1f14c82296525546f28337b222e4c3d7d50b"
  #   resource "bootstrap" do
  #     url "https://github.com/Clozure/ccl/releases/download/v1.11.5/ccl-1.11.5-darwinx86.tar.gz"
  #     sha256 "5adbea3d8b4a2e29af30d141f781c6613844f468c0ccfa11bae908c3e9641939"
  #   end
  # end

  # devel do
  #   version "v1.12-dev.5"
  #   url "https://github.com/Clozure/ccl/archive/#{version}.tar.gz"
  #   sha256 "90378487ff9f564e05883b1ab7c8dfb583a6ec5f5136f7002198f32d3253eb76"
  #   resource "bootstrap" do
  #     url "https://github.com/Clozure/ccl/releases/download/v1.12-dev.5/darwinx86.tar.gz"
  #     sha256 "c716ba5db9c85a8ef389be7975fe71832a9ed5cd2971ab1ad6f8bc5c9a2231e1"
  #   end
  # end

  head do
    url "https://github.com/Clozure/ccl.git"
    resource "bootstrap" do
      url "https://github.com/Clozure/ccl/releases/download/v1.12/darwinx86.tar.gz"
      sha256 "9434fb5ebc01fc923625ad56726fdd217009e2d3c107cfa3c5435cb7692ba7ca"
    end
  end

  def install
    tmpdir = Pathname.new(Dir.mktmpdir)
    tmpdir.install resource("bootstrap")
    buildpath.install tmpdir/"dx86cl64.image"
    buildpath.install tmpdir/"darwin-x86-headers64"
    cd "lisp-kernel/darwinx8664" do
      system "make"
    end

    ENV["CCL_DEFAULT_DIRECTORY"] = buildpath

    system "./dx86cl64", "-n",
                         "-e", "(rebuild-ccl :full t)'",
                         "-e", "(require 'cocoa-application)",
                         "-e", "(quit)"

    prefix.install "Clozure CL64.app"
    prefix.install "doc/README"
    doc.install Dir["doc/*"]
    libexec.install Dir["*"]
    bin.install Dir["#{libexec}/scripts/ccl64"]
    bin.env_script_all_files(libexec/"bin", :CCL_DEFAULT_DIRECTORY => libexec)
  end

  test do
    output = shell_output("#{bin}/ccl64 -n -e '(write-line (write-to-string (* 3 7)))' -e '(quit)'")
    assert_equal "21", output.strip
  end
end
