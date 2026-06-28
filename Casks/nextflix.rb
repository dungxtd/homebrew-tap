cask "nextflix" do
  version "1.0.3"

  on_arm do
    sha256 "1ab91e2d35d147993042a0b1a25579d3df6b5f99606e9369fb2226e40e4eeaaa"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-arm64_Nextflix_#{version}_aarch64.dmg",
        verified: "github.com/dungxtd/homebrew-tap/"
  end

  on_intel do
    sha256 "97f8a2f9ff609793f0986d9d8acce262ee10b94914f9bc8fe4a5ea62f1816cba"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-x64_Nextflix_#{version}_x64.dmg",
        verified: "github.com/dungxtd/homebrew-tap/"
  end

  name "Nextflix"
  desc "Torrent-streaming video player built with Tauri + libmpv"
  homepage "https://github.com/dungxtd/nextflix"

  depends_on macos: ">= :catalina"

  app "Nextflix.app"

  # The DMG is ad-hoc signed (no Apple Developer ID + notarization yet), so
  # Gatekeeper attaches com.apple.quarantine and refuses to launch the app
  # with "damaged/cannot verify" on first open. Strip the attribute on install.
  # Remove this block once we move to Developer ID + notarytool.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Nextflix.app"]
  end

  zap trash: [
    "~/Library/Application Support/nextflix",
    "~/Library/Logs/Nextflix",
    "~/Library/Caches/nextflix",
    "~/Library/Preferences/nextflix.plist",
  ]
end
