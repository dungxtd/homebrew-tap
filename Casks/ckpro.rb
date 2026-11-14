# Written by ckpro's own release workflow (dungxtd/ckpro), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on ckpro's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "ckpro" do
  version "0.3.0"
  sha256 arm:          "4685fb5dbf479ce8686ef3a7f37b0a3206d28c19685de130673cb08938ab7f16",
         intel:        "0a16a3578c33f2d76e4b3e4391088871791f1c3beb62ebcd61f93294901ea8a1",
         arm64_linux:  "9775a6eda651fd37e56d4c067735d7a6132d714de1b030131f0ce77d78f5f469",
         x86_64_linux: "3a2791be6fd4a86da029bb32dad692bda6176a4d270afd0526aa3acb1b7da91c"

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
