cask "brother-printer-setting-tool" do
  on_big_sur :or_older do
    version "1.3.5,100946,12,135,10064"
    sha256 "2e7134065e6b7b920b0c58aee253c2a0e9ee1acbd9cdc1e5dc471b35ee663e8e"
  end
  on_monterey do
    version "1.3.5,100946,12,135,10078"
    sha256 "2e7134065e6b7b920b0c58aee253c2a0e9ee1acbd9cdc1e5dc471b35ee663e8e"
  end
  on_ventura do
    version "1.3.5,100946,12,135,10071"
    sha256 "2e7134065e6b7b920b0c58aee253c2a0e9ee1acbd9cdc1e5dc471b35ee663e8e"
  end
  on_sonoma :or_newer do
    version "1.3.5,100946,12,135,10081"
    sha256 "2e7134065e6b7b920b0c58aee253c2a0e9ee1acbd9cdc1e5dc471b35ee663e8e"
  end

  url "https://download.brother.com/welcome/dlfp#{version.csv.second}/pstm#{version.csv.fourth}x#{version.csv.third}all.dmg"
  name "Brother Label Printer Drivers"
  desc "Software for Brother label printers"
  homepage "https://support.brother.com/"

  livecheck do
    url "https://support.brother.com/g/b/downloadlist.aspx?c=au&lang=en&prod=lpql810weas&os=#{version.csv.fifth}&type3=468"
    strategy :page_match do |page|
      download_match = page.match(/href=["']?([^"' >]*?)["']?>Printer Setting Tool</i)
      next if download_match.blank?

      version_match = download_match.post_match.match(/\((\d+(?:\.\d+)+a?)\)/)
      next if version_match.blank?

      download_page = Homebrew::Livecheck::Strategy.page_content(
        URI.join("https://support.brother.com/",
                 download_match[1].sub("downloadend.aspx", "downloadhowto.aspx")).to_s,
      )
      next if download_page[:content].blank?

      dlfp_match = download_page[:content].match(%r{href=.*?/dlfp([\d_]+)/pstm([^x]+)x([^a]+)all\.dmg}i)
      next if dlfp_match.blank?

      "#{version_match[1]},#{dlfp_match[1]},#{dlfp_match[3]},#{dlfp_match[2]},#{version.csv.fifth}"
    end
  end

  depends_on :macos

  pkg "BrotherPrinterSettingTool.pkg"

  uninstall pkgutil: "com.Brother.Brotherdriver.BrotherPrinterSettingTool"
end
