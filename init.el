;; Prefer the latest version of a file.
;; In conjunction with (require 'core ...), it guarantees that Emacs
;; will always load the latest version of a file, compiled or not
;; (except for init.el).
(setq load-prefer-newer t)
(require 'core (concat user-emacs-directory "core/core"))
