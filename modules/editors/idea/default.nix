{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [ jetbrains-goland-ultimate-d jetbrains-idea-ultimate-d ];
  # environment.systemPackages = with pkgs; [ jetbrains.idea-ultimate ];
}
