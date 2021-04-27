(provide 'personaloader)
(defun coralmacs-load-persona  ()
  "Loads a \"persona\" script (a custom .el file for user customizations)."
  (setq custom-file (concat (file-name-as-directory user-emacs-directory) "coralmacs-realm.el"))
  (load custom-file 'no-error)
)
