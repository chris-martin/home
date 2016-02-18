;;; package --- summary

;;; Commentary:

;;; Code:

;; Set cursor to a thin vertical bar
(setq-default cursor-type 'bar)

;; Map <home> and <end> keys to mwim
(global-set-key [home] 'mwim-beginning-of-code-or-line)
(global-set-key [end]  'mwim-end-of-line-or-code)

;; Respect camelCase
(add-hook 'after-init-hook 'subword-mode)

;; Scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)) ; one line at a time
      mouse-wheel-progressive-speed nil ; no acceleration
      scroll-step 1) ; keyboard scroll one line at a time

;;; cursor.el ends here
