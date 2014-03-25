;;;; -*- Mode: Lisp; Syntax: Common-Lisp -*-
;;;; AND Gate
;;;; Copyright (c) 2014 Brent Harp

(defdiagram and-gate (a AND b c d)
  (b TERM a)
  (c TERM a)
  (d TERM a))

(print-labelings
 (diagram 'and-gate))

(print-labelings
 (on (diagram 'and-gate) 'b 'a))

(print-labelings
 (on (on (diagram 'and-gate) 'b 'a) 'd 'a))




(defdiagram not-and
    (a AND b c d)
  (b NOT e a)
  (c TERM a)
  (d TERM a)
  (e TERM b))


(print-labelings (diagram 'not-and))