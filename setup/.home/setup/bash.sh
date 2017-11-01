#!/bin/bash

# Command
HOME_COMMAND=$1

# Get setup path
SETUP_PATH=$2
eval EVAL_SETUP_PATH=$SETUP_PATH

function pre {
	if [ $HOME_COMMAND = "install" ]; then
		eval EVAL_SETUP_PATH=$SETUP_PATH
		# Create directory
		mkdir -p "$EVAL_SETUP_PATH/bash"
	fi
}

function post {
	if [ $HOME_COMMAND = "uninstall" ]; then
		eval EVAL_SETUP_PATH=$SETUP_PATH
		# If no more file in $EVAL_SETUP_PATH/bash, delete it
		if [ -d "$EVAL_SETUP_PATH/bash" ] &&  [ -z "$(ls -A $EVAL_SETUP_PATH/bash)" ]; then
			rmdir "$EVAL_SETUP_PATH/bash"
		fi
	fi
}

function bash_colors {
	bashrc_line="source ${SETUP_PATH}/bash/.bash_colors"
	if [ $HOME_COMMAND = "install" ]; then
		# Copy file
		cp "./.home/bash/.bash_colors" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^${bashrc_line}$" | wc -l) == 0 ]; then
			echo "${bashrc_line}" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_colors" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_colors"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${bashrc_line}#d" ~/.bashrc
	fi
}

function bash_git {
	bashrc_line="source ${SETUP_PATH}/bash/.bash_git ${SETUP_PATH}"
	if [ $HOME_COMMAND = "install" ]; then
		# Get git-prompt.sh
		wget -q -O "$EVAL_SETUP_PATH/bash/git-prompt.sh" "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
		# Copy file
		cp "./.home/bash/.bash_git" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^${bashrc_line}$" | wc -l) == 0 ]; then
			echo "${bashrc_line}" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete git-prompt.sh
		if [ -f "$EVAL_SETUP_PATH/bash/git-prompt.sh" ]; then
			rm "$EVAL_SETUP_PATH/bash/git-prompt.sh"
		fi
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_git" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_git"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${bashrc_line}#d" ~/.bashrc
	fi
}

function bash_prompt {
	bashrc_line="source ${SETUP_PATH}/bash/.bash_prompt"
	if [ $HOME_COMMAND = "install" ]; then
		# Copy file
		cp "./.home/bash/.bash_prompt" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^${bashrc_line}$" | wc -l) == 0 ]; then
			echo "${bashrc_line}" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_prompt" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_prompt"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${bashrc_line}#d" ~/.bashrc
	fi
}

pre
bash_colors
bash_git
bash_prompt
post
