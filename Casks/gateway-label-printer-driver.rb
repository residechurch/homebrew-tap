cask "gateway-label-printer-driver" do
  on_big_sur :or_older do
    version "4.0.4a,100782,14,800m404a,10064"
    sha256 "fe23ddbc3ce6e48129efe480d5688b8068f793867562f89af0fab90292752679"
  end
  on_monterey do
    version "4.0.4a,100782,14,800m404a,10078"
    sha256 "fe23ddbc3ce6e48129efe480d5688b8068f793867562f89af0fab90292752679"
  end
  on_ventura do
    version "4.0.4a,100782,14,800m404a,10071"
    sha256 "fe23ddbc3ce6e48129efe480d5688b8068f793867562f89af0fab90292752679"
  end
  on_sonoma :or_newer do
    version "4.0.4a,100782,14,800m404a,10081"
    sha256 "fe23ddbc3ce6e48129efe480d5688b8068f793867562f89af0fab90292752679"
  end

  url "https://download.brother.com/welcome/dlfp#{version.csv.second}/qd#{version.csv.fourth}x#{version.csv.third}all.dmg"
  name "Brother Label Printer Drivers"
  desc "Software for Brother label printers"
  homepage "https://support.brother.com/"

  livecheck do
    url "https://support.brother.com/g/b/downloadlist.aspx?c=au&lang=en&prod=lpql810weas&os=#{version.csv.fifth}"
    strategy :page_match do |page|
      download_match = page.match(/href=["']?([^"' >]*?)["']?>Printer Driver</i)
      next if download_match.blank?

      version_match = download_match.post_match.match(/\((\d+(?:\.\d+)+a?)\)/)
      next if version_match.blank?

      download_page = Homebrew::Livecheck::Strategy.page_content(
        URI.join("https://support.brother.com/",
                 download_match[1].sub("downloadend.aspx", "downloadhowto.aspx")).to_s,
      )
      next if download_page[:content].blank?

      dlfp_match = download_page[:content].match(%r{href=.*?/dlfp(\d+)/qd([^x]+)x(\d+)all\.dmg}i)
      next if dlfp_match.blank?

      "#{version_match[1]},#{dlfp_match[1]},#{dlfp_match[3]},#{dlfp_match[2]},#{version.csv.fifth}"
    end
  end

  depends_on :macos

  pkg "Brother_Printer_Drivers.pkg"

  uninstall pkgutil: "com.brother.brotherdriver.BrotherQL*"
end
