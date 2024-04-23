{pkgs, ...}:
{
  home.file.".zshrc".source = ./config/.zshrc;
  home.packages = with pkgs; [ fortune lolcat cowsay ];
}
