cask "nextflix" do
  version "1.0.7"

  on_arm do
    sha256 "387e3cd97902db51f91151db0debdad3a200bda61cdd7c05cc971e6666fe8d34"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-arm64_Nextflix_#{version}_aarch64.dmg"
  end

  on_intel do
    sha256 "09374b231d0dfe286b4140690937f74732a3d3c93e1e23da7e879d4ff979e5b8"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-x64_Nextflix_#{version}_x64.dmg"
  end

  name "Nextflix"
  desc "Next version of flix"
  homepage "https://github.com/dungxtd/homebrew-tap"

  depends_on macos: :big_sur

  app "Nextflix.app"

  # The DMG is ad-hoc signed (no Apple Developer ID + notarization yet), so
  # Gatekeeper attaches com.apple.quarantine and refuses to launch the app
  # with "damaged/cannot verify" on first open. Strip the attribute on install.
  # Remove this block once we move to Developer ID + notarytool.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Nextflix.app"]
  end

  zap trash: [
    "~/Library/Application Support/nextflix",
    "~/Library/Logs/Nextflix",
    "~/Library/Caches/nextflix",
    "~/Library/Preferences/nextflix.plist",
  ]
end
