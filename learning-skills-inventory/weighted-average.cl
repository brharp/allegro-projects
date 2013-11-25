(defun weighted-average (weights counts total)
  (/ (reduce #'+ (mapcar #'* weights counts)) total))