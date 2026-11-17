# Written by ckpro's own release workflow (dungxtd/ckpro), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on ckpro's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "ckpro" do
  version "0.3.3"
  sha256 arm:          "6ef39ec547a67a7f5d9d5e7db8042035104b02cdbbb620e64c1684205cea72e3",
         intel:        "8b83da0d44a0c15b8ea5aa14d59df2b685dd0284fc671ba3cd1fb5a675b8e2dc",
         arm64_linux:  "21c2fe79c0a5cb5630db08d2088139a558020dd04d44300904ccb1549546a3d5",
         x86_64_linux: "7b53755aaac07db9e674aa1add314c0167d23822002a6c502eb72e6b70ed1997"

  on_macos do
    on_arm do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_#{version}_macos-arm64.dmg"
    end
    on_intel do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_#{version}_macos-x64.dmg"
    end

    app "CKPro.app"

    # Ad-hoc signed (no Developer ID or notarization yet): Gatekeeper would
    # refuse it as damaged on first open, so the quarantine flag goes on install
    postflight_steps do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/CKPro.app"]
    end

    # The app's database, kubeconfigs and logs, in ckpro (dev.ckpro.app up
    # to 0.3); its Docker containers stay (remove them with
    # `docker compose -p ckpro down`)
    zap trash: [
      "~/Library/Application Support/ckpro",
      "~/Library/Application Support/dev.ckpro.app",
      "~/Library/Caches/dev.ckpro.app",
      "~/Library/Caches/dev.ckpro.CKPro",
      "~/Library/HTTPStorages/dev.ckpro.CKPro",
      "~/Library/Logs/dev.ckpro.app",
      "~/Library/Preferences/dev.ckpro.app.plist",
      "~/Library/Preferences/dev.ckpro.CKPro.plist",
      "~/Library/Saved Application State/dev.ckpro.CKPro.savedState",
      "~/Library/WebKit/dev.ckpro.app",
      "~/Library/WebKit/dev.ckpro.CKPro",
    ]
  end
  on_linux do
    on_arm do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_#{version}_linux-arm64.AppImage"

      app_image "ckpro_#{version}_linux-arm64.AppImage", target: "ckpro.AppImage"
    end
    on_intel do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_#{version}_linux-x64.AppImage"

      app_image "ckpro_#{version}_linux-x64.AppImage", target: "ckpro.AppImage"
    end

    # The app's database, kubeconfigs and logs, in ckpro (dev.ckpro.app up
    # to 0.3); its Docker containers stay
    zap trash: [
      "~/.cache/dev.ckpro.app",
      "~/.config/dev.ckpro.app",
      "~/.local/share/ckpro",
      "~/.local/share/dev.ckpro.app",
    ]
  end

  name "CKPro"
  desc "Practice the CKA, CKAD and CKS exams on local Kubernetes clusters"
  homepage "https://github.com/dungxtd/ckpro"
end
