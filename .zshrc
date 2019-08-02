# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
t() {
	if [[ -e .tmux ]]; then
		./.tmux
	else
		sessionName=`basename "$PWD"`
		if tmux has-session -t "$sessionName"; then
			echo Attached Existing Session
			tmux attach -t "$sessionName"
		else
			tmux new -A -s "$sessionName"
		fi
	fi
}

# Nodejs
VERSION=v10.16.0
DISTRO=linux-x64
export PATH=/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/bhorng/.oh-my-zsh"

ZSH_THEME="minimal"

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Alias
alias vim="nvim"
alias ll="ls -al"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	npm
	yarn
	pip
	thefuck
)

source $ZSH/oh-my-zsh.sh
source $HOME/.profile

# User configuration

# Unbind C-I
# bindkey -r "^I"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### Added by Zplugin's installer
source '/home/bhorng/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS
### End of Zplugin's installer chunk
