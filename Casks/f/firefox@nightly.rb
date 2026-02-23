cask "firefox@nightly" do
  version "149.0a1,2026-02-22-21-34-44"

  language "ca" do
    sha256 "4c69fbf8be193570925e9e4756e024517f89197bc1fe29880d6cac0546dc7ec2"
    "ca"
  end
  language "cs" do
    sha256 "8e69a1554e203dcb63d4e387e08912ef90612dc584cd5463165c80b3ddba3bb6"
    "cs"
  end
  language "de" do
    sha256 "48b2c56d2a6063f2034b05f2ee0e670b1a93c6ca0f979b94aebe68451dd3461b"
    "de"
  end
  language "en-CA" do
    sha256 "84a75261a9944bf5f7f61d9019c4ee9f587563c00ad456253c367c3e3461b1f6"
    "en-CA"
  end
  language "en-GB" do
    sha256 "9e2c9a8307677943c682f59d53ee582dcf14ce34e08d335910a0d6c63f0de34d"
    "en-GB"
  end
  language "en", default: true do
    sha256 "2163f6bd44d47527de5484a19e0681f0b1311c8731e39a37965047d27fc167fb"
    "en-US"
  end
  language "es" do
    sha256 "3a88964a62f32f857680b3988735f2ff03ffbb92ce6b8f172e9685e63e4f9670"
    "es-ES"
  end
  language "fr" do
    sha256 "e37991df5cf5be09cc80def77161809b214b407a559a5d52bcb839d25699f07f"
    "fr"
  end
  language "it" do
    sha256 "2fec97d4d047abde76248e3ab7a2441a1ef8406539b0bde4a689283945c39d67"
    "it"
  end
  language "ja" do
    sha256 "8fce17983dabeef96b3240d0c7ef74afd66296af85dda5071ca2481489133923"
    "ja-JP-mac"
  end
  language "ko" do
    sha256 "00725095e5a4d5799006d7ff435a144feba2f0527f5abd4d8019fe18112af842"
    "ko"
  end
  language "nl" do
    sha256 "a1eac8dd02e711cbb8454bdb0890c392a91392896596621013636b4f74d23c3c"
    "nl"
  end
  language "pt-BR" do
    sha256 "8b66f314662a52440d1647ed726fa96a47d424a4f79c9ca07eafe1bedb465b16"
    "pt-BR"
  end
  language "ru" do
    sha256 "c86e6afe9837918f3beeddec7ed981c393b41f34bcbf5a737e8f4fd6ee6703dd"
    "ru"
  end
  language "uk" do
    sha256 "1d37478ef2234e4a2405e5f473c75669ee8899a6fc2cd243d53bd6b4d1c44122"
    "uk"
  end
  language "zh-TW" do
    sha256 "38098fdfcb64b33cc007f1a4b2031ecb9ff8694ede8353a65d8cfe85f0e27534"
    "zh-TW"
  end
  language "zh" do
    sha256 "2a45d49462791df9725a77a241c81bc69237706ab913a4ec447813c290befc35"
    "zh-CN"
  end

  url "https://ftp.mozilla.org/pub/firefox/nightly/#{version.csv.second.split("-").first}/#{version.csv.second.split("-").second}/#{version.csv.second}-mozilla-central#{"-l10n" if language != "en-US"}/firefox-#{version.csv.first}.#{language}.mac.dmg"
  name "Mozilla Firefox Nightly"
  desc "Web browser"
  homepage "https://www.mozilla.org/firefox/channel/desktop/#nightly"

  livecheck do
    url "https://product-details.mozilla.org/1.0/firefox_versions.json"
    regex(%r{/(\d+(?:[._-]\d+)+)[^/]*/firefox}i)
    strategy :json do |json, regex|
      version = json["FIREFOX_NIGHTLY"]
      next if version.blank?

      content = Homebrew::Livecheck::Strategy.page_content("https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-#{version}.en-US.mac.buildhub.json")
      next if content[:content].blank?

      build_json = Homebrew::Livecheck::Strategy::Json.parse_json(content[:content])
      build = build_json.dig("download", "url")&.[](regex, 1)
      next if build.blank?

      "#{version},#{build}"
    end
  end

  auto_updates true

  app "Firefox Nightly.app"

  zap trash: [
        "/Library/Logs/DiagnosticReports/firefox_*",
        "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/org.mozilla.firefox.sfl*",
        "~/Library/Application Support/CrashReporter/firefox_*",
        "~/Library/Application Support/Firefox",
        "~/Library/Caches/Firefox",
        "~/Library/Caches/Mozilla/updates/Applications/Firefox",
        "~/Library/Caches/org.mozilla.firefox",
        "~/Library/Preferences/org.mozilla.firefox.plist",
        "~/Library/Saved Application State/org.mozilla.firefox.savedState",
        "~/Library/WebKit/org.mozilla.firefox",
      ],
      rmdir: [
        "~/Library/Application Support/Mozilla", #  May also contain non-Firefox data
        "~/Library/Caches/Mozilla",
        "~/Library/Caches/Mozilla/updates",
        "~/Library/Caches/Mozilla/updates/Applications",
      ]
end
