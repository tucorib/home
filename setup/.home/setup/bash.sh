#!/bin/bash

# Get setup path
SETUP_PATH="$1"
eval EVAL_SETUP_PATH=$SETUP_PATH

echo -n "Setup bash? [y/N]: "
read setup_bash

if [ $setup_bash = "y" ]; then
	DEST_DIR="$SETUP_PATH/bash"

	# Create directory
	mkdir -p "$EVAL_SETUP_PATH"
	# Copy files
	cp -r "./.home/bash/" "$EVAL_SETUP_PATH"
	# Add source in ~/.bashrc
	if [ $(cat ~/.bashrc | grep "^source ${DEST_DIR}" | wc -l) == 0 ]; then
		echo "# .home/bash" >> ~/.bashrc
		echo "source ${DEST_DIR}/.bash_colors" >> ~/.bashrc
		echo "source ${DEST_DIR}/.bash_git" >> ~/.bashrc
		echo "source ${DEST_DIR}/.bash_prompt" >> ~/.bashrc
	fi
fi