# Written by cktry's own release workflow (dungxtd/cktry), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on cktry's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "cktry" do
  version "0.2.1"
  sha256 arm:          "d4a8e8161a7c62d17dcb0996a4cb11de70168f8092405c20eba9ef8c296dd99e",
         intel:        "db15c8c6e67dd8efbe36001306133e4d3099a52d55865eb98b5e48eb1298d539",
         arm64_linux:  "cc29f10b4873c04907b67e1c912776e8b4bb152058ae7aef30e28b0a245e2a76",
         x86_64_linux: "518082c64cada7ac55dc5cd88b5781d1c7edc3c75979b319e8fc7d368fef1f80"

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
