cask "now-tv-player" do
  version "8.15.0"
  sha256 :no_check

  url "https://web.static.nowtv.com/watch/player/nowtv/gb/latest/NOWTVPlayer-Mac.dmg"
  name "NOW TV Player"
  desc "Video streaming service player"
  homepage "https://www.nowtv.com/"

  livecheck do
    url "https://web.static.nowtv.com/watch/player/nowtv/gb/latest/update.json"
    strategy :json do |json|
      json.dig("platforms", "darwin", "version")
    end
  end

  app "NOW TV Player.app"

  zap trash: [
    "~/Library/Application Support/NOW TV Player",
    "~/Library/Logs/NOW TV Player",
    "~/Library/Preferences/com.electron.now-tv-player.helper.plist",
    "~/Library/Preferences/com.electron.now-tv-player.plist",
    "~/Library/Saved Application State/com.electron.now-tv-player.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
