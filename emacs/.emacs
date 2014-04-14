;;load path set to folder ~/emacs for .el files
(setq load-path (cons "~/emacs" load-path))

;; turn on paren matching
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; no tabs, just spaces
(setq-default indent-tabs-mode nil)

;; auto indent with RETURN
(define-key global-map (kbd "RET") 'newline-and-indent)

;;will make the last line end in a carriage return.
(setq require-final-newline t)

;; Use "y or n" answers instead of full words "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight mark
(transient-mark-mode t)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;;; Tabbing stuff
(require 'tabbar)
(tabbar-mode) ;comment out this line to start without the tab on top
(global-set-key [(control shift h)] 'tabbar-mode)
(global-set-key [(control shift up)] 'tabbar-backward-group)
(global-set-key [(control shift down)] 'tabbar-forward-group)
(global-set-key [(control shift left)] 'tabbar-backward)
(global-set-key [(control shift right)] 'tabbar-forward)
(global-set-key [(control next)] 'tabbar-forward-tab)
(global-set-key [(control prior)] 'tabbar-backward-tab)

(setq js-indent-level 2)
;(global-set-key [(control tab)] 'tabbar-last-selected-tab)

(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

(defun json-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)
    )
  )

;---Save the State of Emacs to be Loaded next time it is started---
(defun gk-state-saver ()
;;Save names and cursor positions of all loaded files in ".emacs.files"
  (interactive)
  (setq fname (format "~/.emacs.files" gk-startdir))
  (cond 
   ((buffer-file-name)
    (setq currentbuffer (buffer-name)))
   (t
    (setq currentbuffer nil)))
  (cond
   ((y-or-n-p (format "Save state to %s? " fname))
	(switch-to-buffer "*state-saver*")
	(kill-buffer "*state-saver*")
	(switch-to-buffer "*state-saver*")
	(setq bl (buffer-list))
	(while bl
	  (setq buffer (car bl))
	  (setq file (buffer-file-name buffer))
	  (cond 
	   (file 
		(insert "(find-file \"" file "\")\n")
		(switch-to-buffer buffer)
		(setq mypoint (point))
		(switch-to-buffer "*state-saver*")
		(insert (format "(goto-char %d)\n" mypoint))))
	  (setq bl (cdr bl)))
	(cond
	 (currentbuffer
	  (insert (format "(switch-to-buffer \"%s\")\n" currentbuffer))))
	(set-visited-file-name fname)
	(save-buffer)
	(kill-buffer "~/.emacs.files")
	(cond
	 (currentbuffer
	  (switch-to-buffer currentbuffer))))))


;--- Save state when killing emacs ----------
(add-hook 
 'kill-emacs-hook
 '(lambda () 
    (gk-state-saver)))

;--- Remember from where emacs was started --
(defvar gk-startdir default-directory)
(message "state save directory is: %s" gk-startdir)
;(sleep-for 1)

;--- Load files from .emacs.files -----------
(cond
 ((file-exists-p "~/.emacs.files")
  (load-file "~/.emacs.files")))

(add-to-list 'load-path "~/emacs/ruby-mode")
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))

(require 'whitespace)
(require 'haml-mode)
(require 'slim-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(require 'markdown-mode)
;(require 'js2-mode)
;(autoload 'js2-mode "js2-mode" "Major mode for editing Javascript code" t)
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(require 'suggbind)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
