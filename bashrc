# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# use tmux as a shell if at all possible
# if command -v tmux>/dev/null; then
#    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -2
# fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [[ -n $(which nvim) ]]; then
  alias vi="nvim"
else
  alias vi="vim"
fi

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

alias s="(git status > /dev/null 2>&1) && git status || ls -Al"
alias ss="git status -s"
alias l="git log --graph --pretty=oneline --abbrev-commit --date=relative"
alias ol="git log --graph --all --pretty=format:'%C(yellow)%h%C(red)%d%Creset %s %C(green)- %an, %ar%Creset'"
alias ll="git log --stat --abbrev-commit"

alias b="git branch"
alias c="git checkout"
alias master="git checkout master"

alias re="git reset"
alias rh="git reset HEAD"

alias gd="git diff"
alias gds="git diff --staged"

alias r="remote"
alias ra="git remote add"
alias rr="git remote rm"

# hub stuff
alias clone="hub clone"
alias pr="hub pull-request"
alias repo="hub browse"

# other aliases
alias v="vagrant"
alias vup="vagrant up && vagrant ssh"
alias vhalt="vagrant halt"
alias vsusp="vagrant suspend"
alias vs="vagrant status"
alias vrestart="vagrant halt && vagrant up && vagrant ssh"

# make :q work like in vim
alias :q="exit"
alias ,sb="source ~/.bashrc"

# turn caps lock into another control.
[[ -n $(which setxkbmap) ]] && setxkbmap -option ctrl:nocaps

# ssh shortcuts
alias sshcloud="ssh ubuntu@cloud.lono.io"
alias sshc="sshcloud"

alias sshdrop="ssh ryan@apps.rgaus.net"
alias sshd="sshdrop"

alias sshnas="ssh ryan@cname.rgaus.net -p 8022"
alias sshn="sshnas"

# open a file/folder with o
alias o="xdg-open"

#
# This is a simple, clean PS1 with current git branch displayed.
# How will look like:
#
# λ ~/home/project (master)
#
# NOTE: You may have to configure your terminal to support UTF-8 Unicode (so λ will displayed correctly)

function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

WHITE="\[\033[1;37m\]"
YELLOW="\[\033[1;33m\]"
NO_COLOUR="\[\033[0m\]"
GREEN="\[\033[1;32m\]"
CYAN="\[\033[1;36m\]"

if [[ "$(uname -n)" == *"desktop"* ]] || [[ "$(uname -n)" == *"laptop"* ]]; then
  GREEK="λ"
elif [[ "$(uname -n)" == *"vagrant"* ]]; then
  GREEK="μ"
else
  GREEK="θ"
fi

PS1="\[\033[1;37m\]$GREEK $CYAN\w$YELLOW\$(parse_git_branch)$NO_COLOUR "
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

### SUPPLEMENT PATH ###
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"

# lono info
export LONO_DEV_URL="http://lono:T4gXgBqHqXP9TT@dev-cloud.scxml.io/api/v1/lono"
export LONO_DEVICEID="34ffe3053257333936670457"
export MDB="mongodb://lono:lono@ds061731.mongolab.com:61731/lonoapi"
export PDB="postgres://uqdubfzxkyhiok:pvYPRHUg9qQyWrJV1c1v2yoIZg@ec2-107-21-114-132.compute-1.amazonaws.com:5432/d9iash2202aic"
export SMAAS_URL='http://{modelName}.scxmldev.io:8002/api/v3'

# wolfram info
export WOLFRAM_APP_KEY="4W736E-Y82E88RJYQ"

# spotify keys
export SPOTIFY_APP_CLIENTID="490b28c8bf054f928fa0f188abef8c16"
export SPOTIFY_APP_SECRET="08ca228bd9fc47baa1ac59b6551f05ca"

# google maps geolocation keys
export GOOGLE_MAPS_APP_GEOCODE_KEY="AIzaSyDBwQ5IuhsKvaTqhq6p_V4D-x35_Cpgk6g"

# forecast.io keys
export FORECASTIO_APP_API_KEY="45744bed987bb5f9326c4b90d92eb40d"

# google calendar keys
export GOOGLE_APP_CLIENTID="796368167408-9rmitp7n43umec1fmoapdhvolg7tb9mg.apps.googleusercontent.com"
export GOOGLE_APP_SECRET="_QzR0qI0FRfBwfV1DGGsjeAM"

# if stuck in caps lock, break out
alias capsbreak="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"
alias CAPSBREAK="capsbreak"

# android sdk stuff
export ANDROID_SDK="/home/`whoami`/android_sdk"
export ANDROID_NDK="/opt/software/android-ndk"
export ANDROID_HOME="$ANDROID_SDK"
export ANDROID_PLATFORM_TOOLS="$ANDROID_SDK/platform-tools"
export PATH="${PATH}:$ANDROID_HOME/tools:$ANDROID_PLATFORM_TOOLS"

# add go to the path
export PATH=$PATH:/usr/local/go/bin

########################
# Z - folder jump list #
########################
# Copyright (c) 2009 rupa deadwyler under the WTFPL license

# maintains a jump-list of the directories you actually use
#
# INSTALL:
#     * put something like this in your .bashrc/.zshrc:
#         . /path/to/z.sh
#     * cd around for a while to build up the db
#     * PROFIT!!
#     * optionally:
#         set $_Z_CMD in .bashrc/.zshrc to change the command (default z).
#         set $_Z_DATA in .bashrc/.zshrc to change the datafile (default ~/.z).
#         set $_Z_NO_RESOLVE_SYMLINKS to prevent symlink resolution.
#         set $_Z_NO_PROMPT_COMMAND if you're handling PROMPT_COMMAND yourself.
#         set $_Z_EXCLUDE_DIRS to an array of directories to exclude.
#         set $_Z_OWNER to your username if you want use z while sudo with $HOME kept
#
# USE:
#     * z foo     # cd to most frecent dir matching foo
#     * z foo bar # cd to most frecent dir matching foo and bar
#     * z -r foo  # cd to highest ranked dir matching foo
#     * z -t foo  # cd to most recently accessed dir matching foo
#     * z -l foo  # list matches instead of cd
#     * z -c foo  # restrict matches to subdirs of $PWD

[ -d "${_Z_DATA:-$HOME/.z}" ] && {
    echo "ERROR: z.sh's datafile (${_Z_DATA:-$HOME/.z}) is a directory."
}

_z() {

    local datafile="${_Z_DATA:-$HOME/.z}"

    # bail if we don't own ~/.z and $_Z_OWNER not set
    [ -z "$_Z_OWNER" -a -f "$datafile" -a ! -O "$datafile" ] && return

    # add entries
    if [ "$1" = "--add" ]; then
        shift

        # $HOME isn't worth matching
        [ "$*" = "$HOME" ] && return

        # don't track excluded directory trees
        local exclude
        for exclude in "${_Z_EXCLUDE_DIRS[@]}"; do
            case "$*" in "$exclude*") return;; esac
        done

        # maintain the data file
        local tempfile="$datafile.$RANDOM"
        while read line; do
            # only count directories
            [ -d "${line%%\|*}" ] && echo $line
        done < "$datafile" | awk -v path="$*" -v now="$(date +%s)" -F"|" '
            BEGIN {
                rank[path] = 1
                time[path] = now
            }
            $2 >= 1 {
                # drop ranks below 1
                if( $1 == path ) {
                    rank[$1] = $2 + 1
                    time[$1] = now
                } else {
                    rank[$1] = $2
                    time[$1] = $3
                }
                count += $2
            }
            END {
                if( count > 9000 ) {
                    # aging
                    for( x in rank ) print x "|" 0.99*rank[x] "|" time[x]
                } else for( x in rank ) print x "|" rank[x] "|" time[x]
            }
        ' 2>/dev/null >| "$tempfile"
        # do our best to avoid clobbering the datafile in a race condition
        if [ $? -ne 0 -a -f "$datafile" ]; then
            env rm -f "$tempfile"
        else
            [ "$_Z_OWNER" ] && chown $_Z_OWNER:$(id -ng $_Z_OWNER) "$tempfile"
            env mv -f "$tempfile" "$datafile" || env rm -f "$tempfile"
        fi

    # tab completion
    elif [ "$1" = "--complete" -a -s "$datafile" ]; then
        while read line; do
            [ -d "${line%%\|*}" ] && echo $line
        done < "$datafile" | awk -v q="$2" -F"|" '
            BEGIN {
                if( q == tolower(q) ) imatch = 1
                q = substr(q, 3)
                gsub(" ", ".*", q)
            }
            {
                if( imatch ) {
                    if( tolower($1) ~ tolower(q) ) print $1
                } else if( $1 ~ q ) print $1
            }
        ' 2>/dev/null

    else
        # list/go
        while [ "$1" ]; do case "$1" in
            --) while [ "$1" ]; do shift; local fnd="$fnd${fnd:+ }$1";done;;
            -*) local opt=${1:1}; while [ "$opt" ]; do case ${opt:0:1} in
                    c) local fnd="^$PWD $fnd";;
                    h) echo "${_Z_CMD:-z} [-chlrtx] args" >&2; return;;
                    x) sed -i -e "\:^${PWD}|.*:d" "$datafile";;
                    l) local list=1;;
                    r) local typ="rank";;
                    t) local typ="recent";;
                esac; opt=${opt:1}; done;;
             *) local fnd="$fnd${fnd:+ }$1";;
        esac; local last=$1; [ "$#" -gt 0 ] && shift; done
        [ "$fnd" -a "$fnd" != "^$PWD " ] || local list=1

        # if we hit enter on a completion just go there
        case "$last" in
            # completions will always start with /
            /*) [ -z "$list" -a -d "$last" ] && cd "$last" && return;;
        esac

        # no file yet
        [ -f "$datafile" ] || return

        local cd
        cd="$(while read line; do
            [ -d "${line%%\|*}" ] && echo $line
        done < "$datafile" | awk -v t="$(date +%s)" -v list="$list" -v typ="$typ" -v q="$fnd" -F"|" '
            function frecent(rank, time) {
                # relate frequency and time
                dx = t - time
                if( dx < 3600 ) return rank * 4
                if( dx < 86400 ) return rank * 2
                if( dx < 604800 ) return rank / 2
                return rank / 4
            }
            function output(files, out, common) {
                # list or return the desired directory
                if( list ) {
                    cmd = "sort -n >&2"
                    for( x in files ) {
                        if( files[x] ) printf "%-10s %s\n", files[x], x | cmd
                    }
                    if( common ) {
                        printf "%-10s %s\n", "common:", common > "/dev/stderr"
                    }
                } else {
                    if( common ) out = common
                    print out
                }
            }
            function common(matches) {
                # find the common root of a list of matches, if it exists
                for( x in matches ) {
                    if( matches[x] && (!short || length(x) < length(short)) ) {
                        short = x
                    }
                }
                if( short == "/" ) return
                # use a copy to escape special characters, as we want to return
                # the original. yeah, this escaping is awful.
                clean_short = short
                gsub(/\[\(\)\[\]\|\]/, "\\\\&", clean_short)
                for( x in matches ) if( matches[x] && x !~ clean_short ) return
                return short
            }
            BEGIN {
                gsub(" ", ".*", q)
                hi_rank = ihi_rank = -9999999999
            }
            {
                if( typ == "rank" ) {
                    rank = $2
                } else if( typ == "recent" ) {
                    rank = $3 - t
                } else rank = frecent($2, $3)
                if( $1 ~ q ) {
                    matches[$1] = rank
                } else if( tolower($1) ~ tolower(q) ) imatches[$1] = rank
                if( matches[$1] && matches[$1] > hi_rank ) {
                    best_match = $1
                    hi_rank = matches[$1]
                } else if( imatches[$1] && imatches[$1] > ihi_rank ) {
                    ibest_match = $1
                    ihi_rank = imatches[$1]
                }
            }
            END {
                # prefer case sensitive
                if( best_match ) {
                    output(matches, best_match, common(matches))
                } else if( ibest_match ) {
                    output(imatches, ibest_match, common(imatches))
                }
            }
        ')"
        [ $? -gt 0 ] && return
        [ "$cd" ] && cd "$cd"
    fi
}

alias ${_Z_CMD:-z}='_z 2>&1'

[ "$_Z_NO_RESOLVE_SYMLINKS" ] || _Z_RESOLVE_SYMLINKS="-P"

if compctl >/dev/null 2>&1; then
    # zsh
    [ "$_Z_NO_PROMPT_COMMAND" ] || {
        # populate directory list, avoid clobbering any other precmds.
        if [ "$_Z_NO_RESOLVE_SYMLINKS" ]; then
            _z_precmd() {
                _z --add "${PWD:a}"
            }
        else
            _z_precmd() {
                _z --add "${PWD:A}"
            }
        fi
        [[ -n "${precmd_functions[(r)_z_precmd]}" ]] || {
            precmd_functions[$(($#precmd_functions+1))]=_z_precmd
        }
    }
    _z_zsh_tab_completion() {
        # tab completion
        local compl
        read -l compl
        reply=(${(f)"$(_z --complete "$compl")"})
    }
    compctl -U -K _z_zsh_tab_completion _z
elif complete >/dev/null 2>&1; then
    # bash
    # tab completion
    complete -o filenames -C '_z --complete "$COMP_LINE"' ${_Z_CMD:-z}
    [ "$_Z_NO_PROMPT_COMMAND" ] || {
        # populate directory list. avoid clobbering other PROMPT_COMMANDs.
        grep "_z --add" <<< "$PROMPT_COMMAND" >/dev/null || {
            PROMPT_COMMAND="$PROMPT_COMMAND"$'\n''_z --add "$(command pwd '$_Z_RESOLVE_SYMLINKS' 2>/dev/null)" 2>/dev/null;'
        }
    }
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
