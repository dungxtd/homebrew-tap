# Written by ckpro's own release workflow (dungxtd/ckpro), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on ckpro's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "ckpro" do
  version "0.3.4"
  sha256 arm:          "c3a35f8b123bbf1063d5154d6b60f274c0e76a988d1ff892dd9a829cc9cef6bd",
         intel:        "44dca8f8c34ca2a3e6e90b5969b4d1af41c470c8b7ba2a2e2a04ecf59e37dd70",
         arm64_linux:  "0bc927158530c0fcf9df4b2a856c0362e5a9c1f2c5dc4021c7d0bbda306c92d7",
         x86_64_linux: "8ca2cee24d2d94352bd10a0f3a854d6dfa03b3a6bf2642bbd2922cd2cd2ff9e0"

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
