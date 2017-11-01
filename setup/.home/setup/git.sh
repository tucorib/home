#!/bin/bash

# Command
HOME_COMMAND=$1

# Get setup path
SETUP_PATH=$2
eval EVAL_SETUP_PATH=$SETUP_PATH

./.home/git/git-aliases.sh "$HOME_COMMAND"
