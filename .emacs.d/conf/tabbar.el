;;; package --- summary

;;; Commentary:

;;; Code:

(add-hook 'after-init-hook 'tabbar-mode)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun find-tabbar-group-dir (dir)
  "Search up the directory tree looking for a tabbar group root."
  (cond
   ((not dir) "process")
   ((string= dir "/") "no-git")
   ((file-exists-p (concat dir "/.git")) dir)
   ((file-exists-p (concat dir "/.projectile")) dir)
   (t (find-tabbar-group-dir (directory-file-name (file-name-directory dir))))))

(setq
 tabbar-buffer-groups-function
 (lambda ()
   (list
    (find-tabbar-group-dir (buffer-file-name (current-buffer))))))

(provide 'tabbar)
;;; tabbar.el ends here
