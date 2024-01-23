class Dovi < Formula
  desc "Library to read & write Dolby Vision metadata"
  homepage "https://github.com/quietvoid/dovi_tool"
  url "https://github.com/quietvoid/dovi_tool/archive/refs/tags/2.1.0.tar.gz"
  sha256 "06b7332649959710ec00e25a9b4e4a88ee7766149726d6e2f60c3b5bb6292664"
  license "MIT"
  head "https://github.com/quietvoid/dovi_tool.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/saindriches/homebrew-vapoursynth/releases/download/dovi-2.1.0"
    sha256 cellar: :any,                 arm64_ventura: "3142ac9114cd3f3a1fe4f9c97704984b1a8cda7cadf38bf1449b5aef41708df4"
    sha256 cellar: :any,                 ventura:       "1ec68c7db3d907c30adc7e20fd805bf26f85fef039820afe11fbd96c023e4c5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b613b7ef5fb45d220431e0b194ad30e0a7b2787b457a0ac7532fdf8f06800a55"
  end

  depends_on "rust" => :build

  def install
    cd "dolby_vision" do
      system "cargo", "install", "cargo-c"
      system "cargo", "cinstall", "--prefix=#{prefix}"
    end
  end
end
