# Tendina is the old name of Blinds (up to 1.1.0). This formula only exists
# so people who installed it are told to switch to the blinds formula.
class Tendina < Formula
  desc "Old name of Blinds, a menu bar icon hider for macOS 27"
  homepage "https://github.com/massimodascola/blinds"
  url "https://github.com/massimodascola/blinds/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b0e0f46b3da2fa28513502bf174db731bf403f149e8fa9650456fea70b1a367a"
  license "MIT"

  deprecate! date: "2026-09-23", because: "has been renamed to blinds", replacement_formula: "blinds"

  depends_on arch: :arm64
  depends_on :macos

  def install
    system "sh", "build.sh"
    prefix.install "build/Tendina.app"
  end

  test do
    assert_path_exists prefix/"Tendina.app/Contents/MacOS/Tendina"
  end
end
