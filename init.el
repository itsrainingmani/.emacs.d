(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
your version of emacs does not support ssl connections,
which is unsafe because it allows man-in-the-middle attacks.
there are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "tromey" (concat proto "://tromey.com/elpa/")) t)
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
)

;; This must always be before configuration of packages
(package-initialize)

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-completing-read+

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit

    material-theme
    solarized-theme))

(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

(load "shell-integration.el")
(load "navigation.el")
(load "ui.el")
(load "editing.el")
(load "misc.el")
(load "elisp-editing.el")
(load "setup-clojure.el")
(load "cljstyle-mode.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(compilation-message-face (quote default))
 '(cua-enable-cua-keys nil)
 '(cua-global-mark-cursor-color "#7ec98f")
 '(cua-mode t nil (cua-base))
 '(cua-overwrite-cursor-color "#e5c06d")
 '(cua-read-only-cursor-color "#8ac6f2")
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(highlight-changes-colors (quote ("#e5786d" "#834c98")))
 '(highlight-symbol-colors
   (quote
    ("#551b4b293a05" "#3f214d7540e0" "#5a1a48ea46fe" "#3fbe327642ee" "#42724c8355d4" "#536946893a1a" "#46c448dd5357")))
 '(highlight-symbol-foreground-color "#999791")
 '(highlight-tail-colors
   (quote
    (("#2f2f2d" . 0)
     ("#3d454c" . 20)
     ("#3a463b" . 30)
     ("#40424a" . 50)
     ("#4c4436" . 60)
     ("#4a4136" . 70)
     ("#4c3935" . 85)
     ("#2f2f2d" . 100))))
 '(hl-bg-colors
   (quote
    ("#4c4436" "#4a4136" "#4f4340" "#4c3935" "#3b313d" "#40424a" "#3a463b" "#3d454c")))
 '(hl-fg-colors
   (quote
    ("#2a2929" "#2a2929" "#2a2929" "#2a2929" "#2a2929" "#2a2929" "#2a2929" "#2a2929")))
 '(hl-paren-colors (quote ("#7ec98f" "#e5c06d" "#a4b5e6" "#834c98" "#8ac6f2")))
 '(initial-buffer-choice nil)
 '(initial-scratch-message ";; Enter what you want. This ain't getting saved
")
 '(lsp-ui-doc-border "#999791")
 '(menu-bar-mode nil)
 '(nrepl-message-colors
   (quote
    ("#ffb4ac" "#ddaa6f" "#e5c06d" "#3d454c" "#e2e9ea" "#40424a" "#7ec98f" "#e5786d" "#834c98")))
 '(package-selected-packages
   (quote
    (flycheck flycheck-clj-kondo smartparens aggressive-indent magit tagedit rainbow-delimiters projectile smex ido-completing-read+ cider clojure-mode-extra-font-locking clojure-mode paredit exec-path-from-shell material-theme solarized-theme)))
 '(pos-tip-background-color "#2f2f2d")
 '(pos-tip-foreground-color "#999791")
 '(send-mail-function (quote mailclient-send-it))
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#8ac6f2" "#2f2f2d" 0.2))
 '(term-default-bg-color "#2a2929")
 '(term-default-fg-color "#8c8b85")
 '(tool-bar-mode nil)
 '(vc-annotate-background-mode nil)
 '(weechat-color-list
   (quote
    (unspecified "#2a2929" "#2f2f2d" "#4f4340" "#ffb4ac" "#3d454c" "#8ac6f2" "#4c4436" "#e5c06d" "#40424a" "#a4b5e6" "#4c3935" "#e5786d" "#3a463b" "#7ec98f" "#8c8b85" "#74736e")))
 '(xterm-color-names
   ["#2f2f2d" "#ffb4ac" "#8ac6f2" "#e5c06d" "#a4b5e6" "#e5786d" "#7ec98f" "#e8e5db"])
 '(xterm-color-names-bright
   ["#2a2929" "#ddaa6f" "#6a6965" "#74736e" "#8c8b85" "#834c98" "#999791" "#f6f2e8"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:foreground "#839496" :background "#07273b" :family "Fira Code" :foundry "nil" :slant normal :weight normal :height 120 :width normal))))
 '(font-lock-function-name-face ((t (:foreground "LightSkyBlue"))))
 '(font-lock-keyword-face ((t (:foreground "Cyan1" :slant italic)))))
