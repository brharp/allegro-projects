;; view.cl
;; Blog views


(in-package :blog)


(defmacro layout 
    (&key (title "Untitled")
          (content "This page intentionaly left blank."))
  `(html
    (:html
     (:head (:title ,title))
     (:body ,content))))

  
(defun list-view (posts)
  (layout
   :title "List of Posts"
   :content (html
             (:h1 "List of Posts")
             (:ul
              (dolist (post posts)
                (html
                 (:li
                  ((:a :href (format nil "/read/~a" (post-id post)))
                   (:princ-safe (post-title post))))))))))


(defun show-view (post)
  (layout
   :title (post-title post)
   :content
   (html
    (:h1 (:princ-safe (post-title post)))
    (:div (:princ-safe (post-date post)))
    (:div (:princ-safe (post-body post)))
    (:ul
     (:li ((:a :href "/") "Back to list"))
     (:li ((:a :href (format nil "/edit/~a" (post-id post))) "Edit post"))))))


(defun edit-view (&key (title "") (body "") (id ""))
  (layout
   :title "New Post"
   :content
   (html
    (:h1 "New Post")
    ((:form :action "/post")
     ((:input :type "hidden" :name "id" :value id))
     ((:label :for "title") "Title: ")
     ((:input :type "text" :name "title" :value title)) :br
     ((:textarea :name "body" :cols 80 :rows 25) (:princ body)) :br
     ((:input :type "submit" :value "Post"))))))


