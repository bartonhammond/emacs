(show-paren-mode 1)

;; see http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html


;;all my extra lisps
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/themes/")
;;(require 'rainbow-delimiters)
;;(global-rainbow-delimiters-mode)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)

(setq-default indent-tabs-mode nil)
(setq js-indent-level 2)
(setq indent-line-function 'insert-tab)

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
;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))


;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)
;;barton

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)


;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq last-kbd-macro
   [?\{ ?% ?e backspace ?a ?c ?e ?  ?e ?d ?i ?t ?= ?f ?a ?l ?s ?e ?, ?  ?c ?h ?e ?c ?k ?= ?f ?a ?l ?s ?e ?, ?  ?l ?a ?n ?g ?= ?\' ?j ?a ?v ?a ?s ?c ?r ?i ?p ?t ?\' ?% ?\} return backspace backspace backspace backspace backspace backspace backspace backspace ?\{ ?% ?e ?n ?d ?a ?c ?e ?% ?\} ?\C-p ?\C-e return])

