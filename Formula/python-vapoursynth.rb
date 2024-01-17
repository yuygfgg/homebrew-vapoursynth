class PythonVapoursynth < Formula
  desc "Python wrapper of VapourSynth"
  homepage "https://www.vapoursynth.com"
  url "https://github.com/vapoursynth/vapoursynth/archive/refs/tags/R65.tar.gz"
  sha256 "2bde5233b82d914b5e985119ed9cc344e3c27c3c068b5c4ab909176cd1751dce"
  license "LGPL-2.1-or-later"
  head "https://github.com/vapoursynth/vapoursynth.git", branch: "master"

  livecheck do
    url :stable
    regex(/^R(\d+(?:\.\d+)*?)$/i)
  end

  depends_on "python-setuptools" => :build
  depends_on "python@3.12" => :build
  depends_on "vapoursynth"

  patch :DATA if OS.mac?

  def pythons
    deps.map(&:to_formula).sort_by(&:version).filter { |f| f.name.start_with?("python@") }
  end

  def install
    pythons.each do |python|
      python_exe = python.opt_libexec/"bin/python"
      system python_exe, "-m", "pip", "install", *std_pip_args, "."
    end
  end
end

__END__
diff --git a/setup.py b/setup.py
index ad19acb..e39dfd9 100644
--- a/setup.py
+++ b/setup.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python
-
+import os.path
+import sys
 from os import curdir
 from os.path import dirname, exists, join
 from pathlib import Path
@@ -15,6 +16,12 @@ extra_data = {}

 library_dirs = [curdir, "build"]

+if sys.platform == 'darwin' and (os.path.exists('/usr/local/bin/brew') or os.path.exists('/opt/homebrew')):
+    with os.popen('brew --prefix vapoursynth') as brew_prefix_cmd:
+        prefix = brew_prefix_cmd.read().strip()
+    vapoursynth_path = os.path.join(prefix, 'lib')
+    library_dirs.append(vapoursynth_path)
+
 is_portable = False
 self_path = Path(__file__).resolve()
 CURRENT_RELEASE = self_path.parent.joinpath('VAPOURSYNTH_VERSION').read_text('utf8').split(' ')[-1].strip().split('-')[0]
