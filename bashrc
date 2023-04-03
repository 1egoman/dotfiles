# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
            "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# colorize commands
if [[ $(uname) == *"Linux"* ]]; then
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls'
  alias dir='dir'
  alias vdir='vdir'
  alias grep='grep'
  alias fgrep='fgrep'
  alias egrep='egrep'
fi

# vim alias
# use nvim if at all possible
#if [[ -n $(which nvim) ]]; then
  #alias vi="nvim"
#else
alias vi="vim"
#fi

# go back to workspace
alias ww="cd ~/w"

# stupid hack, but basically makes sure tmux is in 256 color mode
alias tmux="tmux -2"

# git aliases
alias g="git"
alias f="git flow"

alias a="git add"
alias au="git add -u && git status"
alias aa="git add . && git status"
alias rmv="(git status > /dev/null 2>&1) && git rm || rm"

alias cv="git commit -v"
alias cm="git commit -m"
alias am="git commit --amend --reuse-message=HEAD"
alias amend="am"

alias sb="git submodule"

alias s="(git status > /dev/null 2>&1) && git status || ls -Al"
alias ss="git status -s"
alias l="git log --graph --all --pretty=format:'%C(yellow)%h%C(red)%d%Creset %s %C(green)- %an, %ar%Creset'"
alias ll="git log --stat --abbrev-commit"
alias lb="git log -p -M --follow --stat --"

alias b="git branch -vv"
alias c="git checkout"
alias master="git checkout master"

alias re="git reset"
alias rh="git reset HEAD"

alias gd="git diff"
alias gds="git diff --staged"

alias r="remote"
alias rv="git remote -v"
alias ra="git remote add"
alias rr="git remote rm"

# hub stuff
alias clone="gh repo clone"
alias repo="gh repo view"

# other aliases
alias v="vagrant"
alias vup="vagrant up && vagrant ssh"
alias vhalt="vagrant halt"
alias vsusp="vagrant suspend"
alias vs="vagrant status"
alias vrestart="vagrant halt && vagrant up && vagrant ssh"

# clipboard aliases
[ -z $(which pbcopy) ] && alias pbcopy="xsel -b -i"
[ -z $(which pbpaste) ] && alias pbpaste="xsel -b -o"

# make :q work like in vim
alias :q="exit"
alias :Q="exit"
alias ,sb="source ~/.bashrc"

# turn caps lock into another control.
[[ -n $(which setxkbmap) ]] && [[ `uname -s` == "Linux" ]]&& setxkbmap -option ctrl:nocaps

# ssh shortcuts
alias sshcloud="ssh ubuntu@cloud.lono.io"
alias sshc="sshcloud"

alias sshdrop="ssh ryan@apps.rgaus.net"
alias sshd="sshdrop"

alias sshnas="ssh ryan@cname.rgaus.net -p 8022"
alias sshn="sshnas"

# open a file/folder with o
if [[ -n $(which xdg-open) ]]; then
  alias o="xdg-open"
else
  alias o="open"
fi
alias o.="o ."


#
# This is a simple, clean PS1 with current git branch displayed.
# How will look like:
#
# λ ~/home/project (master)
#
# NOTE: You may have to configure your terminal to support UTF-8 Unicode
# (so λ will displayed correctly)

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

WHITE="\[\033[1;37m\]"
YELLOW="\[\033[1;33m\]"
NO_COLOUR="\[\033[0m\]"
GREEN="\[\033[1;32m\]"
CYAN="\[\033[1;36m\]"

if [[ "$(uname -n)" == *"desktop"* ]] || \
   [[ "$(uname -n)" == *"laptop"* ]] || \
   [[ "$(uname -n)" == *"MBP"* ]]; then
  GREEK="λ"
elif [[ "$(uname -n)" == *"vagrant"* ]]; then
  GREEK="μ"
else
  GREEK="θ"
fi

# if biome is loaded, prepend with a space because formatting
# if [[ "$BIOME_PROJECT" ]]; then
#   BIOME_PROJECT=" $BIOME_PROJECT"
# fi

PS1="\[\033[1;37m\]$GREEK $CYAN\w$GREEN$YELLOW\$(parse_git_branch)$NO_COLOUR "
# PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

### SUPPLEMENT PATH ###
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/bin"

# if stuck in caps lock, break out
if [[ "uname -s" == "Linux" ]]; then
  alias capsbreak="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
  alias CAPSBREAK="capsbreak"
fi

# android sdk stuff
export ANDROID_SDK="/home/`whoami`/android_sdk"
export ANDROID_NDK="/opt/software/android-ndk"
export ANDROID_HOME="$ANDROID_SDK"
export ANDROID_PLATFORM_TOOLS="$ANDROID_SDK/platform-tools"
export PATH="${PATH}:$ANDROID_HOME/tools:$ANDROID_PLATFORM_TOOLS"

# vim: disable special terminal mode that interprets ctrl-s and friends at the shell level
# only for macs though
if [[ "$(uname)" == "Darwin" ]]; then
  stty -ixon
fi
export TERM=screen-256color # support 256 colors at the shell level

# add go to the path
export PATH=$PATH:/usr/local/go/bin

# add z command for jumping to a file
[[ -f ~/.zsrc ]] && source ~/.zsrc

# alias to connect to my local server over sshfs
alias magnam-sshfs="sudo sshfs -o allow_other,defer_permissions ryan@magnam-server:/volumes/hdd0 /mnt"
alias bluewhale-sshfs="sudo sshfs -o allow_other,defer_permissions root@bluewhale.local:/root/ /mnt"
alias picoimx6-sshfs="sudo sshfs -o allow_other,defer_permissions root@192.168.1.236:/ /mnt"

# alias to force unmount /mnt
alias umnt="sudo diskutil umount force /mnt"

# alias for tmux
alias tn="tmux new -s"
alias ta="tmux attach -t"

# aliases for docker
alias d="docker"
alias k="kubectl"
alias dcc="docker-compose"

# for working with rust
export PATH="$HOME/.cargo/bin:$PATH"

# for working with go
export GOPATH="$HOME/w/go"
export PATH="$PATH:$GOPATH/bin"

# for working with elxir
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

export SHELL_SESSION_HISTORY=0

shopt -s cdspell

# For create react app
export REACT_EDITOR=vim

# source locals
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:/Users/ryan/.local/bin"
