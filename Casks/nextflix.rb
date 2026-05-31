cask "nextflix" do
  version "1.0.1"
  sha256 "881ef15b9ae8f82f6123083d0f4bb0f9a3306f230c897704ee3b9ae422357de3"

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
