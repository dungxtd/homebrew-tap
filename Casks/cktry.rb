# Written by cktry's own release workflow (dungxtd/cktry), not this tap's
# publish-release: it rewrites `version` and the four `sha256` values (by
# their keys) after each release, and the installers stay on cktry's
# releases (macOS DMGs and Linux AppImages); keep this structure.
cask "cktry" do
  version "0.2.0"
  sha256 arm:          "2d4e55d1eb6b0cb65b0c01b459ae0d85a259cffb93f21eb0e9a1fefadef1010a",
         intel:        "33d430fcfc5b6b35a874f3a815f0576a9ef55284f9691b4bfd164d1620b18061",
         arm64_linux:  "d49729185fa667aeb83012d899dcda72ce2e63bdf9168eb674223778825673db",
         x86_64_linux: "28115f3b7755eff1c6fa2ad40741279bf775a642660a7f7be0c90743fecf58d3"

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
