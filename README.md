# tmux-floating-scratchpad

Some times you need a scratch terminal. tmux-floating-scratchpad will quickly load a floating pane with a new tmux session. This floating pane can be detached and reattached.

This is a fork of [lloydbond/tmux-floating-terminal](https://github.com/lloydbond/tmux-floating-terminal)
that scopes the scratch terminal to each tmux session instead of sharing one global
`floating` session across the whole server. Switching to another session opens (or
returns to) *that* session's own scratch terminal — `floating-<session_name>` — with
independent windows and state. The convert-scratch-to-window bindings from upstream
were dropped in this fork.

## Requirements

* [tmux](https://github.com/tmux/tmux) >= 3.2

## Supports:

-   Linux
-  *macOS
-  *Cygwin
-  *Windows Subsystem for Linux (WSL)

\* untested, should work.

## Installation via (recommended) [TPM](https://github.com/tmux-plugins/tpm)

Add plugin to the list of TPM plugins in `~/.tmux.conf`:

```
set -g @plugin 'josemiguelo/tmux-floating-scratchpad'

<optional>
set -g @floating_scratch_term 'M-i'
set -g @floating_scratch_width '70%'
set -g @floating_scratch_height '70%'
set -g @floating_last_session 'L'

```
Hit <kbd>tmux-prefix</kbd> + <kbd>I</kbd> to fetch the plugin and source it. You should now be able to use the plugin.

## Manual Installation

Clone the repository:

```
git clone https://github.com/josemiguelo/tmux-floating-scratchpad.git ~/.tmux-floating-scratchpad
```
Add the following to `.tmux.conf`:

```
run-shell ~/.tmux-floating-scratchpad/floating_plugin.tmux
```

Reload tmux:

```
tmux source-file ~/.tmux.conf
```

## Usage

* Open/Close scratch terminal <kbd>tmux-prefix</kbd> <kbd>alt</kbd> + <kbd>i</kbd>

The scratch terminal is a real tmux session named `floating-<session_name>`, so you can
create additional windows inside it (e.g. <kbd>tmux-prefix</kbd> + <kbd>c</kbd>) like
any other session. Toggling the binding while inside a scratch session detaches it;
pressing it again from a different session opens (or returns to) that session's own
scratch terminal.

Closing a session automatically kills its now-orphaned scratch session too, so you
won't accumulate detached `floating-*` sessions over time.

From inside a scratch session, <kbd>tmux-prefix</kbd> <kbd>L</kbd> (tmux's normal
"last session" key) jumps the client that opened the popup to *its* last session and
closes the popup, instead of trying (and failing) to switch the scratch session's own,
mostly nonexistent session history. Outside a scratch session it's unchanged — plain
`switch-client -l`.

## Session cycling

tmux's default prefix <kbd>(</kbd> / <kbd>)</kbd> walks every session on the
server, including each `floating-<session_name>` scratch session. This plugin
does not rebind those keys.

To skip them, filter names matching `^floating-` before calling
`switch-client`. A working example lives in these dotfiles:

- [`tmux-session-cycle`](https://github.com/josemiguelo/.dotfiles/blob/master/private_dot_local/bin/executable_tmux-session-cycle)
- [the `(`/`)` bindings](https://github.com/josemiguelo/.dotfiles/blob/master/private_dot_config/tmux/tmux.conf.tmpl)

`tmux-attach` in that repo also hides `floating-*` sessions from the picker.

## Inspiration / Influence

* [u/kevinhwang91](https://www.reddit.com/r/tmux/comments/itonec/comment/g5jxke4/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
* [u/meain](https://blog.meain.io/2020/tmux-flating-scratch-terminal/)
