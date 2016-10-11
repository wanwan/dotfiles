;; from package
;; ggtags
;; skk
;; helm
;; helm-gtags

;; global
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key [C-tab] 'other-window)
(global-set-key "\M-g" 'goto-line)
(menu-bar-mode t)
(tool-bar-mode -1)
(tooltip-mode -1)
(display-time)
(setq truncate-lines t)
(setq inhibit-startup-message nil)
(require 'server)
(if window-system
    (unless (server-running-p)
    (server-start)))

;; moji-code
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; os depend (for mac)
(when (fboundp 'mac-add-ignore-shortcut) (mac-add-ignore-shortcut '(control ? )))

;; default path
(add-to-list 'load-path "~/.emacs.d/elisp")                              
;;(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
;;  (add-to-list 'load-path default-directory)
;;  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;      (normal-top-level-add-subdirs-to-load-path)))
(require 'init-loader)
(init-loader-load "~/.emacs.d/elpa")

;; japanese font
(when (eq window-system 'ns)
  (create-fontset-from-ascii-font "Menlo-11:weight=normal:slant=normal" nil "menlokakugo")
  (set-fontset-font "fontset-menlokakugo"
		    'unicode
		    (font-spec :family "Hiragino Kaku Gothic ProN" :size 11)
		    nil
		    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo")))

;; info
(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")

;; use full screen mode as default in mac
(when (eq window-system 'ns)
  (add-hook 'window-setup-hook
            (lambda ()
	      (setq mac-autohide-menubar-on-maximize t)
              (set-frame-parameter nil 'fullscreen 'fullboth)
              )))

;; package.el
(when (version< "24.0" emacs-version )
  (require 'package)
  (add-to-list 'package-archives '("melpa"."http://melpa.org/packages/") t)
  (package-initialize))

;; remove tool bar
(tool-bar-mode -1)
;; remove initial splash
(setq inhibit-startup-screen t)

;; hl-line
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;; (cancel-timer global-hl-line-timer)

;; pomodoro
;; http://d.hatena.ne.jp/syohex/20121215/1355579575
;; https://raw.github.com/syohex/emacs-utils/master/pomodoro.el
;;(require 'pomodoro)
;;(setq pomodoro:file "~/.emacs.d/pomodoro.txt")
;;(setq pomodoro:work-time 1
;;      pomodoro:rest-time 1
;;      pomodoro:long-rest-time 1) ;; 作業時間関連
;;(require 'notifications)
;;(defun* my/pomodoro-notification (&key (title "Pomodoro")
;;                                       body
;;                                       (urgency 'critical))
;;  (notifications-notify :title title :body body :urgency urgency))
;;
;;;; 作業終了後の hook
;;(add-hook 'pomodoro:finish-work-hook
;;          (lambda ()
;;            (my/pomodoro-notification :body "Work is Finish")))
;;
;;;; 休憩終了後の hook
;;(add-hook 'pomodoro:finish-rest-hook
;;          (lambda ()
;;            (my/pomodoro-notification :body "Break time is finished")))
;;
;;;; 長期休憩後の hook
;;(add-hook 'pomodoro:long-rest-hook
;;          (lambda ()
;;            (my/pomodoro-notification :body "Long Break time now")))

;; howm
;;(defvar howm-view-title-header "#")  ; this should be evaluated in advance to handle markdown
(setq howm-directory "~/howm.git")
(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
(setq howm-menu-refresh-after-save t)    ;; save 時にメニューを自動更新
(setq howm-list-title t)                 ;; タイトルを表示
(setq howm-view-summary-persistent nil)  ;; 一覧バッファを消す. C-u して [return] だと, 一覧を残す.
(setq howm-menu-schedule-days-before 0)  ;; 予定とToDoの表示数 ;; 今日から
(setq howm-menu-schedule-days 60)        ;; 予定とToDoの表示数 ;; 2週間後まで
(setq howm-menu-todo-num 99)
(defun my-save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))
;(eval-after-load "howm-mode"
;  '(progn
;     (define-key howm-mode-map "\C-c\C-c" 'my-save-and-kill-buffer)))
; file associations
;(defun markdown-text-mode ()
;  (markdown-mode)       ; major
;  (outline-minor-mode)  ; minor
;)
;(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-text-mode))


;; auto-save
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-exclude-regexps '("^/ssh:" "/sudo:" "/multi:" "plink:"))
(auto-save-buffers-enhanced t)


;; skk
(add-to-list 'load-path "~/.emacs.d/elisp/skk")
(require 'skk-autoloads)
(setq skk-user-directory (concat "~/.emacs.d/ddskk" "." (system-name)))
;;(setq skk-user-directory "~/.emacs.d/ddskk/")
(setq skk-large-jisyo "~/.emacs.d/ddskk/SKK-JISYO.L")
(when (require 'skk-autoloads nil t)  
  (define-key global-map (kbd "C-x C-j") 'skk-mode)   ;; C-x j で skk モードを起動  
  (setq skk-byte-compile-init-file t))                ;; .skk を自動的にバイトコンパイル
;; dired-x with skk
(when (require 'dired-x nil t)
  (global-set-key "\C-x\C-j" 'skk-mode))
(add-hook 'dired-load-hook
          (lambda ()
            (load "dired-x")
            (global-set-key "\C-x\C-j" 'skk-mode)
            ))
;; 顔文字
;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?SKK%20%BC%AD%BD%F1#content_1_5
;;(add-to-list 'skk-search-prog-list
;;              '(skk-search-jisyo-file
;;                "/home/hogehoge/skk-dic/SKK-JISYO.KAO"
;;                10000)
;;              t)
;; 2ch用語
;; http://omaemona.wiki.sourceforge.net/2chDic
;;(add-to-list 'skk-search-prog-list
;;              '(skk-search-jisyo-file
;;                "/home/hogehoge/skk-dic/SKK-JISYO.2ch"
;;                10000)
;;     t)
;; カタカナ-英語 変換辞書
;;(add-to-list 'skk-search-prog-list
;;              '(skk-search-jisyo-file
;;                "/home/hogehoge/skk-dic/katakana-eigo.jisyo.L"
;;                10000)
;;     t)




;; tramp
(when (or (equal system-type 'w32) (equal system-type 'windows-nt)) 
  (setenv "PATH" (concat "c:/putty" ";" (getenv "PATH")))
  (require 'tramp)
  (setq tramp-default-method "plink"))


;; isearch
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup) ; isearch で skk のセットアップ
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup) ; isearch で skk のクリーンアップ
(setq skk-isearch-start-mode 'latin)						; isearch で skk の初期状態

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; gtags
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
	      (ggtags-mode 1))))
;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(setq markdown-open-command "markdown_viewer.sh")



;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))



;; functions
;; from http://www.emacswiki.org/emacs/TransposeWindows
(defun swap-window-positions ()         ; Stephen Gildea
  "*Swap the positions of this window and the next one."
  (interactive)
  (let ((other-window (next-window (selected-window) 'no-minibuf)))
    (let ((other-window-buffer (window-buffer other-window))
          (other-window-hscroll (window-hscroll other-window))
          (other-window-point (window-point other-window))
          (other-window-start (window-start other-window)))
      (set-window-buffer other-window (current-buffer))
      (set-window-hscroll other-window (window-hscroll (selected-window)))
      (set-window-point other-window (point))
      (set-window-start other-window (window-start (selected-window)))
      (set-window-buffer (selected-window) other-window-buffer)
      (set-window-hscroll (selected-window) other-window-hscroll)
      (set-window-point (selected-window) other-window-point)
      (set-window-start (selected-window) other-window-start))
    (select-window other-window)))
