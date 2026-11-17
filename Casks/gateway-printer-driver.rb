cask "gateway-printer-driver" do
  version "7.119.4.0,21839"
  sha256 "c20a8530a4d2af18d9449c800e41cd022faadc229c27201ebf4600a13e946956"

  url "https://business.toshiba.com/downloads/KB/f1Ulds/#{version.csv.second}/TOSHIBA_ColorMFP.dmg.gz"
  name "Toshiba ColorMFP Drivers"
  desc "Drivers for Toshiba ColorMFP devices"
  homepage "https://business.toshiba.com/support"

  livecheck do
    url "https://business.toshiba.com/support/downloads/GetDownloads.jsp?model=e-STUDIO3515AC"
    strategy :page_match do |page|
      match = page.match(/"TOSHIBA_ColorMFP.dmg.gz",.*?"id":"(\d+)",.*?"versionName":"(\d+(?:\.\d+)+)",/)
      next if match.blank?

      "#{match[2]},#{match[1]}"
    end
  end

  conflicts_with cask: "toshiba-color-mfp"
  depends_on :macos

  pkg "TOSHIBA ColorMFP.pkg"

  # Toshiba ships `*DefaultColorType: Color`, which the printer bills as colour on every page,
  # even black ones. Default new queues and the ones already set up to Auto instead.
  postflight_steps do
    run "/bin/sh",
        args: [
          "-c",
          <<~'SH',
            for f in /Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP*.gz; do
              gzip -dc "$f" | sed 's/^\*DefaultColorType: Color/*DefaultColorType: Auto/' | gzip -9 > "$f.tmp" &&
                cat "$f.tmp" > "$f"
              rm -f "$f.tmp"
            done
            for q in $(lpstat -v 2>/dev/null | sed -n 's/^device for \([^:]*\):.*/\1/p'); do
              grep -q '^\*NickName: "TOSHIBA ColorMFP' "/etc/cups/ppd/$q.ppd" 2>/dev/null &&
                lpadmin -p "$q" -o ColorType=Auto
            done
            true
          SH
        ],
        sudo: true
  end

  uninstall pkgutil: "com.toshiba.pde.x7.colormfp",
            delete:  [
              "/Library/Printers/PPDs/Contents/Resources/TOSHIBA_ColorMFP*.gz",
              "/Library/Printers/toshiba",
            ]
end
