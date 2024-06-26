;;; howm-lang-ja.el --- Wiki-like note-taking tool
;;; -*- Coding: iso-2022-7bit -*-
;;; Copyright (C) 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2015, 2016, 2017
;;;   HIRAOKA Kazuyuki <khi@users.sourceforge.jp>
;;; $Id: howm-lang-ja.el,v 1.11 2011-12-31 15:07:29 hira Exp $
;;;
;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 1, or (at your option)
;;; any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; The GNU General Public License is available by anonymouse ftp from
;;; prep.ai.mit.edu in pub/gnu/COPYING.  Alternately, you can write to
;;; the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
;;; USA.
;;--------------------------------------------------------------------

(require 'howm-common)

(defvar howm-day-of-week-ja '("$BF|(B" "$B7n(B" "$B2P(B" "$B?e(B" "$BLZ(B" "$B6b(B" "$BEZ(B"))

(defvar howm-menu-command-table-ja
  `(
    ("[$BB.5-(B]" howm-remember previous)
    ("[$B?75,(B]" (lambda () (howm-create ,howm-menu-action-arg)))
    ("[$BDI2C(B]" (lambda () (howm-create-here ,howm-menu-action-arg)))
    ("[$BJ#@=(B]" howm-dup)
    ("[$B99?7(B]" howm-initialize-buffer previous)
    ("[$B@55,(B]" howm-list-grep)
    ("[$B8GDj(B]" howm-list-grep-fixed)
    ("[roma]" howm-list-migemo)
    ("[$B:#F|(B]" howm-find-today)
    ("[$B:rF|(B]" howm-find-yesterday)
    ("[$B0lMw(B]" howm-list-all)
    ("[$B:G6a(B]" howm-list-recent)
    ("[$BA08e(B]" howm-list-around)
    ("[$BM=Dj(B]" howm-list-schedule)
    ("[$B%PFb(B]" (lambda () (call-interactively 'howm-occur)) previous)
    ("[$BA4%P(B]" (lambda () (howm-list-buffers ,howm-menu-action-arg)))
    ("[mark]" howm-list-mark-ring previous)
    ("[$BMzNr(B]" howm-history)
    ("[$BBj",(B]" howm-keyword-to-kill-ring)
    ("[$BL>",(B]" (lambda () (howm-keyword-to-kill-ring t)))
    ("[$B80"-(B]" howm-insert-keyword previous)
    ("[$BF|"-(B]" howm-insert-date previous)
    ("[$B;~"-(B]" howm-insert-dtime previous)
    ("[Todo]" howm-list-todo)
    ("[$BA4>C(B]" howm-kill-all)
    ("[$B6/@)A4>C(B]" (lambda () (interactive) (howm-kill-all t)))
    ("[menu $BJT=8(B]" howm-menu-edit current)
    ("[menu $B99?7(B]" howm-menu-refresh current)
    ("[$B@_Dj(B]" (lambda () (customize-group 'howm)))
    ("[$B?lJb(B]" howm-random-walk previous)
    ))

(provide 'howm-lang-ja)

;;; howm-lang-ja.el ends here
