(show-paren-mode 1)

;;all my extra lisps
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

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
 '(compile-command "find . -name '*.js' -print0 -o -name '*.html' -print0 -o -name '*.css' -print0 | xargs -0 grep -Hni ")
 )
