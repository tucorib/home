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
	if [ $HOME_COMMAND = "install" ]; then
		# Copy file
		cp "./.home/bash/.bash_colors" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^source ${SETUP_PATH}/bash/.bash_colors$" | wc -l) == 0 ]; then
			echo "source ${SETUP_PATH}/bash/.bash_colors" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_colors" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_colors"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${SETUP_PATH}/bash/.bash_colors#d" ~/.bashrc
	fi
}

function bash_git {
	if [ $HOME_COMMAND = "install" ]; then
		# Copy file
		cp "./.home/bash/.bash_git" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^source ${SETUP_PATH}/bash/.bash_git$" | wc -l) == 0 ]; then
			echo "source ${SETUP_PATH}/bash/.bash_git" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_git" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_git"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${SETUP_PATH}/bash/.bash_git#d" ~/.bashrc
	fi
}

function bash_prompt {
	if [ $HOME_COMMAND = "install" ]; then
		# Copy file
		cp "./.home/bash/.bash_prompt" "$EVAL_SETUP_PATH/bash/"
		# Add source in ~/.bashrc
		if [ $(cat ~/.bashrc | grep "^source ${SETUP_PATH}/bash/.bash_prompt$" | wc -l) == 0 ]; then
			echo "source ${SETUP_PATH}/bash/.bash_prompt" >> ~/.bashrc
		fi
	elif [ $HOME_COMMAND = "uninstall" ]; then
		# Delete file
		if [ -f "$EVAL_SETUP_PATH/bash/.bash_prompt" ]; then
			rm "$EVAL_SETUP_PATH/bash/.bash_prompt"
		fi
		# Remove source in ~/.bashrc
		sed -i "\#${SETUP_PATH}/bash/.bash_prompt#d" ~/.bashrc
	fi
}

pre
bash_colors
bash_git
bash_prompt
post
