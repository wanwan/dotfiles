;;; package-utils-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "package-utils" "package-utils.el" (24003 49470
;;;;;;  195659 921000))
;;; Generated autoloads from package-utils.el

(autoload 'package-utils-list-upgrades "package-utils" "\
List all packages that can be upgraded.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

\(fn &optional NO-FETCH)" t nil)

(autoload 'package-utils-upgrade-all "package-utils" "\
Upgrade all packages that can be upgraded.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

\(fn &optional NO-FETCH)" t nil)

(autoload 'package-utils-upgrade-all-no-fetch "package-utils" "\
Upgrade all packages that can be upgraded without calling `package-refresh-contents' first.

\(fn)" t nil)

(autoload 'package-utils-upgrade-all-and-quit "package-utils" "\
Upgrade all packages that can be upgraded, then quit emacs.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

\(fn &optional NO-FETCH)" t nil)

(autoload 'package-utils-upgrade-all-and-restart "package-utils" "\
Upgrade all packages that can be upgraded, then restart emacs.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

\(fn &optional NO-FETCH)" t nil)

(autoload 'package-utils-upgrade-by-name "package-utils" "\
Upgrade the package NAME.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

\(fn NAME &optional NO-FETCH)" t nil)

(autoload 'package-utils-upgrade-by-name-no-fetch "package-utils" "\
Upgrade the package NAME, without calling `package-refresh-contents' first.

\(fn NAME)" t nil)

(autoload 'package-utils-remove-by-name "package-utils" "\
Uninstall the package NAME.

\(fn NAME)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; package-utils-autoloads.el ends here
