class VsPlacebo < Formula
  desc "Libplacebo plugin for VapourSynth"
  homepage "https://github.com/Lypheo/vs-placebo"
  url "https://github.com/Lypheo/vs-placebo/archive/refs/tags/1.4.4.tar.gz"
  sha256 "9aac4a0867fab5eb6ffbd0ef98c9359bbec88d6d9cfc9db679a777924806c144"
  license "LGPL-2.1-only"
  head "https://github.com/Lypheo/vs-placebo.git", branch: "master"

  bottle do
    root_url "https://github.com/saindriches/homebrew-vapoursynth/releases/download/vs-placebo-1.4.4"
    sha256 cellar: :any, arm64_ventura: "ad7d777cd8b2675a26e4a73a6df520aa3fc0a66273b2ca3af689cf3a44553c60"
    sha256 cellar: :any, ventura:       "9bc32b443818f2600f2757b8aee5dcc922e43abe4a41590babbd24a0f9bc9a86"
    sha256               x86_64_linux:  "ca2b61532475fdb921cb7e623b5c82846ca57367887ff9083080c3254feafbe8"
  end

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "libplacebo"
  depends_on "saindriches/vapoursynth/dovi"
  depends_on "vapoursynth"

  patch :DATA

  def install
    system "git", "clone", "https://github.com/sekrit-twc/libp2p" unless build.head?

    system "meson", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"

    (lib/"vapoursynth").mkpath
    (lib/"vapoursynth").install_symlink lib/shared_library("libvs_placebo").to_s
  end
end

__END__
diff --git a/meson.build b/meson.build
index fcf17f6..12b8fce 100644
--- a/meson.build
+++ b/meson.build
@@ -30,6 +30,6 @@ shared_module('vs_placebo', sources,
   dependencies: [placebo, vapoursynth_dep, dovi],
   link_with: [p2p],
   name_prefix: 'lib',
-  install_dir : join_paths(vapoursynth_dep.get_variable(pkgconfig: 'libdir'), 'vapoursynth'),
+#  install_dir : join_paths(vapoursynth_dep.get_variable(pkgconfig: 'libdir'), 'vapoursynth'),
   install: true
 )
