cask "nextflix" do
  version "1.0.5"

  on_arm do
    sha256 "6d3293a40415f0600bbab10be75c28f11f455ea9b8cb6c50749fdefa633349e6"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-arm64_Nextflix_#{version}_aarch64.dmg"
  end

  on_intel do
    sha256 "ed1e28d834c20c060faa464b9a08490cbfe38ee72e19edfa5491c85ab50d4d53"
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
