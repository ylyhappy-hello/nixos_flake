export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"


# fcitx5 如果是中文输入法执行这个函数就会切换到英文输入法，给vim用
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
alias ne="nix-instantiate --eval"

function rv(){
	if [ ! -d $HOME/.local/.trash ]; then
		mkdir -p $HOME/.local/.trash
	fi
	mv $@ $HOME/.local/.trash
}
# neofetch --yoffset -600 --xoffset -28 --size 260px
fortune | cowsay -f sheep | lolcat

