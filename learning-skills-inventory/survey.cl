;; -*- mode: common-lisp; package: survey; -*-
;;
;; survey.cl
;;
;; Copyright 2013 M. Brent Harp
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(defpackage :survey
  (:use :common-lisp :excl)
  (:export #:survey))


(in-package :survey)


(defstruct (option (:type list))
  (weight 0   :type integer :read-only t)
  (title  nil :type string  :read-only t))


(defun weighted-average (weights counts total)
  (/ (reduce #'+ (mapcar #'* weights counts)) total))


(defun count-responses (options responses)
  (mapcar (lambda (option) (count (option-weight option) responses)) options))


(defun aggregate-responses (options responses)
  (weighted-average (mapcar #'option-weight options)
                    (count-responses options responses)
                    (length responses)))


(defun read-response (options)
  (let ((option-counter 1))
    (dolist (option options)
      (format t "~&(~d) ~a~%" option-counter option)
      (incf option-counter)))
  (format t "~&Please choose: ")
  (read))


(defun survey (&key title options items)
  (declare (ignore title))
  (mapcar
      (lambda (item)
        (format t "~&~a~%" item)
        (read-response options))
    items))


(defvar *options*
    (list (make-option :title "Strongly disagree" :weight 1)
          (make-option :title "Disagree" :weight 2)
          (make-option :title "Undecided" :weight 3)
          (make-option :title "Agree" :weight 4)
          (make-option :title "Strongly agree" :weight 5)))


(defvar *items*
    (list "Socks are darn great."
          "Tennis is like ping pong."
          "Bears like honey."
          "I am on fire."
          "Toast."))


'(print
 (aggregate-responses *options*
   (survey :title "Learning Skills Inventory"
           :options *options* :items *items*)))
