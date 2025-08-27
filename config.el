;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Sarasa Mono K" :size 18))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;这个地方配置快捷键
(map! :ne "; f"    'dirvish)
(map! :ne "; w"    'save-buffer)
(after! dired
  (map! :map dired-mode-map
        :n "c" nil
        "c" nil))
(after! dired
  (map! :map dired-mode-map
        :n "c" #'dired-create-empty-file))
(map! :ie  "C-h"     #'backward-delete-char-untabify         )
(general-def          'insert "C-h"    'delete-backward-char )
(keyboard-translate ?\C-h ?\C-?                              )

(map! :nve "; g"      'evil-last-non-blank                   )
(map! :nve "; a"      'evil-first-non-blank                  )
(map! :nve "; e"      'er/expand-region                  )
(map! :ne  "f"        'evil-avy-goto-char                    )
(setq rime-user-data-dir             "~/Library/Rime/"                               ;; rime config input method setting
      rime-librime-root              (concat doom-user-dir "dist")                   ;; emacs-rime/blob/master/INSTALLATION.org
      rime-emacs-module-header-root  "/opt/homebrew/opt/emacs-plus@31/include"           ;; for emacs rime, brew do not needed
      ;; rime-emacs-module-header-root  "/Applications/Emacs.app"                          ;; for emacs rime, brew do not needed
      )
;; just install emacs first https://rime.im
(use-package! rime
  :defer t
  :config
  (setq rime-show-candidate 'minibuffer)
  (setq rime-translate-keybindings '("C-n" "C-p" "<left>" "<right>" "<up>" "<down>"))
  :custom
  ;; (rime-emacs-module-header-root emacs-module-root)
  (default-input-method "rime"))
(setq mode-line-mule-info   '((:eval (rime-lighter)))
      rime-title "CH"
      rime-inline-ascii-trigger 'shift-l
      rime-disable-predicates '(
                                rime-predicate-current-uppercase-letter-p
                                rime-predicate-after-ascii-char-p
                                rime-predicate-space-after-cc-p))


;; 输入法切换按键
(global-set-key (kbd "C-,"  ) 'toggle-input-method             )
(global-unset-key (kbd "C-;"))
(global-set-key (kbd "C-;"  ) nil             )
(map! :after org
      :map (org-mode-map)
      "C-," nil)

(map! :map (minibuffer-local-map)
      "C-," 'toggle-input-method)
(use-package! org-modern
  :hook (org-mode . org-modern-mode))
;; org-modern 美化配置
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  ;; 标题符号（替换 *）
  (setq org-modern-star '("◉" "○" "▷" "✸" "✿"))

  ;; 列表符号（替换 -, +, *）
  (setq org-modern-list '((?- . "•") (?+ . "◦") (?* . "◆")))

  ;; TODO / DONE 高亮
  (setq org-modern-todo-faces
        '(("TODO" :background "red" :foreground "white" :weight bold)
          ("WAIT" :background "orange" :foreground "black" :weight bold)
          ("DONE" :background "forest green" :foreground "white" :weight bold)))

  ;; 优先级符号设置
  (setq org-modern-priority
        '((?A . "❗")   ;; A 级 → 红色感叹号
          (?B . "⬆")   ;; B 级 → 黄色箭头
          (?C . "⬆"))) ;; C 级 → 蓝色箭头

  ;; 给优先级符号上色
  (custom-set-faces
   '(org-priority-A ((t (:foreground "red"    :weight bold))))
   '(org-priority-B ((t (:foreground "orange" :weight bold))))
   '(org-priority-C ((t (:foreground "blue"   :weight bold))))))

(after! org
  (setq org-time-stamp-formats '("<%Y-%m-%d %H:%M>" . "<%Y-%m-%d>")))

(map! :after org
      :map org-mode-map
      :ne "; l" #'org-toggle-narrow-to-subtree)
(use-package org-appear
  :defer t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks       t )
  (setq org-appear-autosubmarkers  t )
  (setq org-appear-autoentities    t )
  (setq org-appear-autokeywords    t )
  (setq org-appear-inside-latex    t ))
