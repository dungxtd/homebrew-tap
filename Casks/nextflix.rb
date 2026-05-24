cask "nextflix" do
  version "1.0.1"
  sha256 "REPLACE_WITH_DMG_SHA256_AFTER_FIRST_RELEASE"

  url "https://github.com/dungxtd/nextflix/releases/download/v#{version}/Nextflix_#{version}_aarch64.dmg",
      verified: "github.com/dungxtd/nextflix/"
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
