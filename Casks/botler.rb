cask "botler" do
  version "0.1.0"
  sha256 "798bd5701e181aefeb6a79b5e573a50f487d54904243468b757c17d70c638e1a"

  url "https://github.com/TheWolfNL/botler/releases/download/v#{version}/Botler-#{version}-universal.zip"
  name "Botler"
  desc "Menu bar butler that alerts when an AI coding agent is done or needs input"
  homepage "https://github.com/TheWolfNL/botler"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Botler.app"
  binary "#{appdir}/Botler.app/Contents/MacOS/botler", target: "botler"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Botler.app"]
  end

  uninstall launchctl: "com.github.thewolfnl.botler",
            quit:      "com.github.thewolfnl.botler"

  zap trash: [
    "~/.config/botler",
    "~/Library/Application Support/botler",
  ]

  caveats <<~EOS
    Open Botler once: it offers to connect to Claude Code by adding its hooks.
    Or run:
      botler hooks install

    The hooks do nothing once the app is removed. To take them out of
    Claude Code's settings, run this before uninstalling:
      botler hooks uninstall
  EOS
end
