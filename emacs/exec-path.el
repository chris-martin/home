(defun add-to-exec-path (s)
  (setenv "PATH" (concat s ":" (getenv "PATH")))
  (setq exec-path (cons s exec-path)))

(add-to-exec-path (expand-file-name "~/.bin"))
