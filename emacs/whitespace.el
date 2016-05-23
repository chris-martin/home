(setq-default
 indent-tabs-mode nil   ; Prefer spaces to tabs
 tab-width 4            ; Width of displayed tab characters
 sentence-end-double-space nil
 )

;; Ws-butler removes trailing whitespace from saved files.
;; Ws-butler causes Emacs --daemon to hang, so in daemon mode we set it
;; up only when creating frames, so it won't happen on daemon startup.
;; https://github.com/lewang/ws-butler/issues/4
(defun ws-butler-add-hooks ()
  "Add ws-butler hooks."
  (add-hook 'text-mode-hook 'ws-butler-mode)
  (add-hook 'prog-mode-hook 'ws-butler-mode))
(if (daemonp)
    (add-hook 'before-make-frame-hook 'ws-butler-add-hooks)
  (ws-butler-add-hooks))
