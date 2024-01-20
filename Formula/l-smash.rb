class LSmash < Formula
  desc "Cross-platform library that handles the ISO Base Media file format"
  homepage "https://l-smash.github.io/l-smash"
  url "https://github.com/vimeo/l-smash/archive/refs/tags/v2.18.0.tar.gz"
  sha256 "9a2ae612e3d84116225725013cda2a6e996f65767d923fc07bb67025de9d2215"
  license "ISC"
  revision 1
  head "https://github.com/vimeo/l-smash.git", branch: "master"

  bottle do
    root_url "https://github.com/saindriches/homebrew-vapoursynth/releases/download/l-smash-2.18.0_1"
    sha256 cellar: :any,                 arm64_ventura: "4bad42799c0840af427717b6b95d1d6d0d64a32593eb131d6842d3ee38ca8d35"
    sha256 cellar: :any,                 ventura:       "e425f51161dad8dca817597d6594446768ffdb203842fc4a1a897a2a8948b214"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a82061c6f8b17cb85a2b2fdd05a61b05a02f76098d78147ed27e025a9fdb9737"
  end

  depends_on "saindriches/vapoursynth/obuparse"

  def install
    ENV.append_to_cflags "-fPIC" if OS.linux?

    system "./configure", "--prefix=#{prefix}", "--extra-cflags=#{ENV.cflags}"
    system "make", "install"
  end
end
