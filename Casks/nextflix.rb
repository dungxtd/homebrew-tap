cask "nextflix" do
  version "1.0.2"
  sha256 "578935078602a64cbeb902269a782c94a4fb5825a84ff3f2c8f3df1bf1780191"

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
