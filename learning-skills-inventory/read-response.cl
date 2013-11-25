(defun read-response (options)
  (let ((option-counter 1))
    (dolist (option options)
      (format t "(~d) ~a~%" option-counter option)
      (incf option-counter)))
  (read))