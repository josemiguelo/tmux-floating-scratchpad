[fork] 2026-09-18
-------------------

-   scratch terminal is now scoped per-session (`floating-<session_name>`) instead of
      one global `floating` session shared across the tmux server.
-   dropped the convert-to-window bindings (`@floating_scratch_to_win`,
      `@floating_scratch_to_active_win`, `@floating_active_pane_to_scratch`).
-   added `@floating_scratch_width` / `@floating_scratch_height` options for the popup
      size, replacing the previous hardcoded 70%x70%.

[v1.1.0] 2025-5-18
-------------------

-   fixed bug when opening the floating popup initially created from another session.

[v1.0.0] 2024-10-21
-------------------

-   refactor commands to bash script
-   enable custom key bindings
-   default keybindings changed to unused tmux bindings,
      requires major version bump.

[v0.0.2] 2024-10-10
-------------------

-   Added, move current pane to popup scratch

[v0.0.1] 2024-10-10
-------------------

-   First working version.

Notes
-----

This change log is kept in <http://keepachangelog.com/> format.
