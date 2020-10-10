class HasuraCli < Formula
  # from https://github.com/Kjens93/homebrew-core/commit/cbde7433f37d523d57189b59c0c63577323f9fe6
  # https://github.com/Homebrew/homebrew-core/pull/45754
  # https://github.com/Homebrew/homebrew-core/pull/45755
  desc "Command-Line Interface for Hasura GraphQL Engine"
  homepage "https://hasura.io"

  version "1.1.0-beta.3"
  url "https://github.com/hasura/graphql-engine/archive/v#{version}.tar.gz"
  sha256 "1218b50ddfbb2fd4d2f253202a7f7d96c73a675e3434b59e66d3c1e040e922b7"

  head "https://github.com/hasura/graphql-engine.git", :shallow => true

  depends_on "go" => :build

  def install
    Dir.chdir("cli")
    modname = "github.com/hasura/graphql-engine/cli"
    exflags = '-extldflags "-static"'
    ldflags = "-ldflags '-X #{modname}/version.BuildVersion=#{version} -s -w #{exflags}'"
    File.open("build.sh", "w") do |file|
      # Using a build file to work around an odd string interpolation issue with the single/double quotes
      file.puts "set -eox pipefail"
      #file.puts "go mod init #{modname}"
      file.puts "go build -o ./bin/hasura -a -v #{ldflags} ./cmd/hasura/"
    end
    chmod "+x", "build.sh"
    system "./build.sh"
    bin.install "./bin/hasura"
  end

  test do
    # TODO: add real test case, as mentioned in
    # https://github.com/Homebrew/homebrew-core/pull/45755
    assert_includes shell_output("#{bin}/hasura version").strip, "v#{version}"
  end
end
