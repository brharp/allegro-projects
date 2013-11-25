(in-package :net.html.forms)

(defclass grid-layout (layout)
  (columns :initarg :columns)
  (rows    :initarg :rows))


(defmethod display ((g grid-layout))
  
  (html
   (:table
    (:tbody)))
  )