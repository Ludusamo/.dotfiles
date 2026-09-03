export PATH=$PATH:~/.vimpkg/bin
export PATH=$PATH:/usr/bin

export GOPATH=$HOME/dev/go
export GOBIN=$HOME/dev/go/bin
export PATH=$PATH:$(go env GOPATH)/bin

 #~/.bashrc: executed by bash(1) for non-login shells.
 # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
 # for examples
 # We use preexec and precmd hook functions for Bash
 # If you have anything that's using the Debug Trap or PROMPT_COMMAND
 # change it to use preexec or precmd
 # See also https://github.com/rcaloras/bash-preexec


 source ~/.git-completion.bash


 t() {
	 if [[ -e .tmux ]]; then
		 ./.tmux
	 else
		 sessionName=`basename "$PWD"`
		 if tmux has-session -t "$sessionName"; then
			 echo Attached Existing Session
			 tmux attach -t "$sessionName"
		 else
			 tmux new -s "$sessionName"
		 fi
	 fi
 }

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='λ>\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
	PS1='λ>\W\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# If this is an xterm set more declarative titles
# "dir: last_cmd" and "actual_cmd" during execution
# If you want to exclude a cmd from being printed see line 156
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\$(print_title)\a\]$PS1"
		__el_LAST_EXECUTED_COMMAND=""
		print_title ()
		{
			__el_FIRSTPART=""
			__el_SECONDPART=""
			if [ "$PWD" == "/" ]; then
				__el_FIRSTPART="/"
			else
				__el_FIRSTPART="${PWD##*/}"
			fi
			if [[ "$__el_LAST_EXECUTED_COMMAND" == "" ]]; then
				echo "$__el_FIRSTPART"
				return
			fi
			#trim the command to the first segment and strip sudo
			if [[ "$__el_LAST_EXECUTED_COMMAND" == sudo* ]]; then
				__el_SECONDPART="${__el_LAST_EXECUTED_COMMAND:5}"
				__el_SECONDPART="${__el_SECONDPART%% *}"
			else
				__el_SECONDPART="${__el_LAST_EXECUTED_COMMAND%% *}"
			fi
			printf "%s: %s" "$__el_FIRSTPART" "$__el_SECONDPART"
		}
		put_title()
		{
			__el_LAST_EXECUTED_COMMAND="${BASH_COMMAND}"
			printf "\033]0;%s\007" "$1"
		}

		# Show the currently running command in the terminal title:
		# http://www.davidpashley.com/articles/xterm-titles-with-bash.html
		update_tab_command()
		{
			# catch blacklisted commands and nested escapes
			case "$BASH_COMMAND" in
				*\033]0*|update_*|echo*|printf*|clear*|cd*)
					__el_LAST_EXECUTED_COMMAND=""
					;;
				*)
					put_title "${BASH_COMMAND}"
					;;
			esac
		}
		preexec_functions+=(update_tab_command)
		;;
	*)
		;;
esac

cat ~/.cache/wal/sequences
clear

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source ~/.profile-user
export PATH="$HOME/.local/bin:$PATH"

git-clean-branches() {
	# Ensure inside a git repository
	if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		echo "Error: Not a git repository."
		return 1
	fi

	# Fetch and prune deleted tracking branches
	echo "Fetching and pruning tracking branches..."
	git fetch --prune >/dev/null 2>&1

	local current_branch protected_branches branch_list
	current_branch=$(git rev-parse --abbrev-ref HEAD)

	# Regex pattern of protected branches (add or remove branches here as needed)
	protected_branches="^(main|master|dev|development|${current_branch})$"

	# Gather unique branch names (local and remote), stripping origin/ prefixes
	branch_list=$(
		{
			git branch --format="%(refname:short)"
			git branch -r --format="%(refname:short)" | sed 's|^origin/||' | grep -v '^HEAD$'
		} | sort -u | grep -E -v "${protected_branches}"
	)

	if [ -z "$branch_list" ]; then
		echo "No candidate branches found for deletion."
		return 0
	fi

	echo -e "\n--- Starting Interactive Branch Cleanup ---\n"

	for branch in $branch_list; do
		local has_local=false
		local has_remote=false

		if git show-ref --verify --quiet "refs/heads/$branch"; then
			has_local=true
		fi
		if git show-ref --verify --quiet "refs/remotes/origin/$branch"; then
			has_remote=true
		fi

		echo "----------------------------------------"
		echo "Branch: $branch"
		echo "Status: [Local: $has_local] | [Remote (origin): $has_remote]"
		echo "----------------------------------------"

		# Local Deletion Prompt
		if [ "$has_local" = true ]; then
			read -p "Delete LOCAL branch '$branch'? (y/N): " choice
			case "$choice" in
				[yY][eE][sS]|[yY])
					# Tries soft delete first; falls back to force delete if unmerged
					if ! git branch -d "$branch" 2>/dev/null; then
						read -p "  Branch contains unmerged changes. Force delete local '$branch'? (y/N): " force_choice
						case "$force_choice" in
							[yY][eE][sS]|[yY])
								git branch -D "$branch"
								;;
							*)
								echo "  Skipped local force delete."
								;;
						esac
					fi
					;;
				*)
					echo "  Skipped local delete."
					;;
			esac
		fi

		# Remote Deletion Prompt
		if [ "$has_remote" = true ]; then
			read -p "Delete REMOTE branch 'origin/$branch'? (y/N): " choice
			case "$choice" in
				[yY][eE][sS]|[yY])
					git push origin --delete "$branch"
					;;
				*)
					echo "  Skipped remote delete."
					;;
			esac
		fi
		echo ""
	done

	echo "Cleanup complete."
}
