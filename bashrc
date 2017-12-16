# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi
								    
find_git_branch () {

local dir=. head

until [ "$dir" -ef / ]; do

if [ -f "$dir/.git/HEAD" ]; then

head=$(< "$dir/.git/HEAD")

if [[ $head = ref:\ refs/heads/* ]]; then

git_branch=" (${head#*/*/})"

elif [[ $head != '' ]]; then

git_branch=" → (detached)"

else

git_branch=" → (unknow)"

fi

return

fi

dir="../$dir"

done

git_branch=''

}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

black=$'\[\e[1;30m\]'

red=$'\[\e[1;31m\]'

green=$'\[\e[1;32m\]'

yellow=$'\[\e[1;33m\]'

blue=$'\[\e[1;34m\]'

magenta=$'\[\e[1;35m\]'

cyan=$'\[\e[1;36m\]'

white=$'\[\e[1;37m\]'

normal=$'\[\e[m\]'

PS1="$white[$white@$green\h$white:$cyan\W$yellow\$git_branch$white]\$ $normal"

alias cls='tput reset'
alias egrep='egrep -G'
alias fgrep='fgrep -G'
alias grep='grep -G'
alias l.='ls -d .* -G'
alias ll='ls -l -G'
alias ls='ls -G'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

export CLICOLOR=1
# \h:\W \u\$
export PS1='\[\033[01;33m\]\u@\h\[\033[01;31m\] \W\$\[\033[00m\] '
# grep

alias grep='grep --color=always'
