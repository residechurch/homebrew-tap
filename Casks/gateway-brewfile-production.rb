cask "gateway-brewfile-production" do
  version :latest
  sha256 :no_check

  url "https://github.com/residechurch/dotfiles.git",
      branch: "main"
  name "Gateway Production Brewfile"
  homepage "https://github.com/residechurch/dotfiles"

  conflicts_with cask: [
    "residechurch/tap/gateway-brewfile-base",
    "residechurch/tap/gateway-brewfile-kiosk",
  ]
  depends_on :macos

  artifact ".Brewfile-base", target: "~/.Brewfile-base"
  artifact ".Brewfile-production", target: "~/.Brewfile"

  preflight_steps do
    if_path_exists ".Brewfile", base: :home do
      move ".Brewfile", ".Brewfile.backup", source_base: :home, target_base: :home
    end
    if_path_exists ".Brewfile-base", base: :home do
      move ".Brewfile-base", ".Brewfile-base.backup", source_base: :home, target_base: :home
    end
  end
end
