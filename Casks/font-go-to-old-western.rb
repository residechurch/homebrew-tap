require_relative "../cmd/lib/dafont"

cask "font-go-to-old-western" do
  version "20250224"
  sha256 :no_check

  url "https://dl.dafont.com/dl/?f=go_2_old_western"
  name "Go 2 Old Western"
  desc "Western font for Gateway Kids"
  homepage "https://www.dafont.com/go-2-old-western.font"

  livecheck do
    url :homepage
    strategy :dafont
  end

  font "Go2OldWestern-Italic.ttf"
  font "Go2OldWestern-Regular.ttf"

  # No zap stanza required
end
