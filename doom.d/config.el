;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq which-key-idle-delay 0.001)

;; Fix powerlevel10k terminal theme.
(doom-load-envvars-file "~/.doom.d/term-env")

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(setq doom-modeline-project-detection 'projectile)

(after! (:and lispyville doom-modeline)
  (setq mode-line-misc-info
        '(:eval
          (when (featurep 'lispyville)
            (lispyville-mode-line-string "lispy")))))

(map! :map lispy-mode-map-lispy
      "[" 'lispy-brackets
      "}" 'lispy-backward)

(setq lispyville-motions-put-into-special t)
(setq lispyville-commands-put-into-special t)

(after! lispyville
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

  (lispy-define-key lispy-mode-map "v" #'lispyville-toggle-mark-type))

(setq doom-modeline-persp-name t)

(add-hook 'clojure-mode-hook #'subword-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)
(add-hook 'cider-mode-hook #'cider-enlighten-mode)

(setq display-line-numbers-type nil)

(global-display-fill-column-indicator-mode)

(defun disable-display-fill-column-indicator-mode ()
  (display-fill-column-indicator-mode -1))

(add-hook '+doom-dashboard-mode-hook #'disable-display-fill-column-indicator-mode)
(add-hook 'vterm-mode-hook #'disable-display-fill-column-indicator-mode)

(setq fancy-splash-image "~/.doom.d/splash.jpg")

(setq centaur-tabs-height 16)
(setq +treemacs-git-mode 'deferred)

(map! [remap async-shell-command] 'with-editor-async-shell-command)
(map! [remap shell-command] 'with-editor-shell-command)

(after! (:and treemacs doom-themes)
  (treemacs-load-theme "doom-colors"))

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
