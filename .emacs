;;load path set to folder ~/emacs for .el files
(setq load-path (cons "~/emacs" load-path))

;; turn on paren matching
    (show-paren-mode t)
    (setq show-paren-style 'mixed)

;;will make the last line end in a carriage return.
(setq require-final-newline t)

(require 'haml-mode)
(require 'whitespace)

