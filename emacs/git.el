;; Git commit mode - https://emacs.stackexchange.com/questions/17689
(package-initialize) ; otherwise Emacs doesn't know were to find it
(setq package-initialize-at-startup nil) ; don't do it again
(global-git-commit-mode)

;; Highlight modified lines in the fringe
(global-diff-hl-mode)
