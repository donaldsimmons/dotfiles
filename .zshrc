# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
homebrew=/usr/local/bin:/usr/local/sbin
export PATH=$homebrew:$PATH:/usr/local/heroku/bin:/Users/treysimmons/.rbenv/shims:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin
export PATH=/usr/local/shar/npm/bin:$PATH


#====================================
#	 ALIASES
#====================================
alias ll="ls -lah"

alias ..="cd .."
alias ...="cd ../.."

alias trey="cd ~"
alias hpb="cd ~/Code/hpb"
alias skyo="cd ~/Code/rentwb"
alias sayish="cd ~/Code/sayish"

alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias tmux.conf="vim ~/.tmux.conf"

alias sz="source ~/.zshrc"

alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"

# --- Displays the free space on disk in Gigabytes
alias df="df -h"

#===================
#	 Tmux Aliases
#===================
alias ta="tmux attach -t"
alias td="tmux detach"
alias tk="tmux kill-session -t"
alias tl="tmux list-sessions"
alias tn="tmux new -s"
alias ts="tmux switch -t"

#===================
#	 Git Aliases
#===================
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gbd="git branch -D"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gd="git diff"
alias gdc="git diff --cached"
alias gf="git fetch"
alias gl="git log"
alias gsh="git stash"
alias gsha="git stash apply"
alias gst="git status"
alias g-b="git checkout -b"
alias g--="git checkout --"

#===================
#  Rails Aliases
#===================
alias ras="rails server"
alias rc="rails console"
alias brc="./bin/rails console"

alias migrate="rake db:migrate db:test:prepare"

#===================
# Zeus Aliases
#===================
alias zc="zeus console"
alias zdbc="zeus dbconsole"
alias zd="zeus destroy"
alias zg="zeus generate"
alias zra="zeus rake"
alias zru="zeus runner"
alias zs="zeus server"
alias zstart="zeus start"
alias zt="zeus test"

#===================
# HPB Aliases
#===================
alias fs="foreman start"

alias ssh_staging="ssh trey@10.200.0.1"
alias ssh_qa="ssh trey@10.200.0.4"

#===================
# Postgres Aliases
#===================
alias pg_start="pg_ctl -D /usr/local/var/postgres start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop"

#===================
# MySQL Aliases
#===================
mysqldb() {
  mysql -u "$1" -p "$2"
}


eval "$(rbenv init -)"

TERM=screen-256color
