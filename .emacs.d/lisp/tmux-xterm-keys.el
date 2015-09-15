; handle tmux's xterm-keys
; https://unix.stackexchange.com/questions/24414/shift-arrow-not-working-in-emacs-within-tmux
(if (getenv "TMUX")

;;; screen.el --- define function key sequences and standard colors for screen
(load "term/xterm")

;; derived from Emacs 22.1 term/xterm.el

(defun terminal-init-screen ()
  "Terminal initialization function for screen."

  (let ((map (make-sparse-keymap)))

    ;; tmux with its xterm-keys option turned on will generate these
    (define-key map "\e[1;2A" [S-up])
    (define-key map "\e[1;2B" [S-down])
    (define-key map "\e[1;2C" [S-right])
    (define-key map "\e[1;2D" [S-left])
    (define-key map "\e[1;2F" [S-end])
    (define-key map "\e[1;2H" [S-home])

    (define-key map "\e[1;5A" [C-up])
    (define-key map "\e[1;5B" [C-down])
    (define-key map "\e[1;5C" [C-right])
    (define-key map "\e[1;5D" [C-left])
    (define-key map "\e[1;5F" [C-end])
    (define-key map "\e[1;5H" [C-home])

    (define-key map "\e[1;6A" [C-S-up])
    (define-key map "\e[1;6B" [C-S-down])
    (define-key map "\e[1;6C" [C-S-right])
    (define-key map "\e[1;6D" [C-S-left])
    (define-key map "\e[1;6F" [C-S-end])
    (define-key map "\e[1;6H" [C-S-home])

    (define-key map "\e[1;3A" [A-up])
    (define-key map "\e[1;3B" [A-down])
    (define-key map "\e[1;3C" [A-right])
    (define-key map "\e[1;3D" [A-left])
    (define-key map "\e[1;3F" [A-end])
    (define-key map "\e[1;3H" [A-home])

    ;; This way we don't override terminfo-derived settings or settings
    ;; made in the .emacs file.
    (set-keymap-parent map (keymap-parent function-key-map))
    (set-keymap-parent function-key-map map))

  ;; Use the xterm color initialization code.
  (xterm-register-default-colors)
  (tty-set-up-initial-frame-faces))

)

(provide 'tmux-xterm-keys)
