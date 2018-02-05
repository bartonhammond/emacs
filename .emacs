;;; Emacs is not a package manager, and here we load its package manager!
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; http://www.flycheck.org/manual/latest/index.html
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(defun create-tags (dir-name)
  "Create tags file."
     (interactive "DDirectory: ")
     (eshell-command 
      (format "find %s -type f -iname *.php | xargs etags --append" dir-name)))


;; See
;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html


;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(javascript-jshint)))

 ;; use eslint with multiple modes
(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'js-mode)

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
          '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Show line-number in the mode line
(line-number-mode 1)
;; Show column-number in the mode line
(column-number-mode 1)
;; Indent 2
(setq js-indent-level 2)
;;stupid black box in center
(setq ring-bell-function 'ignore)
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
   "find . -name '*.js' -print0 -o -name '*.php' -print0 -o -name '*.css' -print0 | xargs -0 grep -Hni ")
 '(custom-enabled-themes (quote (deeper-blue)))
)

(fset 'psyshell
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([92 80 115 121 92 83 104 101 108 108 58 58 100 101 98 117 103 40 103 101 116 95 100 101 118 105 99 backspace backspace backspace 102 105 110 101 100 95 118 97 114 115 40 41 44 36 116 104 105 115 41 59] 0 "%d")) arg)))

