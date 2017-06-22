;; Font configuration
;; Using Hermit font. It can be downloaded at https://pcaro.es/p/hermit/
;; Only use Hermit-medium.otf. The other files aren't 100% monospace.
(when (display-graphic-p)
  (with-demoted-errors "Error loading font: %s"
    (set-frame-font (font-spec :family "Hermit" :size 14))))

;; The core feature doesn't do much right now, but it helps with
;; loading the latest version of a file, i.e., `.el` being newer then
;; `.elc`.
(provide 'core)
