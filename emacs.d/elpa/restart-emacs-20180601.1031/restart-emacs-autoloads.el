;;; restart-emacs-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "restart-emacs" "restart-emacs.el" (24003 49469
;;;;;;  307659 925000))
;;; Generated autoloads from restart-emacs.el

(autoload 'restart-emacs-handle-command-line-args "restart-emacs" "\
Handle the --restart-emacs-desktop command line argument.

The value of the argument is the desktop file from which the frames should be
restored.  IGNORED are ignored.

\(fn &rest IGNORED)" nil nil)

(add-to-list 'command-switch-alist '("--restart-emacs-desktop" . restart-emacs-handle-command-line-args))

(autoload 'restart-emacs "restart-emacs" "\
Restart Emacs.

When called interactively ARGS is interpreted as follows

- with a single `universal-argument' (`C-u') Emacs is restarted
  with `--debug-init' flag
- with two `universal-argument' (`C-u') Emacs is restarted with
  `-Q' flag
- with three `universal-argument' (`C-u') the user prompted for
  the arguments

When called non-interactively ARGS should be a list of arguments
with which Emacs should be restarted.

\(fn &optional ARGS)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; restart-emacs-autoloads.el ends here
