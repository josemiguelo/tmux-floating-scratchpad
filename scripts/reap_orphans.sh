#!/usr/bin/env bash

# Kills any floating-<session> scratch session whose parent session no longer
# exists. Run on every session-closed event; doesn't need to know which
# session just closed, just recomputes the current orphan set and reaps it.

sessions=()
while IFS= read -r line; do
  sessions+=("$line")
done < <(tmux list-sessions -F '#S' 2>/dev/null)

session_exists() {
  local target="$1" s
  for s in "${sessions[@]}"; do
    [[ "$s" == "$target" ]] && return 0
  done
  return 1
}

for s in "${sessions[@]}"; do
  case "$s" in
    floating-*)
      parent="${s#floating-}"
      session_exists "$parent" || tmux kill-session -t "$s" 2>/dev/null
      ;;
  esac
done
