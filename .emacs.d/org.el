(add-hook
 'org-load-hook
 (lambda ()
   (define-key org-mode-map (kbd "M-<left>") nil)
   (define-key org-mode-map (kbd "M-<right>") nil)
   (define-key org-mode-map (kbd "S-<left>") nil)
   (define-key org-mode-map (kbd "S-<right>") nil)
   (define-key org-mode-map (kbd "S-<up>") nil)
   (define-key org-mode-map (kbd "S-<down>") nil)
   ))
