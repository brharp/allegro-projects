(defun count-responses (option responses)
  (mapcar (lambda (option) (count option responses)) options)