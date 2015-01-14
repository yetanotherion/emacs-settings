(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((test-case-name . twisted\.test\.test_lockfile) (test-case-name . twisted\.python\.test\.test_runtime) (test-case-name . twisted\.test\.test_task\,twisted\.test\.test_cooperator) (test-case-name . twisted\.internet\.test\.test_main) (test-case-name . twisted\.internet\.test\.test_default) (test-case-name . twisted\.names\.test\.test_names) (test-case-name . twisted\.test\.test_internet) (test-case-name . twisted\.test\.test_unix\,twisted\.internet\.test\.test_unix\,twisted\.internet\.test\.test_posixbase) (test-case-name . twisted\.web\.test) (test-case-name . twisted\.web\.test\.test_webclient) (test-case-name . twisted\.test\.test_internet\,twisted\.internet\.test\.test_posixbase) (test-case-name . twisted\.test\.test_abstract) (test-case-name . twisted\.test\.test_ssl) (test-case-name . twisted\.test\.test_tcp) (test-case-name . twisted\.web\.test\.test_http) (test-case-name . twisted\.web\.test\.test_newclient) (test-case-name . twisted\.test\.test_iutils) (test-case-name . twisted\.trial\.test\.test_util) (test-case-name . twisted\.trial\.test\.test_tests) (test-case-name . twisted\.trial\.test\.test_runner) (test-case-name . twisted\.trial\.test\.test_script) (test-case-name . twisted\.test\.test_defer\,twisted\.test\.test_defgen\,twisted\.internet\.test\.test_inlinecb) (test-case-name . twisted\.test\.test_failure)))))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default show-trailing-whitespace t)

(put 'upcase-region 'disabled nil)

(when (load "flymake" t)
         (defun flymake-pyflakes-init ()
           (let* ((temp-file (flymake-init-create-temp-buffer-copy
                              'flymake-create-temp-inplace))
                  (local-file (file-relative-name
                               temp-file
                               (file-name-directory buffer-file-name))))
             (list "pycheckers" (list local-file))))
         (defun flymake-rst-init ()
           (let* ((temp-file (flymake-init-create-temp-buffer-copy
                              'flymake-create-temp-inplace))
                  (local-file (file-relative-name
                               temp-file
                               (file-name-directory buffer-file-name))))
            (list "rst2html" (list local-file))))


         (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.py\\'" flymake-pyflakes-init))
         (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.rst\\'" flymake-rst-init))

         (add-to-list 'flymake-allowed-file-name-masks
                      '("\\.cfg\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
;;(setq flymake-enable-pep8 t)
;;(setq flymake-enable-pyflakes t)
;;(setq flymake-enable-pylint t)

;; no tabs by default. modes that really need tabs should enable
 ;; indent-tabs-mode explicitly. makefile-mode already does that, for
 ;; example.

(defun progmodes-hooks ()
  "Hooks for programming modes"
  ;;(yas/minor-mode-on)
  (add-hook 'before-save-hook 'progmodes-write-hooks))

(defun untabify-buffer ()
  "Untabify current buffer"
  (interactive)
  (untabify (point-min) (point-max)))

(defun progmodes-write-hooks ()
  "Hooks which run on file write for programming modes"
  (prog1 nil
    ;;(set-buffer-file-coding-system 'utf-8-unix)
    (untabify-buffer)
    ;;(copyright-update)
    ;;(maybe-delete-trailing-whitespace)
    ))

(defun progmodes-write-hooks-and-delete-trailing ()
  "Hooks which run on file write for programming modes"
  (prog1 nil
    ;;(set-buffer-file-coding-system 'utf-8-unix)
    (untabify-buffer)
    (delete-trailing-whitespace)
    ))

(defun progmodesbis-hook ()
  (add-hook 'before-save-hook 'progmodes-write-hooks-and-delete-trailing))

(add-hook 'python-mode-hook 'progmodes-hook)
(add-hook 'yaml-mode-hook 'progmodesbis-hook)
(add-hook 'rst-mode-hook 'progmodes-hook)
(setq-default indent-tabs-mode t)
;;(setq-default indent-tabs-mode nil)
;; if indent-tabs-mode is off, untabify before saving
;;(add-hook 'write-file-hooks
;;          (lambda () (if (not indent-tabs-mode)
;;                         (untabify (point-min) (point-max)))))

(put 'downcase-region 'disabled nil)
(setq column-number-mode t)

(autoload 'js2-mode "js-mode/js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.cfg$" . python-mode))

;; 100 char per line
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 100)
(global-whitespace-mode t)

;; font size
(set-face-attribute 'default nil :height 101)


(global-set-key (kbd "C-x C-b") 'ibuffer)
(load-file "/usr/share/emacs/site-lisp/proofgeneral/generic/proof-site.el")