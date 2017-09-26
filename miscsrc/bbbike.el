;;; bbbike.el --- editing BBBike .bbd files in GNU Emacs

;; Copyright (C) 1997-2014,2016,2017 Slaven Rezic

;; To use this major mode, put something like:
;;
;;     (setq auto-mode-alist (append (list (cons "\\(-orig\\|\\.bbd\\)$" 'bbbike-mode))
;;     		                     auto-mode-alist))
;;
;; to your .emacs file

(setq bbbike-el-file-name load-file-name)

(defvar bbbike-font-lock-trailing-whitespace-face 'bbbike-font-lock-trailing-whitespace-face
  "Face name to use for highlightning trailing whitespace.")
(defface bbbike-font-lock-trailing-whitespace-face
  '((((class color) (min-colors 88)) (:foreground "Red1" :weight bold :underline t))
    (((class color) (min-colors 16)) (:foreground "Red1" :weight bold :underline t))
    (((class color) (min-colors 8)) (:foreground "red" :underline t))
    (t (:underline t)))
  "Font Lock mode face used to highlight trailing whitespace."
  :group 'font-lock-faces)
(defface bbbike-button
  '((t (:underline t)))
  "Face for buttons without changing foreground color")

(defvar bbbike-font-lock-keywords
  '(("\\( +\\)\t" (1 bbbike-font-lock-trailing-whitespace-face)) ;; trailing whitespace after names. works only partially, but at least it disturbs the fontification
    ("^\\(#[^:].*\\)" (1 font-lock-comment-face))                 ;; comments
    ("\\(#:.*\\)"  (1 font-lock-warning-face))	            ;; directives
    ("^\\([^\t\n]+\\)" (1 font-lock-constant-face))           ;; name
    ("^[^#][^\t\n:]+: \\([^\t\n]+\\)" (1 font-lock-string-face t)) ;; colon separated part of name
    ("\t\\([^ \n]+ \\)" (1 font-lock-keyword-face))            ;; category
    ("\\([-+]?[0-9.]+,[-+]?[0-9.]+\\)" (1 font-lock-type-face)) ;; coords
    ))

(defconst bbbike-font-lock-defaults
  '(bbbike-font-lock-keywords t nil nil nil (font-lock-multiline . nil)))

(defadvice switch-to-buffer (after bbbike-revert last act)
  "Make sure bbbike buffers are up-to-date"
  (if (and (eq major-mode 'bbbike-mode)
	   (not (buffer-modified-p)))
      (revert-buffer)))

;;; reverses the current region
(defun bbbike-reverse-street ()
  (interactive)
  (let (reg tokens i)
    (setq reg (buffer-substring (region-beginning) (region-end)))
    (setq tokens (reverse (split-string reg)))
    (save-excursion
      (goto-char (region-end))
      (while tokens
	(insert (car tokens))
	(setq tokens (cdr tokens))
	(if tokens
	    (insert " "))
	)
      )
      (delete-region (region-beginning) (region-end))
    ))

(defun bbbike-split-street ()
  (interactive)
  (let (begin-line-pos end-name-cat-pos begin-coord-pos end-coord-pos name-cat coord)
    (save-excursion
      (beginning-of-line)
      (setq begin-line-pos (point)))
    (save-excursion
      (search-forward-regexp "\\($\\| \\)")
      (if (string= (buffer-substring (match-beginning 0) (match-end 0)) "")
	  (error "Cannot split at end"))
      (setq end-coord-pos (1- (match-end 0))))
    (save-excursion
      (search-backward-regexp " " begin-line-pos)
      (setq begin-coord-pos (1+ (match-beginning 0))))
    (setq coord (buffer-substring begin-coord-pos end-coord-pos))
    (save-excursion
      (beginning-of-line)
      (search-forward-regexp "\t[^ ]+ ")
      (setq end-name-cat-pos (match-end 0))
      (setq name-cat (buffer-substring begin-line-pos end-name-cat-pos)))
    (save-excursion
      (goto-char end-coord-pos)
      (insert "\n")
      (insert name-cat)
      (insert coord)
      )
    ))

(defun bbbike-split-directions ()
  (interactive)
  (shell-command-on-region (save-excursion (beginning-of-line) (point))
			   (save-excursion (end-of-line) (point))
			   "perl -e '$in=<>; if (($name,$catfw,$catbw,$coord)=$in=~m{^([^\\t]*)\\t([^;]*);([^ ]*) (.*)}) { print qq{$name\\t$catfw; $coord\\n$name\\t$catbw; } . join(qq{ },reverse(split / /, $coord)) } else { print $in }'"
			   nil t)
  )

(defun bbbike-join-street ()
  (interactive)
  (let (match-coord other-coord
	match-cat other-cat
	match-name other-name)
    (save-excursion
      (if (or (save-excursion (search-forward-regexp "\\=[^ ]+$" nil t)) ;; are we on the last coord of the line?
	      (save-excursion (search-forward-regexp "\\=$" nil t)))
	  (progn
	    (message (format "%s" (point)))
	    (beginning-of-line)
	    (if (not (search-forward-regexp "^\\([^\t]*\\)\t\\([^ ]+\\).* \\([^ ]+\\)$"))
	      (error "Cannot parse this line as valid bbd data line"))
	    (setq match-name (buffer-substring (match-beginning 1) (match-end 1)))
	    (setq match-cat (buffer-substring (match-beginning 2) (match-end 2)))
	    (setq match-coord (buffer-substring (match-beginning 3) (match-end 3)))
	    (end-of-line)
	    (goto-char (1+ (point)))
	    (if (= (point) (point-max))
		(error "We are one the last line"))
	    (if (string= (buffer-substring (point) (1+ (point))) "#")
		(error "Next line is a comment line, no join possible"))
	    (if (not (search-forward-regexp "^\\([^\t]*\\)\t\\([^ ]+\\) \\([^ ]+\\) "))
		(error "Next line does not look like a valid bbd data line or only has one coordinate at all"))
	    (setq other-name (buffer-substring (match-beginning 1) (match-end 1)))
	    (if (not (string= match-name other-name)) ;; XXX ask the user which one to choose!
		(error "Name on this line and name on next line do not match"))
	    (setq other-cat (buffer-substring (match-beginning 2) (match-end 2)))
	    (if (not (string= match-cat other-cat)) ;; XXX ask the user which one to choose!
		(error "Category on this line and category on next line do not match"))
	    (setq other-coord (buffer-substring (match-beginning 3) (match-end 3)))
	    (if (not (string= match-coord other-coord))
		(error "Last coordinate on this line and first coordinate on next line do not match"))
	    (delete-region (match-beginning 0) (match-end 0))  ;; XXX maybe replace name and/or cat if user chose the 2nd name/cat
	    (insert " ")
	    (delete-region (1- (1- (point))) (1- (point))))
	(error "no support for joining by first coordinate, must be on last coordinate")
	;; are we on the first coord of the line? no -> error message
	;;   is there a prev line, and non-comment? no -> error message
	;;   is the last coord of the prev line the same? no -> error message
	;;   is the category/name of the prev line the same? see above
	;;   delete name, cat and first coord of this line, join lines, maybe replace name and/or cat
	;;   ready!
	)
      )))

(defun bbbike-search-x-selection ()
  (interactive)
  (let ((sel (bbbike--get-x-selection)))
    (if sel
	(let ((rx sel)
	      is-coords)
	  (if (string-match "^\\(CHANGED\\|NEW\\|REMOVED\\)\t.*\t\\([^\t]+\\)\t\\(INUSE\\)?$" rx)
	      (setq rx (concat "#:[ ]*source_id:?[ ]*" (substring rx (match-beginning 2) (match-end 2))))
	    (if (string-match " " rx)
		(progn
		  (setq rev-rx-list (reverse (split-string rx " ")))
		  (setq rev-rx (pop rev-rx-list))
		  (while rev-rx-list
		    (setq rev-rx (concat rev-rx " " (pop rev-rx-list))))
		  (setq rx (concat "\\(" rx "\\|" rev-rx "\\)"))
		  )
	      (setq rx (concat "\\(" rx "\\)")))
	    (setq rx (concat "\\(\t\\| \\)" rx "\\( \\|$\\)"))
	    (setq is-coords t)
	    )
	  (message rx)

	  (let ((search-state 'begin)
		(end-length)
		(start-pos))
	    (while (not (eq search-state 'found))
	      (if (eq search-state 'again)
		  (goto-char (point-min)))
	      (if (not (search-forward-regexp rx
					      nil
					      (eq search-state 'begin)))
		  (setq search-state 'again)
		(setq search-state 'found)
		(if is-coords
		    (progn
		      (setq start-pos (- (point) (length sel)
					 (- (match-end 3) (match-beginning 3))
					 ))
		      (set-mark (+ start-pos (length sel)))
		      (goto-char start-pos)))
		)
	      )))
      (error "No X selection"))))

(defun bbbike--get-x-selection ()
  (if (fboundp 'w32-get-clipboard-data)
      (w32-get-clipboard-data)
    (x-selection)))

(defun bbbike-toggle-tabular-view ()
  (interactive)
  (if truncate-lines
      (progn
	(setq truncate-lines nil)
	(setq tab-width 8))
    (setq truncate-lines t)
    (setq tab-width 60))
  (recenter)
  )

(defun bbbike-center-point ()
  (interactive)
  (let (begin-coord-pos end-coord-pos)
    (save-excursion
      (search-forward-regexp "\\($\\| \\)")
      (if (string= (buffer-substring (match-beginning 0) (match-end 0)) "")
	  (setq end-coord-pos (match-end 0))
	(setq end-coord-pos (1- (match-end 0)))))
    (save-excursion
      (search-backward-regexp " ")
      (setq begin-coord-pos (1+ (match-beginning 0))))
    (setq coord (buffer-substring begin-coord-pos end-coord-pos))
    (setq bbbikeclient-path (concat (bbbike-rootdir) "/bbbikeclient"))
    (setq bbbikeclient-command (concat bbbikeclient-path
				       "  -centerc "
				       coord
				       " &"))
    (message bbbikeclient-command)
    (shell-command bbbikeclient-command nil nil)
    ))

(defun bbbike-rootdir ()
  (string-match "^\\(.*\\)/[^/]+/[^/]+$" bbbike-el-file-name)
  (substring bbbike-el-file-name (match-beginning 1) (match-end 1))
  )

(defvar bbbike-mode-map nil "Keymap for BBBike bbd mode.")
(if bbbike-mode-map
    nil
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-c\C-r" 'bbbike-reverse-street)
    (define-key map "\C-c\C-s" 'bbbike-search-x-selection)
    (define-key map "\C-c\C-t" 'bbbike-toggle-tabular-view)
    (define-key map "\C-c\C-c" 'comment-region)
    (define-key map "\C-c|"    'bbbike-split-street)
    (define-key map "\C-c\C-j" 'bbbike-join-street)
    (define-key map "\C-cj"    'bbbike-join-street)
    (define-key map "\C-c."    'bbbike-update-now)
    (define-key map "\C-c\C-m" 'bbbike-center-point)
    (setq bbbike-mode-map map)))

(defvar bbbike-syntax-table nil "Syntax table for BBBike bbd mode.")
(if bbbike-syntax-table
    nil
  (setq bbbike-syntax-table (make-syntax-table))
  (modify-syntax-entry ?#  "<" bbbike-syntax-table)
  (modify-syntax-entry ?\n ">" bbbike-syntax-table)
  (modify-syntax-entry ?\" "." bbbike-syntax-table)
  )

(defun bbbike-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map bbbike-mode-map)
  (setq mode-name "BBBike"
	major-mode 'bbbike-mode)
  (set-syntax-table bbbike-syntax-table)

  (if (string-match "^2[01]\\." emacs-version)
      (progn
	(set (make-local-variable 'font-lock-keyword-only) t)
	(set (make-local-variable 'font-lock-keywords) bbbike-font-lock-keywords))
    (set (make-local-variable 'font-lock-defaults) bbbike-font-lock-defaults)
    (set (make-local-variable 'comment-use-syntax) nil)
    (set (make-local-variable 'comment-start) "#")
    (set (make-local-variable 'comment-padding) " "))

  (setq bbbike-imenu-generic-expression '((nil "^#: \\(append_comment\\|section\\):? *\\(.*\\) +vvv+" 2)))
  (setq imenu-generic-expression bbbike-imenu-generic-expression)

  ;; Do not let emacs asking if another process (i.e. bbbike itself) changed
  ;; a bbd file:
  (make-local-variable 'revert-without-query)
  (setq revert-without-query (list (buffer-file-name)))

  (bbbike-set-grep-command)

  ;; In emacs 22, tab is something else
  (local-set-key "\t" 'self-insert-command)

  (bbbike-create-buttons)

  (run-hooks 'bbbike-mode-hook)
  )

(defun bbbike-set-grep-command ()
  (set (make-local-variable 'grep-command)
       (let ((is-windowsnt (and (or (string-match "i386-.*-windows.*" system-configuration)
				    (string-match "i386-.*-nt" system-configuration))
				t)))
	 (if (not is-windowsnt)
	     (concat (if (string-match "csh" (getenv "SHELL"))
			 "" "2>/dev/null ")
		     "grep -ins *-orig *.coords.data -e ")
	   "grep -ni "))))

(fset 'bbbike-cons25-format-answer
   "\C-[[H\C-sCc:\C-a\C-@\C-[[B\C-w\C-s--text\C-[[B\C-a\C-@\C-s\\$strname\C-u10\C-[[D\C-w\C-[[C\C-[[C\C-u11\C-d\C-a\C-s\"\C-[[D\C-@\C-e\C-r\"\C-[[C\C-u\370shell-command-on-region\C-mperl -e 'print eval <>'\C-m\C-e\C-?\C-[[B\C-a\C-@\C-[[F\C-r^--\C-[[A\C-w\C-[[A\C-[[B\C-m\C-[[H\C-ssubject.* by \C-@\C-s \C-[[D\C-[w\C-[[F\C-r^--\C-[[AHallo \C-y,\C-m\C-m\C-mGru\337,\C-m    Slaven\C-m\C-[[A\C-[[A\C-[[A")

(condition-case ()
    (load "recode")
  (error ""))
(fset 'bbbike-format-answer
   [home ?\C-s ?C ?c ?: ?\C-a ?\C-k ?\C-k ?\C-s ?- ?- ?t ?e ?x ?t down ?\C-a ?\C-  ?\C-s ?s ?t ?r ?n ?a ?m ?e ?\C-s right right right ?\C-w ?> ?  ?\C-s ?\" left ?\C-  ?\C-s ?\C-s ?\C-s ?\M-x ?r ?e ?c ?o ?d ?e ?- ?p ?e ?r ?l ?s ?t ?r ?i ?n ?g ?- ?t ?o ?- ?l ?a ?t ?i ?n ?1 return ?\C-a ?\C-e backspace down ?\C-a ?\C-  ?\C-s ?^ ?- ?- ?  up up ?\C-x ?\C-x ?\C-w return ?H ?a ?l ?l ?o ?  home ?\C-s ?S ?u ?b ?j ?e ?c ?t ?. ?* ?b ?y right ?\C-  ?\C-e escape ?w ?\C-s ?H ?a ?l ?l ?o right ?\C-y ?, return return ?d ?a ?n ?k ?e ?  ?f ?� ?r ?  ?d ?e ?i ?n ?e ?n ?  ?E ?i ?n ?t ?r ?a ?g ?. ?  ?D ?i ?e ?  ?S ?t ?r ?a ?� ?e ?  ?w ?i ?r ?d ?  ?d ?e ?m ?n ?� ?c ?h ?s ?t ?  ?b ?e ?i ?  ?B ?B ?B ?i ?k ?e ?  ?v ?e ?r ?f ?� ?g ?b ?a ?r ?  ?s ?e ?i ?n ?. return return ?G ?r ?u ?� ?, return tab ?S ?l ?a ?v ?e ?n return])

(defun gpsman-wpt-remove-irrelevant ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (delete-matching-lines "symbol=summit")
    (delete-matching-lines "symbol=geocache")))

;; (setq last-kbd-macro
;;    [?\C-s ?\" left ?\C-  ?\C-s ?\C-s ?\C-s ?\M-x ?r ?e ?c ?o ?d ?e ?- ?p ?e ?r ?l ?s ?t ?r ?i ?n ?g ?- ?t ?o ?- ?l ?a ?t ?i ?n ?1 return ?\C-a])


;; (setq last-kbd-macro
;;    [?\C-s ?" left ?\C-  ?\C-s ?\C-s ?\C-s ?\M-x ?r ?e ?c ?o ?d ?e ?- ?p ?e ?r ?l ?s ?t ?r ?i ?n ?g ?- ?t ?o ?- ?l ?a ?t ?i ?n ?1 return ?\C-a])

(defun bbbike-google-map ()
  "Open a browse with my googlemap implementation for the coordinates under cursor"
  (interactive)
  (let ((coords (buffer-substring (region-beginning) (region-end))))
    (setq coords (replace-regexp-in-string " " "!" coords))
    (browse-url (concat "http://bbbike.de/cgi-bin/bbbikegooglemap.cgi?coords=" coords)))
  )

(defun bbbike-now ()
  "Insert the current date in bbbike-temp-blockings.pl"
  (interactive)
  (let ((now (format "%s" (float-time))))
    (if (not (string-match "^\\([0-9]+\\)" now) )
	(error (concat "cannot match " now)))
    (setq now (substring now (match-beginning 1) (match-end 1)))
    (insert now)
    ))

(defun bbbike-update-now ()
  "Update the current date in bbd files (e.g. in last_checked directives)"
  (interactive)
  (let ((now-iso-date (format-time-string "%Y-%m-%d" (current-time)))
	begin-iso-date-pos
	end-iso-date-pos
	(currpos (point)))
    (save-excursion
      (search-backward-regexp "\\(^\\| \\)")
      (setq begin-iso-date-pos (1+ (match-beginning 0)))
      )
    (save-excursion
      (search-forward-regexp "\\( \\|$\\)")
      (setq end-iso-date-pos (match-beginning 0)))
    (if (not (string-match "^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]$" (buffer-substring begin-iso-date-pos end-iso-date-pos)))
	(error (concat "This does not look like an ISO date "
		       (buffer-substring begin-iso-date-pos end-iso-date-pos))))
    (save-excursion
      (goto-char begin-iso-date-pos)
      (delete-region begin-iso-date-pos end-iso-date-pos)
      (insert now-iso-date))

    (goto-char currpos) ; this works because the length of a ISO date is constant (at least for a long time ;-)
    )
  )

(defun bbbike-view-cached-url (&optional url)
  "View the URL under cursor, assuming it's cached in bbbike-aux"
  (interactive)
  (if (not url)
      (setq url (bbbike--get-url-under-cursor)))
  (let ((bbbike-aux-dir (concat (bbbike-rootdir) "-aux")))
    (call-process-shell-command (concat bbbike-aux-dir "/downloads/view -show-best '" url "'"))))

(defun bbbike-view-remote-url (&optional url)
  "View the URL under cursor remotely"
  (interactive)
  (if (not url)
      (setq url (bbbike--get-url-under-cursor)))
  (browse-url url))

;;; XXX actually the documented behavior is NYI
;;; XXX currently bbbike-view-cached-url is almost always called
(defun bbbike-view-url ()
  "View the URL under cursor, either the cached version (preferred), or the remote version"
  (interactive)
  (let ((url (bbbike--get-url-under-cursor)))
    (if (string-match "^http://www.dafmap.de/" url)
	(bbbike-view-remote-url url)
      (bbbike-view-cached-url url))))

(defun bbbike--get-url-under-cursor ()
  (let (begin-current-line-pos end-current-line-pos current-line)
    (save-excursion
      (search-backward-regexp "\\(^\\| \\)")
      (setq begin-current-line-pos (1+ (match-beginning 0))))
    (save-excursion
      (search-forward-regexp "\\( \\|$\\)")
      (setq end-current-line-pos (match-beginning 0)))
    (setq current-line (buffer-substring begin-current-line-pos end-current-line-pos))
    (if (not (string-match "\\(https?://[^ ]+\\)" current-line))
	(error (concat "This does not look like a http/https URL "
		       (buffer-substring begin-url-pos end-url-pos))))
    (substring current-line (match-beginning 1) (match-end 1))))

(defun bbbike-update-osm-watch ()
  (interactive)
  (let ((sel (bbbike--get-x-selection)))
    (if (string-match "\\+<\\(way\\|node\\|relation\\).* id=\"\\([0-9]+\\)\".* version=\"\\([0-9]+\\)\"" sel)
	(let* ((elemtype (substring sel (match-beginning 1) (match-end 1)))
	       (elemid (substring sel (match-beginning 2) (match-end 2)))
	       (elemversion (substring sel (match-beginning 3) (match-end 3)))
	       (bbbike-datadir (concat (bbbike-rootdir) "/data"))
	       (grepcmd (concat "cd " bbbike-datadir " && grep -ns '^#: osm_watch: " elemtype " id=\"" elemid "\"' *-orig temp_blockings/bbbike-temp-blockings.pl"))
	       (tempbuf "*bbbike update osm watch*"))
	  (condition-case nil
	      (kill-buffer tempbuf)
	    (error ""))
	  (if (> (call-process "/bin/sh" nil tempbuf nil "-c" grepcmd) 0)
	      (error "Command %s failed" grepcmd)
	    (set-buffer tempbuf)
	    (goto-char (point-min))
	    (if (not (search-forward-regexp "^\\([^:]+\\):\\([0-9]+\\)"))
		(error "Strange: can't find a grep result in " tempbuf)
	      (let ((file (buffer-substring (match-beginning 1) (match-end 1)))
		    (line (string-to-int (buffer-substring (match-beginning 2) (match-end 2)))))
		(find-file (concat bbbike-datadir "/" file))
		(goto-line line)
		(if (not (search-forward-regexp "version=\"" (line-end-position)))
		    (error "Cannot find osm watch item in file")
		  (let ((answer (read-char (format "Set version to %s? (y/n) " elemversion))))
		    (if (not (string= (char-to-string answer) "y"))
			(error "OK, won't change version")
		      (let ((beg-of-version (point))
			    (end-of-version (save-excursion
					      (search-forward-regexp "[^0-9]" (line-end-position) nil)
					      (1- (point)))))
			(delete-region beg-of-version end-of-version)
			(insert elemversion)
			))))))
	    )
	  )
      (error "No X selection or X selection does not contain a way/node/relation line"))))

(defun bbbike-insert-osm-watch ()
  (interactive)
  (let ((sel (bbbike--get-x-selection)))
    (if (string-match "<\\(way\\|node\\|relation\\).* \\(id=\"[0-9]+\"\\).* \\(version=\"[0-9]+\"\\)" sel)
	(let ((elemtype (substring sel (match-beginning 1) (match-end 1)))
	      (elemid (substring sel (match-beginning 2) (match-end 2)))
	      (elemversion (substring sel (match-beginning 3) (match-end 3))))
	  (beginning-of-line)
	  (insert (concat "#: osm_watch: " elemtype " " elemid " " elemversion "\n")))
      (error "No X selection or X selection does not contain a way/node/relation line"))))

(setq bbbike-next-check-id-regexp "^#:[ ]*\\(next_check_id\\):?[ ]*\\([^ \n]+\\)")

(defun bbbike-grep ()
  (interactive)
  (let (search-key search-val dirop)
    (save-excursion
      (beginning-of-line)
      (if (looking-at bbbike-next-check-id-regexp)
	  (progn
	    (setq search-key (buffer-substring (match-beginning 1) (match-end 1)))
	    (setq search-val (buffer-substring (match-beginning 2) (match-end 2))))))
    (if (not search-val)
	(error "Can't find anything to grep for"))
    (if (string-match "/temp_blockings/" buffer-file-name)
	(setq dirop "../")
      (setq dirop ""))
    (if search-key
	(grep (concat "2>/dev/null grep -ins " dirop "*-orig " dirop "*.coords.data " dirop "temp_blockings/bbbike-temp-blockings.pl -e '^#:[ ]*" search-key ".*" search-val "'")))))

(defun bbbike-grep-button (button)
  (bbbike-grep))

(define-button-type 'bbbike-grep-button
  'action 'bbbike-grep-button
  'follow-link t
  'face 'bbbike-button
  'help-echo "Click button to grep for the same next_check_id")

(defun bbbike-view-url-button (button)
  (bbbike-view-url))

(define-button-type 'bbbike-url-button
  'action 'bbbike-view-url-button
  'follow-link t
  'face 'bbbike-button
  'help-echo "Click button to browse (cached) URL")

(defun bbbike-osm-button (button)
  (browse-url (concat "http://www.openstreetmap.org/" (button-get button :osmid))))

(define-button-type 'bbbike-osm-button
  'action 'bbbike-osm-button
  'follow-link t
  'face 'bbbike-button
  'help-echo "Click button to show OSM element")

(defun bbbike-create-buttons ()
  (save-excursion
    (goto-char (point-min))
    (while (search-forward-regexp bbbike-next-check-id-regexp nil t)
      (let ((next-check-id-val (buffer-substring (match-beginning 2) (match-end 2))))
	(if (> (length next-check-id-val) 3)
	    (setq next-check-id-val (substring next-check-id-val 0 3)))
	(if (not (string= next-check-id-val "^^^"))
	    (make-button (match-beginning 1) (match-end 2) :type 'bbbike-grep-button)))
      ))

  (save-excursion
    (goto-char (point-min))
    (while (search-forward-regexp "^#:[ ]*by:?[ ]*\\(http[^ \n]+\\)" nil t)
      (make-button (match-beginning 1) (match-end 1) :type 'bbbike-url-button)))

  (save-excursion
    (goto-char (point-min))
    (while (search-forward-regexp "^#:[ ]*\\(osm_watch\\):?[ ]*\\(way\\|node\\|relation\\)[ ]+id=\"\\([0-9]+\\)\"" nil t)
      (make-button (match-beginning 1) (match-end 1)
		   :type 'bbbike-osm-button
		   :osmid (concat (buffer-substring (match-beginning 2) (match-end 2)) "/" (buffer-substring (match-beginning 3) (match-end 3)))
		   )))

  )
      
(provide 'bbbike-mode)
