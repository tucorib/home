#!/bin/bash

# Command
HOME_COMMAND=$1

if [ $HOME_COMMAND = "install" ]; then
	git config --global alias.log "log --oneline --graph"
	git config --global alias.history "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
	git config --global alias.pull "pull --rebase"
	git config --global alias.branch-cleanup "!git branch --merged | grep -e \"^\\s\\+\\(hotfix\\|feature\\)/\" | xargs git branch -d #"
elif [ $HOME_COMMAND = "uninstall" ]; then
	git config --global --unset alias.log
	git config --global --unset alias.history
	git config --global --unset alias.pull
	git config --global --unset alias.branch-cleanup
fi
