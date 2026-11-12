cask "yubi-ki-yay" do
  version "0.1.1"
  sha256 "582d1b8920fe9aefd5f5ff6e586d32e9f277cc21f12950a8f4b92109b1c11213"

  url "https://github.com/TheWolfNL/yubi-ki-yay/releases/download/v#{version}/Yubi-Ki-Yay-#{version}-universal.zip"
  name "Yubi Ki-Yay"
  desc "Menu bar app that alerts when a YubiKey is waiting for a touch"
  homepage "https://github.com/TheWolfNL/yubi-ki-yay"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Yubi Ki-Yay.app"
  binary "#{appdir}/Yubi Ki-Yay.app/Contents/MacOS/yubi-ki-yay", target: "yubikiyay"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Yubi Ki-Yay.app"]
  end

  uninstall launchctl: "com.github.thewolfnl.yubikiyay",
            quit:      "com.github.thewolfnl.yubikiyay"

  zap trash: [
    "~/.config/yubi-ki-yay",
    "~/Library/Application Support/yubi-ki-yay",
  ]
end
