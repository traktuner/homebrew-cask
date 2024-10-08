cask "santa" do
  version "2024.8"
  sha256 "3dbeec114c66c465a756ecbceac0c99dddbe6c907279737612b908dfdf493d8c"

  url "https://github.com/google/santa/releases/download/#{version}/santa-#{version}.dmg"
  name "Santa"
  desc "Binary authorization system"
  homepage "https://github.com/google/santa"

  livecheck do
    url :url
    strategy :github_latest
  end

  pkg "santa-#{version}.pkg"

  uninstall launchctl: [
              "com.google.santa",
              "com.google.santa.bundleservice",
              "com.google.santa.metricservice",
              "com.google.santa.syncservice",
              "com.google.santad",
            ],
            kext:      "com.google.santa-driver",
            pkgutil:   "com.google.santa",
            delete:    [
              "/Applications/Santa.app",
              "/usr/local/bin/santactl",
            ]

  # No zap stanza required

  caveats "For #{token} to use EndpointSecurity, it must be granted Full Disk Access under " \
          "System Preferences → Security & Privacy → Privacy"
end
