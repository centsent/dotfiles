export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	tmux
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7dcfff,bg=#1a1b26,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
source $ZSH/oh-my-zsh.sh

[[ -f ~/.alias.zsh ]] && source ~/.alias.zsh
[[ -f ~/.env.zsh ]] && source ~/.env.zsh
