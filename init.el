;; Prefer the latest version of a file.
;; Doesn't seems to work for `init.el`.
;; Maybe that's why `init.el` should mostly never change?
(setq load-prefer-newer t)

;; Font configuration
;; Using Hermit font. It can be downloaded at https://pcaro.es/p/hermit/
;; Only use Hermit-medium.otf. The other files aren't 100% monospace.
(when (display-graphic-p)
  (with-demoted-errors "Error loading font: %s"
    (set-frame-font (font-spec :family "Hermit" :size 14))))
