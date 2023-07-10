#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

brew tap mykolaharmash/git-jump
brew install thefuck fzf micro romkatv/powerlevel10k/powerlevel10k git-jump

# Add Git aliases
cat << 'GIT_ALIAS' > $ZSH/aliases/git.sh
[alias]
	l = "!git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
	# Displays a colorful and decorated graph of commit history with abbreviated commit hashes, relative dates, commit messages, authors, and branch names.

	s = status
	# Shortcut for "git status" - shows the working tree status.

	p = !git push origin $(git rev-parse --abbrev-ref HEAD)
	# Pushes the current branch to the remote repository specified as "origin".

	c = !git add -A && git commit
	# Stages all changes and opens the default editor for creating a new commit.

	cm = "!git c -m "
	# Shortcut for "git commit -m" - stages all changes and opens the default editor for creating a new commit with a provided message.

	ca = commit --amend
	# Amends the previous commit by combining staged changes with the previous commit.

	ch = checkout
	# Shortcut for "git checkout" - switches branches or restores files.

	cb = checkout -b
	# Shortcut for "git checkout -b" - creates a new branch and switches to it.

	wip = !git add -u && git commit --no-verify -m "WIP"
	# Stages and commits all tracked changes without running pre-commit hooks, creating a work-in-progress commit.

	wipe = !git add -A && git commit -qm 'WIPE SAVEPOINT' && git reset HEAD~1 --hard
	# Stages and commits all changes with a commit message of 'WIPE SAVEPOINT', and then resets the repository to the previous commit, effectively discarding the last commit.

	pls = pull origin staging
	# Shortcut for "git pull origin staging" - fetches changes from the remote "origin" repository and merges them into the current branch "staging".

	plm = pull origin master
	# Shortcut for "git pull origin master" - fetches changes from the remote "origin" repository and merges them into the current branch "master".

	plo = pull origin
	# Shortcut for "git pull origin" - fetches changes from the remote "origin" repository and merges them into the current branch.

	back = !sh -c 'git checkout @{-$0}'
	# Switches to the branch that was checked out before the current branch, specified by the given index (e.g., "back 1" switches to the previous branch).

	rb = !sh -c 'git branch -m $@'
	# Renames the current branch with the provided name.

	db = !sh -c 'branch -D $0'
	# Deletes the specified branch.

	j = !git jump
	# Shortcut for a custom "git jump" command.

	la = "!git config -l | grep alias | cut -c 7-"
	# Lists all Git aliases configured in the gitconfig file.

EOF

# Update .zshrc
cat > ~/.zshrc
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export MANPATH="/usr/local/man:$MANPATH"
export EDITOR="micro"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled # disable automatic updates
# zstyle ':omz:update' mode auto   # update automatically without asking
# zstyle ':omz:update' mode reminder # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	aliases
	gitfast
	zsh-autosuggestions
	zsh-syntax-highlighting
	thefuck
	fzf
	jump
	zsh-interactive-cd
	dirhistory
	gradle-completion
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias g="git "

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U compinit; compinit

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh
source ~/dotfiles/fix_zsh_keys.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ZSHRC
EOF