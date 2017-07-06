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

(setq package--init-file-ensured t
      package-enable-at-startup nil)

(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'load-path (concat user-emacs-directory "vendor/use-package"))
(require 'use-package)

;; Theme
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (load-theme 'sanityinc-tomorrow-day t))

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
  :bind (("M-." . godef-jump))
  :init
  (progn
    (setq gofmt-command "goimports")
    (add-to-list 'exec-path "/home/mia/go/bin")
    (add-hook 'before-save-hook 'gofmt-before-save))
  :config
  (add-hook 'go-mode-hook (lambda () (setq tab-width 4))))

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

(provide 'core-packages)
