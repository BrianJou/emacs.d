(delete-selection-mode t)
(add-hook 'before-save-hook '(lambda nil (untabify 0 (point-max))))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 2)
            (setq indent-tabs-mode t)))
(setq require-final-newline t)
(global-font-lock-mode 1)
(setq make-backup-files nil)
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

; directory to put various el files into
(add-to-list 'load-path "~/.emacs.d")

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
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist  (cons '(".rb$" . ruby-mode) auto-mode-alist))
(setq ruby-insert-encoding-magic-comment nil)
(add-hook 'ruby-mode-hook
          (require 'ruby-electric)
          (ruby-electric-mode t))
; js mode
(autoload 'javascript-mode "javascript-mode" "JavaScript mode" t)
(setq auto-mode-alist (append '(("\\.js$" . javascript-mode))
auto-mode-alist))
(setq auto-mode-alist (append '(("\\.erb$" . javascript-mode))
auto-mode-alist))
(setq js-indent-level 2)

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
