;; writing this in Scheme because after 2.49 I lost the ability to convert further exercises into elm lol.

;; transform-painter
(define (transform-painter painter origin corner1 corner2)
    (lambda (frame)
    (let ((m (frame-coord-map frame)))
        (let ((new-origin (m origin)))
            (painter (make-frame new-origin
                (sub-vect (m corner1) 
                          new-origin)
                (sub-vect (m corner2)
                       new-origin)))))))

(define (flip-horiz painter)
    transform-painter 
        painter
        (make-vect frame-length 0)
        (make-vect ))