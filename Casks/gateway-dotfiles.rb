cask "gateway-dotfiles" do
  version :latest
  sha256 :no_check

  url "https://github.com/residechurch/dotfiles.git",
      branch: "main"
  name "Gateway Dotfiles"
  desc "Dotfiles for Gateway Media"
  homepage "https://github.com/residechurch/dotfiles"

  depends_on :macos

  artifact ".hyper.js", target: "~/.hyper.js"
  artifact ".zshrc", target: "~/.zshrc"
  artifact ".stats.json", target: "~/.stats.json"
  artifact "config.sh", target: "~/.scripts/config.sh"

  preflight_steps do
    unless_path_exists ".oh-my-zsh/lib", base: :home do
      run "/bin/sh",
          args:           ["-c", "sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""],
          env:            { "CHSH" => "no", "HOME" => "/Users/{{user}}", "KEEP_ZSHRC" => "yes", "RUNZSH" => "no" },
          writable_paths: [".oh-my-zsh", ".zshrc"],
          writable_base:  :home,
          network_access: true
    end
    if_path_exists ".zshrc", base: :home do
      move ".zshrc", ".zshrc.backup", source_base: :home, target_base: :home
    end
    if_path_exists ".hyper.js", base: :home do
      move ".hyper.js", ".hyper.js.backup", source_base: :home, target_base: :home
    end
  end

  postflight_steps do
    run "/usr/bin/defaults", args: ["import", "eu.exelban.Stats", "{{staged_path}}/.stats.json"]
  end

  # No zap stanza required
end
