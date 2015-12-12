;; install
;; npm install -g tern

;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


(package-initialize)


(require 'react-snippets)
(require 'jsx-mode)
;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)

;;all my extra lisps
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)


;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      nrepl-ritz
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))





(show-paren-mode 1)

;;https://truongtx.me/2014/04/20/emacs-javascript-completion-and-refactoring/
(defun delete-tern-process ()
  (interactive)
  (delete-process "Tern"))

;; see http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)

(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq indent-line-function 'insert-tab)
(set-frame-font "Inconsolata 14")
(load "font-lock")

;; Xmas tree like code 
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)

;match parens during editing
(show-paren-mode 2)
;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)

;;nREPL stuff
;;https://github.com/kingtim/nrepl.el

;;enable eldoc in clojure buffers
;;
(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)

;;The use of paredit when editing Clojure (or any other Lisp) code is
;;highly recommended. 
;;You're probably using it already in your clojure-mode buffers
;;(if you're not you probably should). You might also want to enable paredit in the nREPL buffer as well
(add-hook 'nrepl-mode-hook 'paredit-mode)



;;RainbowDelimiters is a minor mode which highlights parentheses,
;;brackets, 
;;and braces according to their depth. Each successive level is
;;highlighted in a different color. 
;;This makes it easy to spot matching delimiters, orient yourself in
;;the code,
;;and tell which statements are at a given depth.
;;Assuming you've already installed RainbowDelimiters you can enable
;;it in nREPL like this:
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'nrepl-mode-hook 'rainbow-delimiters-mode)

;;https://github.com/pallet/ritz/tree/develop/nrepl
(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(compile-command
   "find . -name '*.js' -print0 -o -name '*.html' -print0 -o -name '*.css' -print0 | xargs -0 grep -Hni ")
 '(custom-enabled-themes (quote (solarized)))
 '(custom-safe-themes
   (quote
    ("d6a00ef5e53adf9b6fe417d2b4404895f26210c52bb8716971be106550cea257" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html
;; use web-mode for .jsx files(add-to-list 'auto-mode-alist
;; '("\\.jsx$" . jsx-mode))
(setq web-mode-content-types-alist
  '(("jsx" . "\\.js[x]?\\'")))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\react.js$" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\jsx$" . jsx-mode))                
;;barton

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable json-jsonlist checking for json files
;;(setq-default flycheck-disabled-checkers
;;(append flycheck-disabled-checkers
;;      '(json-jsonlist)))

(flycheck-add-mode 'javascript-eslint 'jsx-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)

(custom-set-variables  
 '(js2-basic-offset 2)  
 '(js2-bounce-indent-p t)  
)
(setq js-indent-level 2)
(setq jsx-indent-level 2)

;;;;tern
(add-to-list 'load-path "~/projects/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)

(add-hook 'js-mode-hook
        (lambda () (tern-mode t)))
(add-hook 'js-mode-hook
          (lambda () (auto-complete-mode 1)))
                
(add-hook 'jsx-mode-hook
          (lambda () (auto-complete-mode 1)))
(add-hook 'jsx-mode-hook
        (lambda () (tern-mode t)))

(add-hook 'js2-mode-hook
          (lambda () (auto-complete-mode 1)))
(add-hook 'js2-mode-hook
        (lambda () (tern-mode t)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
        


;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))
        
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq last-kbd-macro
   [?\{ ?% ?e backspace ?a ?c ?e ?  ?e ?d ?i ?t ?= ?f ?a ?l ?s ?e ?, ?  ?c ?h ?e ?c ?k ?= ?f ?a ?l ?s ?e ?, ?  ?l ?a ?n ?g ?= ?\' ?j ?a ?v ?a ?s ?c ?r ?i ?p ?t ?\' ?% ?\} return backspace backspace backspace backspace backspace backspace backspace backspace ?\{ ?% ?e ?n ?d ?a ?c ?e ?% ?\} ?\C-p ?\C-e return])

