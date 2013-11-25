(in-package :learning-skills-inventory)

(defun view-survey (oid)
  (let ((survey))
    (when (setq survey (oid-to-object 'survey oid))
      (make-survey-form survey))))