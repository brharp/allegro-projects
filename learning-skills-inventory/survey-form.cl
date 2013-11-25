(in-package :learning-skills-inventory)

(defun make-survey-form (object)
   (make-instance 'form
     :action (format nil "/survey/~a/submit" (db-object-oid object)) 
     :method "POST"
     :fields (make-survey-fields object)
     :on-submit #'commit))


(defun iota (n)
  (loop for i from 0 below n collect i))


(defun make-survey-fields (object)
  (mapcan
      (lambda (i item)
        (mapcar
            (lambda (scale)
              (make-instance 'input
                :type "radio"
                :name (format nil "item:~a" i)
                :label (scale-description scale)
                :value ""
                :on-change nil))
          (survey-scales object)))
    (iota (length (survey-items object)))
    (survey-items object)))

