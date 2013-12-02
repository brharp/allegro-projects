;; model.cl
;; Blog model

(in-package :blog)


(defstruct post
  id
  title
  date
  body)


(defvar *posts*
    (list (make-post :id 1 :title "The Girl in the Blue Velvet Band" :date "Nov 1"
                     :body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet placerat sapien. Praesent ullamcorper cursus malesuada. Pellentesque vitae quam quis massa egestas sodales porttitor egestas nisi. Curabitur imperdiet tempor justo sit amet sodales. Donec tincidunt odio at risus cursus cursus. Mauris ut dolor in erat tincidunt gravida mattis non felis. Maecenas id accumsan eros.")
          (make-post :id 2 :title "We Were Waltzing One Night in Kentucky" :date "Nov 3"
                     :body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet placerat sapien. Praesent ullamcorper cursus malesuada. Pellentesque vitae quam quis massa egestas sodales porttitor egestas nisi. Curabitur imperdiet tempor justo sit amet sodales. Donec tincidunt odio at risus cursus cursus. Mauris ut dolor in erat tincidunt gravida mattis non felis. Maecenas id accumsan eros.")
          (make-post :id 3 :title "Ground Speed" :date "Nov 10"
                     :body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sit amet placerat sapien. Praesent ullamcorper cursus malesuada. Pellentesque vitae quam quis massa egestas sodales porttitor egestas nisi. Curabitur imperdiet tempor justo sit amet sodales. Donec tincidunt odio at risus cursus cursus. Mauris ut dolor in erat tincidunt gravida mattis non felis. Maecenas id accumsan eros.")))


(defun get-all-posts ()
  *posts*)


(defun get-post-by-id (id)
  (find id *posts* :key #'post-id))



(defun add-post
    (&key (title "Untitled Post")
          (date (get-universal-time))
          (body "This page intentionally left blank."))
  (let* ((id (length *posts*))
         (post (make-post :id id :title title :date date :body body)))
    (push post *posts*)
    id))


(defun update-post
    (&key id
          title
          (date (get-universal-time))
          body)
  (let ((post (get-post-by-id id)))
    (when post
      (setf
       (post-title title) title
       (post-date date)   date
       (post-body body)   body)))
  id)


    