(require 'tabbar)

(add-hook 'after-init-hook 'tabbar-mode)

(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)

(defun find-tabbar-group-dir (dir buffer-name)
  "Search up the directory tree looking for a tabbar group root.
   Returns a list of tab groups."
  (let ((dir (expand-file-name dir)))
    (cond
     ((not dir)                               (list (concat dir buffer-name)))
     ((is-ungrouped-buffer-name buffer-name)  (list buffer-name))
     ((string= dir "/")                       (list (concat dir buffer-name)))

     ((is-project-root dir) (list (directory-file-name dir)))

     (t (find-tabbar-group-dir
         (directory-file-name (file-name-directory dir))
         buffer-name)))))

(defun is-ungrouped-buffer-name (buffer-name)
  (and
    (string= "*" (substring buffer-name 0 1))
    (not (string-equal buffer-name "*shell*"))
))

(defun is-project-root (dir)
  (or (file-exists-p (concat dir "/.git"))
      (file-exists-p (concat dir "/.projectile"))))

;; Cached data for the tab group function. This never gets cleaned up, so it
;; does leak memory, but hopefully not significant unless we open an absurd
;; number of buffers. We could probably do this more intelligently by periodically
;; checking the complete list of buffers and cleanng up ones that no longer exist,
;; or just by periodically flushing the whole cache.
(defconst group-table (make-hash-table :test #'equal))

;; Return (f &args) and store the result in the table, or use an existing value
;; from the table if it's there.
;;
;; Values are stored in the table as the second item in a list, to work around
;; the issue that elisp hash tables don't distinguish a nil mapping from a
;; missing mapping.
;;
;; We're not using the skeeto's memoize.el for this, because it isn't fast enough.
(defun cache (table f &rest args)
  (let ((y-wrapper (gethash args table)))
    (if y-wrapper
        (car (cdr y-wrapper))
      (let ((y (apply f args)))
        (progn
          (puthash args (list t y) table)
          y)))))

;; We memoize this function because it's called often and requires disk access,
;; which is noticeably slow if some files are under network mount.
(setq
 tabbar-buffer-groups-function
 (lambda ()
   (cache group-table 'find-tabbar-group-dir default-directory (buffer-name))))

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
