cask "brother-printer-setting-tool" do
  on_ventura :or_older do
    version "1.3.5,100946,12,135"
    sha256 "2e7134065e6b7b920b0c58aee253c2a0e9ee1acbd9cdc1e5dc471b35ee663e8e"

    url "https://download.brother.com/welcome/dlfp#{version.csv.second}/pstm#{version.csv.fourth}x#{version.csv.third}all.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_sonoma :or_newer do
    version "1.3.6,101471"
    sha256 "6e84b16e7a8dbe34550837750b2baf9499479682fcb7b5cd2121743f6afa25b8"

    url "https://download.brother.com/welcome/dlfp#{version.csv.second}/BrotherPrinterSettingTool_#{version.csv.first}.dmg"

    livecheck do
      url "https://support.brother.com/g/b/downloadlist.aspx?c=au&lang=en&prod=lpql810weas&os=10081&type3=468"
      strategy :page_match do |page|
        download_path = page[/href=["']?([^"' >]*?)["']?>Printer Setting Tool</i, 1]
        next if download_path.blank?

        download_page = Homebrew::Livecheck::Strategy.page_content(
          URI.join("https://support.brother.com/", download_path.sub("downloadend.aspx", "downloadhowto.aspx")).to_s,
        )
        match = download_page[:content]&.match(%r{/dlfp(\d+)/BrotherPrinterSettingTool[._-]v?(\d+(?:\.\d+)+)\.dmg}i)
        next if match.blank?

        "#{match[2]},#{match[1]}"
      end
    end
  end

  name "Brother Label Printer Drivers"
  desc "Software for Brother label printers"
  homepage "https://support.brother.com/"

  depends_on :macos

  pkg "BrotherPrinterSettingTool.pkg"

  uninstall pkgutil: "com.Brother.Brotherdriver.BrotherPrinterSettingTool"
end
