#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

default_floating_scratch_term="M-i"
default_floating_scratch_width="70%"
default_floating_scratch_height="70%"

set_floating_scratch_term_binding() {
	local key_bindings="$(get_tmux_option "@floating_scratch_term" "$default_floating_scratch_term")"
	local width="$(get_tmux_option "@floating_scratch_width" "$default_floating_scratch_width")"
	local height="$(get_tmux_option "@floating_scratch_height" "$default_floating_scratch_height")"
	local key
	for key in $key_bindings; do
			tmux bind-key "$key" "if-shell -F '#{m:floating-*,#S}' {
				detach-client
			} {
				popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E 'tmux new -A -s floating-#{session_name}'
			}"
	done
}

main() {
	set_floating_scratch_term_binding
}
main
