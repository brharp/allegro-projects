;; index.cl
;; Front controller
;; - load required libraries
;; - load model
;; - load controllers
;; - load view
;; - route requests
;; - handle errors


(eval-when (:compile-toplevel :load-toplevel)
  (require :aserve)
  (require :regexp2)
  )


(defpackage :blog
  (:use :common-lisp :excl :net.aserve :net.html.generator
        :net.uri)
  (:export #:start))


(in-package :blog)


(defun router (req ent)
  (let ((path (uri-path (request-uri req))))
    (handler-case
        (re-case 
         path
         ("/new" ()
          (with-http-response (req ent)
            (with-http-body (req ent)
              (new-post-action))))
         ("/post" ()  ;; <---- should be /post/%/edit instead
          (let* ((id    (request-query-value "id"    req))
                 (date  (request-query-value "date"  req))
                 (title (request-query-value "title" req))
                 (body  (request-query-value "body"  req))
                 (id    (post-action id title date body)))
            (with-http-response (req ent :response *response-found*)
              (with-http-body
                  (req ent :headers (list (cons :location (format nil "/read/~a" id))))))))
         ("/read/([0-9]*)" ((oid 1))
          (with-http-response (req ent)
            (with-http-body (req ent)
              (show-action (parse-integer oid)))))
         ("/edit/([0-9]*)" ((oid 1))
          (with-http-response (req ent)
            (with-http-body (req ent)
              (edit-action (parse-integer oid)))))
         ("/" ()
          (with-http-response (req ent)
            (with-http-body (req ent)
              (list-action))))
         (t
          (with-http-response (req ent :response *response-not-found*)
            (with-http-body (req ent)
              (html "404 Not found.")))))
      (condition (c)
                 (with-http-response (req ent)
                   (with-http-body (req ent)
                     (html (:princ-safe c))))))))


(publish-prefix :prefix "/" :content-type "text/html" :function 'router)


                     