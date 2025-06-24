#!/usr/bin/env bash

mux=$1

bookmarks=(
	"~/dotfiles"
	"~/krsnktska"
	"~/dotfiles/.scripts"
)

search_paths=(
	"~/stuff/projects"
	"~/dotfiles/.config"
	"~/Documents/nure/semester-4"
)

ignored_names=(
	".git"
	"target"
	"build"
	"__pycache__"
	"venv"
)

bookmarks=$(printf "%s\n" "${bookmarks[@]}")

if [ -x "$(command -v fd)" ]; then
	find_command="fd ."
	find_opts=(--type d --max-depth 1)
else
	find_command="find"
	find_opts=(-mindepth 1 -maxdepth 1 -type d)
fi

expanded_paths=("${search_paths[@]/#\~/$HOME}")
all_subdirs=$($find_command "${expanded_paths[@]}" "${find_opts[@]}")$'\n'

exclude_pattern=$(printf "/%s$\n" "${ignored_names[@]}" | paste -sd '|')

selected_path=$(echo -e "$all_subdirs$bookmarks" | sed 's|/$||' | grep . | grep -vE "$exclude_pattern" | sed "s|^$HOME|~|" | fzf --height 100%)

if [[ -z $selected_path ]]; then
	exit 0
fi

selected_path=$(readlink -f "${selected_path/#\~/$HOME}")
session_name=$(basename "$selected_path" | tr '.' '_')

if [ "$mux" == "zellij" ]; then
	if [[ -z $ZELLIJ ]]; then
		cd $selected_path

		zellij attach $session_name -c
		exit 0
	fi

	zellij pipe --plugin switch -- "--session $session_name --cwd $selected_path --layout default"
else
	tmux_running=$(pgrep tmux)

	if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
		tmux new-session -s $session_name -c $selected_path
		exit 0
	fi

	if ! tmux has-session -t=$session_name 2> /dev/null; then
		tmux new-session -ds $session_name -c $selected_path
	fi

	tmux switch-client -t $session_name
fi

