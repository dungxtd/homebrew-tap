# Written by ckpro's own release workflow (dungxtd/ckpro), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on ckpro's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "ckpro" do
  version "0.3.2"
  sha256 arm:          "f71eeb3efb34e8130b9e00531ed4d2d5e9562b81f4c5450e5c9bdce43c1f3be2",
         intel:        "403604e651ddb65754c475937921f8e91e42c5354282943bc10fae67e930c26d",
         arm64_linux:  "3c4e2921ae347990d7020edf1aac26079c21076d132e74d3a34812b6c1b8b38c",
         x86_64_linux: "dbab88c87cf699ae21606ccc53135359aa8e1f28b703dc884eb39f83a4b22a2e"

  on_macos do
    on_arm do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_macos-arm64_ckpro_#{version}_aarch64.dmg"
    end
    on_intel do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_macos-x64_ckpro_#{version}_x64.dmg"
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
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_linux-arm64_ckpro_#{version}_aarch64.AppImage"

      app_image "ckpro_linux-arm64_ckpro_#{version}_aarch64.AppImage", target: "ckpro.AppImage"
    end
    on_intel do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_linux-x64_ckpro_#{version}_amd64.AppImage"

      app_image "ckpro_linux-x64_ckpro_#{version}_amd64.AppImage", target: "ckpro.AppImage"
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
