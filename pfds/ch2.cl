
(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel)
  (require :tester)
  (use-package :util.test))


;; Chapter 2

;; Exercise 2.1: Write a function SUFFIXES of type A LIST -> A LIST LIST that takes
;; a list XS and returns a list of all the suffixes of XS in decreasing order of length.
;; For example,
;;   SUFFIXES[1,2,3,4] = [[1,2,3,4],[2,3,4],[3,4],[4],[]]
;; Show that the resulting list of suffixes can be generated in O(n) time and
;; represented in O(n) space.

(defun suffixes (xs)
  (if (null xs) (list xs) (cons xs (suffixes (rest xs)))))

(test (suffixes '(1 2 3 4)) '((1 2 3 4) (2 3 4) (3 4) (4) ()) :test #'equal)

;; SUFFIXES reduces the length of its argument by 1 each time. Since there
;; are N elements in the list, SUFFIXES can be called no more than N times.
;; Likewise, the resulting list grows by 1 element for each call to SUFFIX,
;; so the total result can occupy no more than N cells.



