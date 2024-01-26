class Fft3dfilter < Formula
  desc "VapourSynth port of FFT3DFilter"
  homepage "https://github.com/myrsloik/VapourSynth-FFT3DFilter"
  url "https://github.com/myrsloik/VapourSynth-FFT3DFilter/archive/refs/tags/R2.tar.gz"
  sha256 "d6656e265da213bb396bab5cc0455522c491494cd2954a54c013788323e231f1"
  license "GPL-2.0-only"
  head "https://github.com/myrsloik/VapourSynth-FFT3DFilter.git", branch: "master"

  bottle do
    root_url "https://github.com/saindriches/homebrew-vapoursynth/releases/download/fft3dfilter-2"
    sha256 cellar: :any, arm64_ventura: "1619258867870f43ff13d6d20c0a09c72abe392c3b144ac560b144fbe9f9a9a9"
    sha256 cellar: :any, ventura:       "7549cba7b3ce0a07b30172e9cf9c96588957df520652d0a44e563732fd15c2cf"
    sha256               x86_64_linux:  "194fa1ccbd9af638027f8208a2a91e4331de7b72f20423e0c83347eb4918a2b3"
  end

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "vapoursynth"

  patch :DATA

  def install
    lib.mkpath
    (lib/"vapoursynth").mkpath

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    cd "build" do
      cp shared_library("libfft3dfilter").to_s, lib/"vapoursynth/"
    end
  end
end

__END__
diff --git a/meson.build b/meson.build
index c8f6cec..8a95495 100644
--- a/meson.build
+++ b/meson.build
@@ -43,5 +43,5 @@ endif
 shared_module('fft3dfilter', sources,
   dependencies : deps,
   install : true,
-  install_dir : join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')
+#  install_dir : join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')
 )
