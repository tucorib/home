#!/bin/bash

# Setup script for home

# Command
HOME_COMMAND=$1

SETUP_PATH="~/.home"
echo -n "Home setup path? [$SETUP_PATH]: "
read prompt_setup_path
if ! [ "$prompt_setup_path" = "" ]; then
	$SETUP_PATH = "$PROMPT_SETUP_PATH"
fi

if [ $HOME_COMMAND = "install" ]; then
	eval EVAL_SETUP_PATH=$SETUP_PATH
	# Create directory
	mkdir -p "$EVAL_SETUP_PATH"
fi

./.home/setup/bash.sh "$HOME_COMMAND" "$SETUP_PATH"

if [ $HOME_COMMAND = "uninstall" ]; then
	eval EVAL_SETUP_PATH=$SETUP_PATH
	# If no more file in $EVAL_SETUP_PATH, delete it
	if [ -d "$EVAL_SETUP_PATH" ] && [ -z "$(ls -A $EVAL_SETUP_PATH)" ]; then
		rmdir "$EVAL_SETUP_PATH"
	fi
fi

exit 0;