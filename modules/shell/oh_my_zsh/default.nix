{pkgs, ...}:
{
  programs.zsh = {
  enable = true;
  ohMyZsh = {
    enable = true;
    plugins = ["git" "man"];
    theme = "robbyrussell";
    };
  };
}
