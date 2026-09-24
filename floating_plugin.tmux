#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

default_floating_scratch_term="M-i"
default_floating_scratch_width="70%"
default_floating_scratch_height="70%"
default_floating_last_session="L"

set_floating_scratch_term_binding() {
	local key_bindings="$(get_tmux_option "@floating_scratch_term" "$default_floating_scratch_term")"
	local width="$(get_tmux_option "@floating_scratch_width" "$default_floating_scratch_width")"
	local height="$(get_tmux_option "@floating_scratch_height" "$default_floating_scratch_height")"
	local key
	for key in $key_bindings; do
			tmux bind-key "$key" "if-shell -F '#{m:floating-*,#S}' {
				detach-client
			} {
				set -gF '@floating_target_session' '#{session_name}'
				set -gF '@floating_target_client' '#{client_name}'
				popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E 'tmux new -A -s \"floating-\$(tmux show -gv @floating_target_session)\"'
			}"
	done
}

# From inside a floating scratch session, jump the client that opened it
# straight to that client's last session (its own switch-client -l target),
# closing the popup in the process. Outside a floating session this is a
# no-op passthrough to tmux's normal switch-client -l.
set_floating_last_session_binding() {
	local key_bindings="$(get_tmux_option "@floating_last_session" "$default_floating_last_session")"
	local key
	for key in $key_bindings; do
		tmux bind-key "$key" "if-shell -F '#{m:floating-*,#S}' {
			run-shell 'tmux switch-client -c \"\$(tmux show -gv @floating_target_client)\" -l'
			detach-client
		} {
			switch-client -l
		}"
	done
}

set_floating_reap_hook() {
	tmux set-hook -g session-closed "run-shell -b '$CURRENT_DIR/scripts/reap_orphans.sh'"
}

main() {
	set_floating_scratch_term_binding
	set_floating_last_session_binding
	set_floating_reap_hook
}
main
