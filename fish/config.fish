if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias safechrome="open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security"

alias gitlogger="git log --oneline -20 --graph"

alias gitcp="git branch | grep '^\*' | cut -d' ' -f2 | pbcopy"

alias gittemp="git commit -m "暫存""

function nvm
    bass source /usr/local/opt/nvm/nvm.sh ';' nvm $argv
end

#function tree
#	find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
#end

nvm -v

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

starship init fish | source
