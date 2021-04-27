
(provide 'sublimity-coralmacs)
(defun coralmacs-sublimity-setup-scroll (weight length)
  "Initializes the Sublimity side of scrolling for CoralMacs."
  (require 'sublimity-scroll)
  (sublimity-mode 1)
  (setq sublimity-scroll-weight weight sublimity-scroll-drift-length length)
  (setq sublimity-scroll-vertical-frame-delay 0.01)
)
(defun coralmacs-sublimity-setup-map (size fraction scale)
  "Initializes the Sublimity minimap for CoralMacs."
  (require 'sublimity-map)
  (setq sublimity-map-size size)
  (setq sublimity-map-fraction fraction)
  (setq sublimity-map-text-scale scale)
  (setq sublimity-map-set-delay 5)
)
