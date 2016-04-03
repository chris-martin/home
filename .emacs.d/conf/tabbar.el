(add-hook 'after-init-hook 'tabbar-mode)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun find-tabbar-group-dir (dir)
  "Search up the directory tree looking for a tabbar group root."
  (cond
   ((not dir)                                          "emacs")
   ((string-equal "*" (substring (buffer-name) 0 1))   "emacs")
   ((string= dir "/")                                  "no-group")

   ((file-exists-p (concat dir "/.git"))            (directory-file-name dir))
   ((file-exists-p (concat dir "/.projectile"))     (directory-file-name dir))

   (t (find-tabbar-group-dir (directory-file-name (file-name-directory dir))))))

(setq
 tabbar-buffer-groups-function
 (lambda ()
   (list
     (find-tabbar-group-dir (expand-file-name default-directory)))))
