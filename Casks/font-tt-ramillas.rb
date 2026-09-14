require_relative "../cmd/lib/dafont"

cask "font-tt-ramillas" do
  version "20230220"
  sha256 :no_check

  url "https://dl.dafont.com/dl/?f=tt_ramillas"
  name "TT Ramillas"
  desc "Serif font"
  homepage "https://www.dafont.com/tt-ramillas.font"

  livecheck do
    url :homepage
    strategy :dafont
  end

  font "TT Ramillas Initials Trial Black.ttf"
  font "TT Ramillas Initials Trial Bold.ttf"
  font "TT Ramillas Initials Trial ExtraBold.ttf"
  font "TT Ramillas Initials Trial ExtraLight.ttf"
  font "TT Ramillas Initials Trial Light.ttf"
  font "TT Ramillas Initials Trial Medium.ttf"
  font "TT Ramillas Initials Trial Regular.ttf"
  font "TT Ramillas Initials Trial Variable.ttf"
  font "TT Ramillas Trial Black Decor Italic.ttf"
  font "TT Ramillas Trial Black Decor.ttf"
  font "TT Ramillas Trial Black Italic.ttf"
  font "TT Ramillas Trial Black Outline Italic.ttf"
  font "TT Ramillas Trial Black Outline.ttf"
  font "TT Ramillas Trial Black.ttf"
  font "TT Ramillas Trial Bold Italic.ttf"
  font "TT Ramillas Trial Bold.ttf"
  font "TT Ramillas Trial ExtraBold Italic.ttf"
  font "TT Ramillas Trial ExtraBold.ttf"
  font "TT Ramillas Trial ExtraLight Italic.ttf"
  font "TT Ramillas Trial ExtraLight.ttf"
  font "TT Ramillas Trial Italic.ttf"
  font "TT Ramillas Trial Light Italic.ttf"
  font "TT Ramillas Trial Light.ttf"
  font "TT Ramillas Trial Medium Italic.ttf"
  font "TT Ramillas Trial Medium.ttf"
  font "TT Ramillas Trial Regular.ttf"
  font "TT Ramillas Trial Variable Italic.ttf"
  font "TT Ramillas Trial Variable Roman.ttf"

  # No zap stanza required
end
