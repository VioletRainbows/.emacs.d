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

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Why do I need this kind of shit is beyond me.
;; Would not compile without it.
(eval-when-compile
  (require 'package)
  (package-initialize)
  (require 'use-package))
(require 'use-package)

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

;; Why are emacs tabs (or space) not ok by default is beyond me.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Use linux coding style
(require 'cc-mode)
(setq c-default-style "linux")
(setq-default c-basic-offset 8
              tab-width 8)

;; scroll four lines at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4))) ;; four lines at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; Don't make backup files. That's what git is for.
(setq make-backup-files nil)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight matching brackets
(show-paren-mode 1)

;; Set minumum width to 82 so that MIT license header isn't multi-line
(when (display-graphic-p)
  (set-frame-size (selected-frame) 82 35))

;; Theme
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-night t))

;; Powerline
(use-package powerline
  :ensure t
  :init
  (powerline-default-theme))

;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (progn
    (add-hook 'after-init-hook #'global-flycheck-mode)
    ;; Don't check emacs comments errors
    (with-eval-after-load 'flycheck
      (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))))

;; Show fkycheck errors under the cursor
(use-package flycheck-pos-tip
  :ensure t
  :init
  (with-eval-after-load 'flycheck
    (flycheck-pos-tip-mode)))

(use-package magit
  :ensure t)

(use-package neotree
  :ensure t)

(use-package company
  :ensure t
  :init
  (global-company-mode))

;; Go configuration
(use-package go-mode
  :ensure t
  :init
  (progn
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)

    (setenv "GOPATH" (expand-file-name "~/go"))
    (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/go/bin")))
    (setq exec-path (append exec-path (list (expand-file-name "~/go/bin")))))
  :config
  (add-hook 'go-mode-hook (lambda () (progn
                                       (setq tab-width 4)
                                       (local-set-key (kbd "M-.") 'godef-jump)))))

(use-package company-go
  :ensure t
  :init
  (with-eval-after-load 'company
    (add-to-list 'company-backends 'company-go)))

(use-package go-guru
  :ensure t
  :init
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode))

(use-package go-rename
  :ensure t)

(use-package yaml-mode
  :ensure t
  :mode "\\.yml$")

(use-package terraform-mode
  :ensure t
  :mode "\\.tf$"
  :init
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

(use-package dockerfile-mode
  :ensure t
  :mode "Dockerfile\\'")

(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'"
  ;; Not running rustfmt on save
  ;; See https://github.com/rust-lang-nursery/rustfmt/issues/2095
  :config (setq rust-format-on-save nil))

;; Run cargo commands in rust buffers, e.g. C-c C-c C-r for cargo-run
(use-package cargo
  :ensure t
  :init
  (add-hook 'rust-mode-hook 'cargo-minor-mode)
  (add-hook 'toml-mode-hook 'cargo-minor-mode))

(use-package racer
  :ensure t
  :init
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  :config
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common))

;; Doesn't work, json-read-error
(use-package flycheck-rust
  :ensure t
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package toml-mode
  :ensure t)

(provide 'core-packages)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (toml-mode powerline yaml-mode use-package terraform-mode neotree magit go-rename go-guru flycheck-pos-tip dockerfile-mode company-go color-theme-sanityinc-tomorrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
