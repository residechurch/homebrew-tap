cask "gateway-brewfile-base" do
  version :latest
  sha256 :no_check

  url "https://github.com/residechurch/dotfiles.git",
      branch: "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/residechurch/dotfiles"

  conflicts_with cask: [
    "residechurch/tap/gateway-brewfile-kiosk",
    "residechurch/tap/gateway-brewfile-production",
  ]
  depends_on :macos

  artifact ".Brewfile-base", target: "~/.Brewfile"

  preflight_steps do
    if_path_exists ".Brewfile", base: :home do
      move ".Brewfile", ".Brewfile.backup", source_base: :home, target_base: :home
    end
  end
end
