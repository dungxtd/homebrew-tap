# Written by cktry's own release workflow (dungxtd/cktry), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on cktry's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "cktry" do
  version "0.2.0"
  sha256 arm:          "c895faddb464e469f760d50a12111778024b4652515243b44484940bb2559a13",
         intel:        "338422712cc6cdddcf0ab751561120fdaeedc19f778140346c600d8ec2751d22",
         arm64_linux:  "3156fa809d4bfb7946ca4826df4151145e60b3454d1438fa2e5d236f9752cb67",
         x86_64_linux: "c4a7ac85aecd1c64322201380d64805dae4cb02246747083cb4c91dfdccdcaef"

  on_macos do
    on_arm do
      url "https://github.com/dungxtd/cktry/releases/download/v#{version}/cktry_macos-arm64_CKtry_#{version}_aarch64.dmg"
    end
    on_intel do
      url "https://github.com/dungxtd/cktry/releases/download/v#{version}/cktry_macos-x64_CKtry_#{version}_x64.dmg"
    end


    app "CKtry.app"

    # Ad-hoc signed (no Developer ID or notarization yet): Gatekeeper would
    # refuse it as damaged on first open, so the quarantine flag goes on install
    postflight_steps do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/CKtry.app"]
    end

    # The app's database, kubeconfigs and logs; its Docker containers stay
    # (remove them with `docker compose -p cktry down`)
    zap trash: [
      "~/Library/Application Support/dev.cktry.app",
      "~/Library/Caches/dev.cktry.app",
      "~/Library/Logs/dev.cktry.app",
      "~/Library/Preferences/dev.cktry.app.plist",
      "~/Library/WebKit/dev.cktry.app",
    ]
  end
  on_linux do
    on_arm do
      url "https://github.com/dungxtd/cktry/releases/download/v#{version}/cktry_linux-arm64_CKtry_#{version}_aarch64.AppImage"

      app_image "cktry_linux-arm64_CKtry_#{version}_aarch64.AppImage", target: "CKtry.AppImage"
    end
    on_intel do
      url "https://github.com/dungxtd/cktry/releases/download/v#{version}/cktry_linux-x64_CKtry_#{version}_amd64.AppImage"

      app_image "cktry_linux-x64_CKtry_#{version}_amd64.AppImage", target: "CKtry.AppImage"
    end

    # The app's database, kubeconfigs and logs; its Docker containers stay
    zap trash: [
      "~/.cache/dev.cktry.app",
      "~/.config/dev.cktry.app",
      "~/.local/share/dev.cktry.app",
    ]
  end

  name "CKtry"
  desc "Practice the CKA, CKAD and CKS exams on local Kubernetes clusters"
  homepage "https://github.com/dungxtd/cktry"
end
