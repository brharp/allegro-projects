(defun survey (options questions)
  (mapcar
    (lambda (question)
      (print-question question)
      (read-response options))
  questions)))