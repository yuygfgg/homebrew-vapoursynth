class Bm3d < Formula
  desc "Denoising filter for VapourSynth"
  homepage "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D"
  url "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D/archive/refs/tags/r9.tar.gz"
  sha256 "3eb38c9e4578059042c96b408f5336b18d1f3df44896954713532cff735f1188"
  license "MIT"
  head "https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D.git", branch: "master"

  bottle do
    root_url "https://github.com/saindriches/homebrew-vapoursynth/releases/download/bm3d-9"
    sha256 cellar: :any,                 arm64_ventura: "23917bed0ef01b8a23d8f664b5687ce9eab4f3e77473113f91a15c0dcd32603f"
    sha256 cellar: :any,                 ventura:       "29b94f623f74423e966fd3e049112110477cd7493a0fd0d0af027404eacee1db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83d4ba19cbc6c0242e4d9f0df9c52366f9b102bfbdde11bae566027ed83915c5"
  end

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "vapoursynth"

  patch :DATA

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    cd lib do
      mkdir "vapoursynth"
      mv shared_library("libbm3d").to_s, "vapoursynth"
    end
  end
end

__END__
diff --git a/meson.build b/meson.build
index 66f9131..05ba5d7 100644
--- a/meson.build
+++ b/meson.build
@@ -46,6 +46,6 @@ shared_module('bm3d', sources,
   dependencies : [vapoursynth_dep, fftw3f_dep],
   include_directories : include_directories('include'),
   install : true,
-  install_dir : join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth'),
+#  install_dir : join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth'),
   gnu_symbol_visibility : 'hidden'
 )
