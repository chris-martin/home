;;; package --- summary

;; Markdown - http://jblevins.org/projects/markdown-mode/

;;; Commentary:

;;; Code:

(eval-when-compile (require 'cl))

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(eval-after-load "markdown-mode"
  (lambda ()
    (define-key markdown-mode-map (kbd "M-<left>" ) nil)
    (define-key markdown-mode-map (kbd "M-<right>") nil)))

;;; markdown.el ends here
