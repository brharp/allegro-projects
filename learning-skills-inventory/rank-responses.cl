(defun rank-responses (options responses)
  (weighted-average options (count-responses options responses)
                    (length responses)))