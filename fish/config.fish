# rbenv
status --is-interactive; and source (rbenv init -|psub);

# Golang
set -x GOPATH ~/workspace/go
set -x GODEV ~/workspace/golang
set -x GOROOT_BOOTSTRAP (go env GOROOT)
set PATH $GOPATH/bin $PATH

# fuck
eval (thefuck --alias | tr '\n' ';')

set -x EDITOR subl
set -x LANG "en_US.UTF-8"

####################
# Helper functions #
####################

# Create an HTTP server serving current directory on port 8080
function serve
    python3 -m http.server --bind=localhost 8080
end

function docker-bash
	docker exec -it $argv /bin/bash
end

function docker-sh
    docker exec -it $argv /bin/sh
end

function docker-clean
	echo "Removing containers..."
	docker rm -f (docker ps -a -q)
	echo "Removing images..."
	docker rmi -f (docker images -q)
	docker ps -a | cut -c-12 | xargs docker rm
end

function cleanup
	rm "/Users/roman/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.RecentDocuments.sfl"
	rm "/Users/roman/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments.sfl"
	rm -r "/Users/roman/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments"
end

###########
# Aliases #
###########

alias l="ls -CF"

alias git=hub
alias g=git


alias brew-sync="cd ~/workspace/dotfiles; brew update; brew upgrade; brew bundle; brew cleanup; brew bundle cleanup -v --force"

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s
	if [ (count $argv) -eq 0 ]
		subl .
	else
		subl "$argv"
	end
end

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v
	if [ (count $argv) -eq 0 ]
		vim .
	else
		vim "$argv"
	end
end

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o
	if [ (count $argv) -eq 0 ]
		open .
	else
		open "$argv"
	end
end

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$argv" | less -FRNX
end
