(in-package :learning-skills-inventory)

(defclass survey (page)
  ((title :initarg :title :reader survey-title)
   (items :initarg :items :reader survey-items :initform nil)
   (scales :initarg :scales :reader survey-scales :initform nil))
  (:metaclass persistent-class))

(defclass item ()
  ((description :initarg :description :reader item-description))
  (:metaclass persistent-class))

(defclass scale ()
  ((description :initarg :description :reader scale-description)
   (weight :initarg :weight :reader scale-weight :initform 0))
  (:metaclass persistent-class))

(defun list-surveys ()
  (let ((surveys ()))
    (doclass* (survey 'survey)
              (push survey surveys))
    surveys))

'(make-instance 'survey
  :title "Learning Skills Inventory"
  :scales (list (make-instance 'scale :description "Strongly disagree" :weight 1)
                (make-instance 'scale :description "Disagree" :weight 2)
                (make-instance 'scale :description "Undecided" :weight 3)
                (make-instance 'scale :description "Agree" :weight 4)
                (make-instance 'scale :description "Strongly agree" :weight 5))
  :items (list (make-instance 'item :description "Socks are darn great.")
               (make-instance 'item :description "Tennis is like ping pong.")
               (make-instance 'item :description "Bears like honey.")
               (make-instance 'item :description "I am on fire.")
               (make-instance 'item :description "Toast.")))
