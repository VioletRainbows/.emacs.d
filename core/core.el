;; MIT License

;; Copyright (c) 2017 Mia Boulay

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in all
;; copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;; Font configuration
;; Using Hermit font. It can be downloaded at https://pcaro.es/p/hermit/
;; Only use Hermit-medium.otf. The other files aren't 100% monospace.
(when (display-graphic-p)
  (with-demoted-errors "Error loading font: %s"
    (set-frame-font (font-spec :family "Hermit" :size 14))))

;; Disable bold fonts. When a new mode is loaded, it can ignore the
;; `set-face-attribute`. This is why the `add-hook` is required.
(defun disable-bold-fonts ()
  "Disable bold fonts across all emacs modes"
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal))
   (face-list)))
(add-hook 'change-major-mode-after-body-hook 'disable-bold-fonts)

;; This Emacs version is called Violet Emacs.
(setq frame-title-format '"Violet Emacs")

;; Don't show the startup screen.
(setq inhibit-startup-message t)

;; Don't show all those bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode (cons 0 nil))

;; Don't make backup files. That's what git is for.
(setq make-backup-files nil)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight matching brackets
(show-paren-mode 1)

;; The core feature doesn't do much right now, but it helps with
;; loading the latest version of a file, i.e., `.el` being newer then
;; `.elc`.
(provide 'core)
