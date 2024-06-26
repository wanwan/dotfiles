; from package
;; ggtags
;; skk
;; helm
;; helm-gtags

;; global
(global-set-key "\C-h" 'delete-backward-char)
(global-set-key [C-tab] 'other-window)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-auto-revert-mode t)
;;(menu-bar-mode t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
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

;; disable upper/lower region cause sometime mistype C-x u (undo)
(put 'upcase-region 'disabled t)
(put 'downcase-region 'disabled t)
(global-set-key (kbd "C-x C-u") nil)
(global-set-key (kbd "C-x C-l") nil)

;; os depend (for mac)
(when (fboundp 'mac-add-ignore-shortcut) (mac-add-ignore-shortcut '(control ? )))

;; disable eof newline
(setq require-final-newline nil)


;; default path
(add-to-list 'load-path "~/.emacs.d/elisp")
;;(let ((default-directory (expand-file-name "~/.emacs.d/site-lisp")))
;;  (add-to-list 'load-path default-directory)
;;  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;;      (normal-top-level-add-subdirs-to-load-path)))
(require 'init-loader)
(init-loader-load "~/.emacs.d/elpa")

;; default theme
(load-theme 'misterioso t)

;; disable dialog
(defalias 'message-box 'message)
(setq use-dialog-box nil)


; ずれ確認用
; 0123456789012345678901234567890123456789
; ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
; あいうえおあいうえおあいうえおあいうえお

;; japanese font
(when (eq window-system 'ns)
  (create-fontset-from-ascii-font "Menlo-11:weight=normal:slant=normal" nil "menlokakugo")
  (set-fontset-font "fontset-menlokakugo"
                    'unicode
                    (font-spec :family "Hiragino Kaku Gothic ProN" :size 11)
                    nil
                    'append)
  (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo")))

;; for X
(when (eq window-system 'x)
  ;; Japanese font
  (if (version<= "27.1" emacs-version)
      (progn
	;; emacs version >= 27.1
	(if (string-match "-[Mm]icrosoft" operating-system-release)
	    ;; WSL: WSL1 has "-Microsoft", WSL2 has "-microsoft-standard"
	    (progn
	      (set-fontset-font t 'japanese-jisx0208 (font-spec :family "Ricty"))
	      (set-face-attribute 'default nil :height 130)
;;	      (setq face-font-rescale-alist '(("Ricty" . 1.4)))
	      )
	  ;; not WSL (may be native linux or unix like os
	  (progn
	    )
	  )
	)
    (progn
      ;; emacs version < 27.1
      ;;(set-default-font "Inconsolata-11")
      (set-face-font 'variable-pitch "Inconsolata-11")
      (set-fontset-font t 'japanese-jisx0208 (font-spec :family "Ricty"))
    ;;(set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAExGothic")))
    ;;(set-fontset-font (frame-parameter nil 'font)
    ;;                'japanese-jisx0208
    ;;                '("Takaoゴシック" . "unicode-bmp")))
      )
    ))

;; for windows
(when (eq window-system 'w32)
  (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
  "Use cygwin's /dev/null as the null-device."
  (let ((null-device "/dev/null"))
        ad-do-it))
  (ad-activate 'grep-compute-defaults)
  (setq grep-find-template
      "find . <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")
)


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
  (package-initialize)
;;  (exec-path-from-shell-initialize)
  )

;; use environment PATH for emacs path
(exec-path-from-shell-initialize)


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

;; paren check
(show-paren-mode 1)

;; pomodoro
;; http://d.hatena.ne.jp/syohex/20121215/1355579575
;; https://raw.github.com/syohex/emacs-utils/master/pomodoro.el
(require 'pomodoro)
(setq pomodoro:file "~/.emacs.d/pomodoro.txt")
(setq pomodoro:work-time 25
      pomodoro:rest-time 5
      pomodoro:long-rest-time 15
      pomodoro:max-iteration 1) ;; 作業時間関連
(require 'notifications)
(defun my/pomodoro-notification (:body body)
  (setq title "Pomodoro")
  (setq urgency 'critical)
  (notifications-notify :title title :body body :urgency urgency))

;; 作業終了後の hook
(add-hook 'pomodoro:finish-work-hook
          (lambda ()
            (my/pomodoro-notification :body "Work is Finish")))
;; 休憩終了後の hook
(add-hook 'pomodoro:finish-rest-hook
          (lambda ()
            (my/pomodoro-notification :body "Break time is finished")))

;; 長期休憩後の hook
(add-hook 'pomodoro:long-rest-hook
          (lambda ()
            (my/pomodoro-notification :body "Long Break time now")))

;; howm
;;(defvar howm-view-title-header "#")  ; this should be evaluated in advance to handle markdown
(setq howm-directory "~/howm.git")
;;(add-to-list 'load-path "~/.emacs.d/elisp/howm")
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
(setq howm-menu-refresh-after-save t)    ;; save 時にメニューを自動更新
(setq howm-list-title t)                 ;; タイトルを表示
;;(setq howm-view-summary-persistent nil)  ;; 一覧バッファを消す. C-u して [return] だと, 一覧を残す.
(setq howm-view-summary-persistent t)
(setq howm-view-split-horizontally t)
(setq howm-menu-schedule-days-before -3)  ;; 予定とToDoの表示数 ;; 今日から
(setq howm-menu-schedule-days 30)        ;; 予定とToDoの表示数 ;; 2週間後まで
(setq howm-menu-todo-num 99)

(setq howm-view-summary-persistent t)
(setq howm-view-split-horizontally t)

;; http://extra-vision.blogspot.com/2016/10/ripgrep-howm.html
(setq howm-view-use-grep t)
(setq howm-view-grep-command "rg")
(setq howm-view-grep-option "-nH --no-heading --color never")
(setq howm-view-grep-extended-option nil)
(setq howm-view-grep-fixed-option "-F")
(setq howm-view-grep-expr-option nil)
(setq howm-view-grep-file-stdin-option nil)


(defun my-save-and-kill-buffer ()
  (interactive)
  (save-buffer)
  (kill-buffer nil))
;(eval-after-load "howm-mode"
;  '(progn
;     (define-key howm-mode-map "\C-c\C-c" 'my-save-and-kill-buffer)))
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map (kbd "C-c C-c C-c") 'my-save-and-kill-buffer)))

(if (file-exists-p "/usr/bin/rg")
    (progn
      (setq howm-view-use-grep t)
      (setq howm-view-grep-command "rg")
      (setq howm-view-grep-option "-nH --no-heading --color never")
      (setq howm-view-grep-extended-option nil)
      (setq howm-view-grep-fixed-option "-F")
      (setq howm-view-grep-expr-option nil)
      (setq howm-view-grep-file-stdin-option nil)))


;file associations
;(defun markdown-text-mode ()
;  (markdown-mode)       ; major
;  (outline-minor-mode)  ; minor
;)
;(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-text-mode))


;; auto-save
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-exclude-regexps '("^/ssh:" "/sudo:" "/multi:" "plink:" "*scratch*"))
;;; Wroteのメッセージを抑制
(setq auto-save-buffers-enhanced-quiet-save-p t)
;;; *scratch*も ~/.emacs.d/scratch に自動保存
(setq auto-save-buffers-enhanced-save-scratch-buffer-to-file-p t)
(setq auto-save-buffers-enhanced-file-related-with-scratch-buffer
      (locate-user-emacs-file "scratch"))
(auto-save-buffers-enhanced t)


;; vc silent
;; シンボリックリンクの読み込みを許可
(setq vc-follow-symlinks t)
;; シンボリックリンク先のVCS内で更新が入った場合にバッファを自動更新
(setq auto-revert-check-vc-info t)


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
(require 'tramp)
(when (or (equal system-type 'w32) (equal system-type 'windows-nt)) 
  (setenv "PATH" (concat "c:/putty" ";" (getenv "PATH")))
  (setq tramp-default-method "plink"))
;;;; for android
(add-to-list 'tramp-connection-properties
             (list (regexp-quote "192.168.11.3") "remote-shell" "sh"))
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(add-to-list 'tramp-remote-path "/system/xbin")
;;(add-to-list 'tramp-remote-process-environment "TMPDIR=$HOME") ;; for non-rooted device
;; WSL SSH (use windows OpenSSH and config under windows home dir
(add-to-list 'tramp-methods
  '("wslssh"
    (tramp-login-program        "/mnt/c/Windows/System32/OpenSSH/ssh.exe")
    (tramp-login-args           (("%h")))
    (tramp-remote-shell         "/bin/sh")
    (tramp-remote-shell-args    ("-c"))
    (tramp-default-port         22)))

;; isearch
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup) ; isearch で skk のセットアップ
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup) ; isearch で skk のクリーンアップ
(setq skk-isearch-start-mode 'latin)                                            ; isearch で skk の初期状態

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))
(global-whitespace-mode 1)

;;;; gtags
;;(add-hook 'c-mode-common-hook
;;        (lambda ()
;;          (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
;;            (ggtags-mode 1))))
;;;; Enable helm-gtags-mode
;;(add-hook 'c-mode-hook 'helm-gtags-mode)
;;(add-hook 'c++-mode-hook 'helm-gtags-mode)
;;(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; company
;; https://qiita.com/sune2/items/b73037f9e85962f5afb7
;; https://qiita.com/kod314/items/3a31719db27a166d2ec1
(require 'company)
(with-eval-after-load 'company
  (global-company-mode)                  ;; 全バッファで有効にする
  ;;(add-hook 'c-mode-hook 'company-mode)
  ;;(add-hook 'c++-mode-hook 'company-mode)
  ;;(add-hook 'java-mode-hook 'company-mode)
  ;;(add-hook 'python-mode-hook 'company-mode)
  (setq company-idle-delay 0)            ;; デフォルトは0.5
  (setq company-minimum-prefix-length 2) ;; デフォルトは4
  (setq company-selection-wrap-around t) ;; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (define-key company-active-map (kbd "C-h") nil) ;; C-hはバックスペース割当のため無効化
  )

;; irony
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony) ; backend追加

;; flycheck
(global-flycheck-mode)


;; 連想リストの中身を文字列のリストに変更せず、変数そのままの構造を利用。
;; 複数のコンパイルオプションはスペースで区切る
(setq irony-lang-compile-option-alist
      (quote ((c++-mode . "c++ -std=c++11 -lstdc++")
              (c-mode . "c")
              (objc-mode . "objective-c"))))
;; アドバイスによって関数を再定義。
;; split-string によって文字列をスペース区切りでリストに変換
;; (24.4以降 新アドバイス使用)
(defun ad-irony--lang-compile-option ()
  (defvar irony-lang-compile-option-alist)
  (let ((it (cdr-safe (assq major-mode irony-lang-compile-option-alist))))
    (when it (append '("-x") (split-string it "\s")))))
(advice-add 'irony--lang-compile-option :override #'ad-irony--lang-compile-option)
;; (24.3以前 旧アドバイス使用)
(defadvice irony--lang-compile-option (around ad-irony--lang-compile-option activate)
  (defvar irony-lang-compile-option-alist)
  (let ((it (cdr-safe (assq major-mode irony-lang-compile-option-alist))))
    (when it (append '("-x") (split-string it "\s")))))

;; rtags
;; only run this if rtags is installed
(defun setup-flycheck-rtags ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil)
  )
(when (require 'rtags nil :noerror)
  (define-key c-mode-base-map (kbd "M-.")
    (function rtags-find-symbol-at-point))
  (define-key c-mode-base-map (kbd "M-,")
    (function rtags-find-references-at-point))
  ;; disable prelude's use of C-c r, as this is the rtags keyboard prefix
  ;;(define-key prelude-mode-map (kbd "C-c r") nil)
  ;; install standard rtags keybindings. Do M-. on the symbol below to
  ;; jump to definition and see the keybindings.
  (rtags-enable-standard-keybindings)
  ;; comment this out if you don't have or don't use helm
  (setq rtags-use-helm t)
  ;; company completion setup
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (rtags-start-process-unless-running)
  (push 'company-rtags company-backends)
  ;;(global-company-mode)
  ;;(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
  ;;;; use rtags flycheck mode -- clang warnings shown inline
  (require 'flycheck-rtags)
  ;;;; c-mode-common-hook is also called by c++-mode
  (add-hook 'c-mode-common-hook #'setup-flycheck-rtags)
  )
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              ;;(rtags-mode)
              )
            (when (derived-mode-p 'java-mode)
              (ggtags-mode 1))))
;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
;(add-hook 'c-mode-hook 'helm-gtags-mode)
;(add-hook 'c++-mode-hook 'helm-gtags-mode)
;(add-hook 'asm-mode-hook 'helm-gtags-mode)


;; markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(setq markdown-open-command "markdown_viewer.sh")

;; C/C++
(setq my-c-style
  '((c-comment-only-line-offset . 4)
    (c-cleanup-list . (scope-operator
                       empty-defun-braces
                       defun-close-semi))))
(add-hook 'c-mode-common-hook
  (lambda () (c-add-style "my-style" my-c-style t)))

;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "gnu")
             (setq indent-tabs-mode nil)       ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)     ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0))) ; 関数の引数リストの閉じ括弧はインデントしない

;; https://qiita.com/awakia/items/b836e7792be0a7c65fd4
;;; C系統,Pythonにて1行80文字を超えるとハイライト
(add-hook 'c-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
(add-hook 'c++-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
(add-hook 'python-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;;; Javaで1行100文字を超えるとハイライト
(add-hook 'java-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{100\\}\\(.*\\)$" 1 font-lock-warning-face t)))))


;; haskell
;;(add-to-list 'load-path "~/.emacs.d/elpa/haskell-mode-20170519.1555")
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal\\'" . haskell-cabal-mode))

(add-to-list 'interpreter-mode-alist '("runghc" . haskell-mode))     ;#!/usr/bin/env runghc 用
(add-to-list 'interpreter-mode-alist '("runhaskell" . haskell-mode)) ;#!/usr/bin/env runhaskell 用

;; ghc-mod (haskell)
;; obsorate されたぽいのでとりあえずコメントアウト
;; https://qiita.com/ryuukin/items/680769fb899985acec96
;;(add-to-list 'exec-path "~/.cabal/bin")  ; これをしてないと*Message*に"ghc-mod not found"と出て動かない
;;(add-to-list 'load-path "~/.emacs.d/elisp/ghc-mod")
;;(add-to-list 'load-path "/usr/share/ghc-mod/elisp")
;;(autoload 'ghc-init "ghc" nil t)
;;(add-hook 'haskell-mode-hook
;;          (lambda ()
;;            (ghc-init)
;;            (flymake-mode)))

;(setq haskell-program-name "/usr/bin/ghci")
;(add-hook 'haskell-mode-hook 'inf-haskell-mode) ;; enable
(defadvice inferior-haskell-load-file (after change-focus-after-load)
  "Change focus to GHCi window after C-c C-l command"
  (other-window 1))
(ad-activate 'inferior-haskell-load-file)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     ;;(define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "C-t") 'helm-gtags-pop-stack)
;(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
     ))

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

;;; 現在のファイルをIntelliJで開く
(defun open-by-intellij ()
  (interactive)
  (shell-command
   (format "/usr/bin/intellij-idea-ue-bundled-jre --line %d %s >/dev/null 2>&1"
           (line-number-at-pos)
           (buffer-file-name))))
  ;;(shell-command "open -a /usr/bin/intellij-idea-ue-bundled-jre"))

;; persps-mode
(setq persp-keymap-prefix (kbd "C-c p")) ;prefix
(setq persp-add-on-switch-or-display t) ;バッファを切り替えたら見えるようにする
(persp-mode 1)
(defun persp-register-buffers-on-create ()
  (interactive)
  (dolist (bufname (condition-case _
                       (helm-comp-read
                        "Buffers: "
                        (mapcar 'buffer-name (buffer-list))
                        :must-match t
                        :marked-candidates t)
                     (quit nil)))
    (persp-add-buffer (get-buffer bufname))))
(add-hook 'persp-activated-hook 'persp-register-buffers-on-create)

;; desktop
;;(require 'desktop)
;;(setq desktop-path (list "~/.emacs_desktop"))
;;(desktop-save-mode t)


;; kmb
(require 'kmb)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (kmb flycheck-rtags flycheck-irony flycheck-haskell company company-irony-c-headers flycheck company-rtags company-lsp howm ghc markdown-mode helm-gtags ggtags exec-path-from-shell cdb ccc)))
 '(safe-local-variable-values (quote ((encoding . utf-8)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(howm-reminder-normal-face ((t (:foreground "deep sky blue")))))
