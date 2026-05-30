cask "nextflix" do
  version "1.0.2"
  sha256 "98c3429b66a248c7ebace2593924362f033952fd9f3e73972ad06211cece19f4"

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
