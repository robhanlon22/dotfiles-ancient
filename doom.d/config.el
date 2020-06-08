;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. Using environment variables here to
;; make this easier to use on other machines.
(setq user-full-name (getenv "USER_FULL_NAME")
      user-mail-address (getenv "USER_MAIL_ADDRESS"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "MesloLGS NF" :size 14))

;; nord is the new dracula is the new groovbox is the new solarized... anyone
;; remember Kaleidoscope for classic Mac OS?
(setq doom-theme 'doom-nord)

;; I guess org files are Documents? Seems alright. Sorry if anyone clones this
;; on Linux.
(setq org-directory "~/Documents/org/")
(setq org-default-notes-file "~/Documents/org/tasks.org")
(setq deft-directory "~/Documents/deft/")

;; Baby mode for babies like me!
(setq which-key-idle-delay 0.001)

;; Fix powerlevel10k terminal theme.
(doom-load-envvars-file "~/.doom.d/term-env")

;; Open urls in Chrome, because it's the browser I use.
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; All projectile, all the time.
(setq doom-modeline-project-detection 'projectile)

;; Enable emoji!
(set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji"))

(use-package lispyville
  :config

  ;; My poor brain couldn't deal with having to type } to get a []. This makes
  ;; lispyville's behavior more... normal.
  (map! :map lispy-mode-map-lispy
        "[" 'lispy-brackets
        "}" 'lispy-backward)

  ;; Add a string to the modeline that makes it obvious we're in lispy mode.
  (setq mode-line-misc-info
        '(:eval
          (when (featurep 'lispyville)
            (lispyville-mode-line-string "lispy"))))

  ;; Turn on a bunch of extra lispyville keys.
  (lispyville-set-key-theme
   '(operators
     c-w
     c-u
     prettify
     atom-motions
     additional-motions
     commentary
     wrap
     additional
     additional-insert
     mark
     mark-toggle))

  ;; Pressing v while in visual toggles into lispy mark mode, then back out.
  (lispy-define-key lispy-mode-map "v" #'lispyville-toggle-mark-type))

(setq lispyville-motions-put-into-special t)
(setq lispyville-commands-put-into-special t)

;; Show the current perspective in the modeline.
(setq doom-modeline-persp-name t)

;; Don't show line numbers by default because they're annoying.
(setq display-line-numbers-type nil)

;; Make Clojure programming nice :)
(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
(add-hook 'cider-mode-hook #'cider-enlighten-mode)

;; Enable display-fill-column-indicator mode in all modes except for the
;; dashboard and the terminal.
(global-display-fill-column-indicator-mode 1)
(defun disable-display-fill-column-indicator-mode ()
  (display-fill-column-indicator-mode -1))
(add-hook '+doom-dashboard-mode-hook #'disable-display-fill-column-indicator-mode)
(add-hook 'vterm-mode-hook #'disable-display-fill-column-indicator-mode)

;; On my machine, this is kittens :)
(setq fancy-splash-image "~/.doom.d/splash.jpg")

;; Asynchronprogrammious ing is easy
(setq +treemacs-git-mode 'deferred)

;; You're not escaping Emacs that easily!
(map! [remap async-shell-command] 'with-editor-async-shell-command)
(map! [remap shell-command] 'with-editor-shell-command)

;; Less blah, more rah.
(use-package treemacs
  :config (treemacs-load-theme "doom-colors"))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
