(add-hook 'after-init-hook 'tabbar-mode)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun find-git-dir (dir)
  "Search up the directory tree looking for a .git folder."
  (cond
    ((not dir) "process")
    ((string= dir "/") "no-git")
    ((file-exists-p (concat dir "/.git")) dir)
    (t (find-git-dir (directory-file-name (file-name-directory dir))))))

(defun git-tabbar-buffer-groups ()
  "Groups tabs in tabbar-mode by the git repository they are in."
  (list
   (find-git-dir (buffer-file-name (current-buffer)))))

(setq tabbar-buffer-groups-function 'git-tabbar-buffer-groups)
