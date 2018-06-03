;; Enable mouse integration - https://bitheap.org/mouseterm/
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 1))))

;; Forward/back buttons
(global-set-key [mouse-8] 'previous-buffer)
(global-set-key [mouse-9] 'next-buffer)
