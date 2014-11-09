; normalize
(delete-selection-mode t)
(add-hook 'before-save-hook '(lambda nil (untabify 0 (point-max))))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq require-final-newline t)
(global-font-lock-mode 1)
(setq make-backup-files nil)
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(menu-bar-mode 0)
;; use spaces for tabs
(setq-default indent-tabs-mode nil)
(setq inhibit-default-init t)

;sfang

;; Do not use the iconifiy shortcut
;(global-unset-key [C-z] nil)

;; Need to be able to jump around
(global-set-key [M-g] 'goto-line)

;; Make control-tab switch windows
;(global-set-key [C-tab] (lambda () (interactive) (other-window 1)))
;(global-set-key (kbd "<C-S-iso-lefttab>") (lambda () (interactive) (other-window -1)))

;end sfang

; html mode
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2)
            (setq indent-tabs-mode t)))

; directory to put various el files into
(add-to-list 'load-path "~/.emacs.d/legacy")

; obj-c mode
(autoload 'objc-mode' "cc-mode" "Objective-C Editing Mode" t)
(setq c-mode-common-hook '(lambda nil
                           (setq c-indent-level 4)
                           (setq c-argdecl-indent 4)
                           (setq c-continued-statement-offset 4)
                           (setq c-continued-brace-offset 4)
                           (setq c-basic-offset 4)
                           (setq indent-tabs-mode nil)))
; ruby mode
(add-to-list 'load-path "~/.emacs.d/legacy/Enhanced-Ruby-Mode/")
(require 'enh-ruby-mode)

; js mode
(autoload 'javascript-mode "javascript-mode" "JavaScript mode" t)
(setq auto-mode-alist (append '(("\\.js$" . javascript-mode))
auto-mode-alist))
(setq auto-mode-alist (append '(("\\.erb$" . javascript-mode))
auto-mode-alist))
(setq js-indent-level 2)
; py mode
(add-hook 'python-mode-hook '(lambda ()
                               (setq python-indent 2)))
(defadvice python-calculate-indentation (around outdent-closing-brackets)
  "Handle lines beginning with a closing bracket and indent them so that
they line up with the line containing the corresponding opening bracket."
  (save-excursion
    (beginning-of-line)
    (let ((syntax (syntax-ppss)))
      (if (and (not (eq 'string (syntax-ppss-context syntax)))
               (python-continuation-line-p)
               (cadr syntax)
               (skip-syntax-forward "-")
               (looking-at "\\s)"))
          (progn
            (forward-char 1)
            (ignore-errors (backward-sexp))
            (setq ad-return-value (current-indentation)))
        ad-do-it))))

(ad-activate 'python-calculate-indentation)
; scala mode
(add-to-list 'load-path "~/.emacs.d/legacy/scala-mode2/")
(require 'scala-mode2)

;; Shift the selected region right if distance is postive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

;; Bind (shift-right) and (shift-left) function to your favorite keys. I use
;; the following so that Ctrl-Shift-Right Arrow moves selected text one
;; column to the right, Ctrl-Shift-Left Arrow moves selected text one
;; column to the left:

(global-set-key [C-S-right] 'shift-right)
(global-set-key [C-S-left] 'shift-left)
