# Written by ckpro's own release workflow (dungxtd/ckpro), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on ckpro's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "ckpro" do
  version "0.3.1"
  sha256 arm:          "821447f40512e918c6a8394bc454b1409fc75cefe648843120905559b879eba0",
         intel:        "6e6bd6ac7a97f21625cc7deec6ae612625daac5f7dbbb1c7de0c41881e2a0465",
         arm64_linux:  "61c2bb41de2f2485469f51d9b0d523d82547a5f43d805de1f5624ed0b9fe0e1b",
         x86_64_linux: "1a9328e63777aefeecaedd357a04ba33952c4fe8c3714c2cc8a9eb8d3d510f55"

  on_macos do
    on_arm do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_macos-arm64_ckpro_#{version}_aarch64.dmg"
    end
    on_intel do
      url "https://github.com/dungxtd/ckpro/releases/download/v#{version}/ckpro_macos-x64_ckpro_#{version}_x64.dmg"
    end


    app "ckpro.app"

    # Ad-hoc signed (no Developer ID or notarization yet): Gatekeeper would
    # refuse it as damaged on first open, so the quarantine flag goes on install
    postflight_steps do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/ckpro.app"]
    end

    # The app's database, kubeconfigs and logs; its Docker containers stay
    # (remove them with `docker compose -p ckpro down`)
    zap trash: [
      "~/Library/Application Support/dev.ckpro.app",
      "~/Library/Caches/dev.ckpro.app",
      "~/Library/Logs/dev.ckpro.app",
      "~/Library/Preferences/dev.ckpro.app.plist",
      "~/Library/WebKit/dev.ckpro.app",
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

    # The app's database, kubeconfigs and logs; its Docker containers stay
    zap trash: [
      "~/.cache/dev.ckpro.app",
      "~/.config/dev.ckpro.app",
      "~/.local/share/dev.ckpro.app",
    ]
  end

  name "ckpro"
  desc "Practice the CKA, CKAD and CKS exams on local Kubernetes clusters"
  homepage "https://github.com/dungxtd/ckpro"
end
