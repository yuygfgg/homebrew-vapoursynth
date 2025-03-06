class Bestsource < Formula
  desc "A super great audio/video source and FFmpeg wrapper"
  homepage "https://github.com/vapoursynth/bestsource"
  license "MIT"
  head "https://github.com/vapoursynth/bestsource.git", branch: "master"

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "llvm" => :build
  depends_on "lld" => :build
  depends_on "ffmpeg"
  depends_on "vapoursynth"
  depends_on "xxhash"

  patch :DATA

  def install
    ENV["CC"] = Formula["llvm"].opt_bin/"clang"
    ENV["CXX"] = Formula["llvm"].opt_bin/"clang++"
    ENV.prepend_path "PATH", Formula["llvm"].opt_bin

    args = std_meson_args
    args << "-Dcpp_link_args=-fuse-ld=lld"
    args << "-Denable_plugin=true"
    
    system "meson", "setup", "build", *args
    system "ninja", "-C", "build"
    system "ninja", "-C", "build", "install"

    cd lib do
      mkdir "vapoursynth"
      mv shared_library("bestsource").to_s, "vapoursynth"
    end
  end

  test do
    assert_predicate lib/"libbestsource.dylib", :exist?
    
    assert_predicate include/"bestsource/bsshared.h", :exist?
    
    assert_predicate lib/"vapoursynth/bestsource.dylib", :exist?
  end
end

__END__
diff --git a/meson.build b/meson.build
index 0000000..0000000 100644
--- a/meson.build
+++ b/meson.build
@@ -146,7 +146,7 @@
         dependencies: [bestsource_dep, vapoursynth_dep, avutil_dep.partial_dependency(compile_args: true, includes: true)],
         gnu_symbol_visibility: 'hidden',
         install: true,
-        install_dir: vapoursynth_dep.get_variable(pkgconfig: 'libdir') / 'vapoursynth',
+        #install_dir: vapoursynth_dep.get_variable(pkgconfig: 'libdir') / 'vapoursynth',
         install_rpath: install_rpath,
         link_args: link_args,
         name_prefix: '',
