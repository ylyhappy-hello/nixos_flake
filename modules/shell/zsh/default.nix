{pkgs, ...}:
{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      defaultKeymap = "vicmd";
      plugins = [
        # name = "zsh-autosuggestions";
        # src = pkgs.fetchFromGitHub {
        #   owner = "zsh-users";
        #   repo = "zsh-autosuggestions";
        #   rev = "v0.4.0";
        #   sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        # };
      ];
    };
  };
  home.packages = with pkgs; [ cowsay fortune lolcat ];
  home.file.".zshrc".text = ''
    function im_change(){
      im=$(fcitx5-remote)
      if [ $im -eq 2 ]; then
        fcitx5-remote -c
      fi
    }

    function date_str(){
      echo "\"`date "+%Y-%m-%d %H:%M:%S"`\""
    }

    alias gcmsgct="gcmsg `date_str`"
	function rv(){
		if [ ! -d $HOME/.local/.trash ]; then
			mkdir -p $HOME/.local/.trash
		fi
		mv $@ $HOME/.local/.trash
	}
	alias neofetch="neofetch --xoffset -28 --size 260px"
	fortune | cowsay -f sheep | lolcat
  '';
}
