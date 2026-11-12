cask "yubi-ki-yay" do
  version "0.1.0"
  sha256 "f97a47085288f028db8d605bc4b717fa4b66201c7104cf277c65f629b017588e"

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
