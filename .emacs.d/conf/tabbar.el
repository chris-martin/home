(require 'tabbar)

(add-hook 'after-init-hook 'tabbar-mode)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun find-tabbar-group-dir (dir)
  "Search up the directory tree looking for a tabbar group root."
  (let* ((dir (expand-file-name dir)))
    (cond
     ((not dir)                                          "emacs")
     ((string-equal "*" (substring (buffer-name) 0 1))   "emacs")
     ((string= dir "/")                                  "no-group")

     ((file-exists-p (concat dir "/.git"))            (directory-file-name dir))
     ((file-exists-p (concat dir "/.projectile"))     (directory-file-name dir))

     (t (find-tabbar-group-dir (directory-file-name (file-name-directory dir)))))))

;; Cached data for the tab group function. This never gets cleaned up, so it
;; does leak memory, but hopefully not significant unless we open an absurd
;; number of buffers. We could probably do this more intelligently by periodically
;; checking the complete list of buffers and cleanng up ones that no longer exist,
;; or just by periodically flushing the whole cache.
(defconst group-table (make-hash-table))

;; Return (f x) and store the result in the table, or use an existing value
;; from the table if it's there. We're not using the skeeto's memoize.el for
;; this, because it isn't fast enough.
(defun cache (f x table)
  (or (gethash x table)
      (let ((y (funcall f x)))
        (progn (puthash x y table) y))))

;; We memoize this function because it's called often and requires disk access,
;; which is noticeably slow if some files are under network mount.
(setq
 tabbar-buffer-groups-function
 (lambda ()
   (list (cache 'find-tabbar-group-dir default-directory group-table))))

(setq tabbar-use-images nil)

(defun set-tabbar-face (face fg bg)
  (set-face-attribute face nil
                      :background bg
                      :foreground fg
                      :underline nil
                      :box `(:line-width 4 :color ,bg :style nil)))

(set-tabbar-face 'tabbar-default    "gray10" "#ddd")
(set-tabbar-face 'tabbar-unselected "gray10" "#ddd")
(set-tabbar-face 'tabbar-selected   "black"  "gray65")
(set-tabbar-face 'tabbar-modified   "blue"   "#ddd")
(set-tabbar-face 'tabbar-highlight  "black"  "gray75")
(set-tabbar-face 'tabbar-button     "gray10" "#ddd")
(set-tabbar-face 'tabbar-separator  "black"  "#ddd")

(set-face-attribute 'tabbar-separator nil :height 165)

(tabbar-mode 1)

(setq tabbar-tab-label-function
      (lambda (tab) (format "   %s    " (tabbar-buffer-tab-label tab))))
