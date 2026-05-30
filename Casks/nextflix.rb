cask "nextflix" do
  version "1.0.0"
  sha256 "bc737d8e89bfa3082ad8cc00903b8469e61d5374136e17cd90e330fbb03f2626"

  url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-arm64_Nextflix_#{version}_aarch64.dmg",
      verified: "github.com/dungxtd/homebrew-tap/"
  name "Nextflix"
  desc "Torrent-streaming video player built with Tauri + libmpv"
  homepage "https://github.com/dungxtd/nextflix"

  depends_on macos: ">= :catalina"
  depends_on arch: :arm64

  app "Nextflix.app"

  zap trash: [
    "~/Library/Application Support/nextflix",
    "~/Library/Logs/Nextflix",
    "~/Library/Caches/nextflix",
    "~/Library/Preferences/nextflix.plist",
  ]
end
