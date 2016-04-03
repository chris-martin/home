(require 'tabbar)

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

;; Set the tabbar grouping function to group by project.
(setq
 tabbar-buffer-groups-function
 (lambda ()
   (list
     (find-tabbar-group-dir (expand-file-name default-directory)))))

(setq tabbar-use-images nil)

(defun set-tabbar-face (face fg bg)
  (set-face-attribute face nil
                      :background bg
                      :foreground fg
                      :box `(:line-width 4 :color ,bg :style nil)))

(set-tabbar-face 'tabbar-default    "gray10" "#ddd")
(set-tabbar-face 'tabbar-unselected "gray10" "#ddd")
(set-tabbar-face 'tabbar-selected   "black"  "gray65")
(set-tabbar-face 'tabbar-modified   "blue"   "#ddd")
(set-tabbar-face 'tabbar-highlight  "black"  "#gray75")
(set-tabbar-face 'tabbar-button     "gray10" "#ddd")
(set-tabbar-face 'tabbar-separator  "black"  "#ddd")

(set-face-attribute 'tabbar-separator nil :height 165)

(tabbar-mode 1)

(setq tabbar-tab-label-function
      (lambda (tab) (format "   %s    " (tabbar-buffer-tab-label tab))))
