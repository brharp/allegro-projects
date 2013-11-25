

(require :aserve)
(require :acache "acache-2.1.22.fasl")
(require :regexp2)
(require :uri)

(defpackage :learning-skills-inventory
  (:use :common-lisp :excl
        :net.html.generator :net.aserve :net.uri
        :net.html.forms
        :db.allegrocache))


(in-package :learning-skills-inventory)


(defclass page ()
  ((stylesheets :initarg :stylesheets :accessor page-stylesheets :initform nil)
   (title       :initarg :title       :accessor page-title       :initform "Untitled")
   (body        :initarg :body        :accessor page-body        :initform "No content has been added.")))


(defmethod print-object ((page page) stream)
  (let ((*html-stream* stream))
    (html (:html
           (:head
            (:title (:princ-safe (page-title page)))
            (dolist (href (page-stylesheets page))
              (html ((:link :rel "stylesheet" :type "text/css" :href href)))))
           (:body
            (:h1 (:princ-safe (page-title page)))
            (:p (:princ (page-body page))))))))



(defmethod initialize-instance :after ((instance survey) &key questions &allow-other-keys)
  (setf (page-body instance) (make-survey-form instance)))



(defun controller (req ent)
  (handler-case
      (re-case (uri-path (request-uri req))
               ("/node/(.*)" ((oid 1))
                (with-http-response (req ent)
                  (with-http-body (req ent)
                    (let ((*standard-output* *html-stream*))
                      (print (oid-to-object* 'page (parse-integer oid)))))))
               ("/survey/(.*)" ((oid 1))
                (with-http-response (req ent)
                  (with-http-body (req ent)
                    (let ((*standard-output* *html-stream*))
                      (print (view-survey (parse-integer oid)))))))
               (t
                (with-http-response (req ent :response *response-not-found*)
                  (with-http-body (req ent)
                    (html "404 Not found.")))))
    (condition (c)
      (with-http-response (req ent)
        (with-http-body (req ent)
          (html (:princ-safe c)))))))


(publish-prefix :prefix "/"
                :content-type "text/html"
                :function #'controller)

(create-file-database "lsi.db")
(open-file-database "lsi.db")

(make-instance 'survey)

(start :port 8080)


