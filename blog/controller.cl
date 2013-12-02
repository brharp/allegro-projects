;; controller.cl
;; App controllers


(in-package :blog)


(defun list-action ()
  (let ((posts (get-all-posts)))
    (list-view posts)))


(defun show-action (id)
  (let ((post (get-post-by-id id)))
    (show-view post)))


(defun new-post-action ()
  (edit-view))


(defun post-action (id title date body)
  (if* (not id)
     then (add-post :title title :body body)
     else (update-post :id id :title title :date date :body body)))


(defun edit-action (id)
  (let ((post (get-post-by-id id)))
    (when post
      (edit-view :id (post-id post)
                 :title (post-title post)
                 :body (post-body post)))))
