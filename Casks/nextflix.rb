cask "nextflix" do
  version "1.0.3"

  on_arm do
    sha256 "0af4e76539b0c610cf5e8fd20971f303cf5860b7040c29796b0a6e8db87fce38"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-arm64_Nextflix_#{version}_aarch64.dmg",
        verified: "github.com/dungxtd/homebrew-tap/"
  end

  on_intel do
    sha256 "8226bea55a8e4555735f4b2fa704396f00daf8cf6da58c137066879d9974aa72"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-x64_Nextflix_#{version}_x64.dmg",
        verified: "github.com/dungxtd/homebrew-tap/"
  end

  name "Nextflix"
  desc "Torrent-streaming video player built with Tauri + libmpv"
  homepage "https://github.com/dungxtd/nextflix"

  depends_on macos: :catalina

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
