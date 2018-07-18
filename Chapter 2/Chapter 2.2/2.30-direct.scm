;; this is defining the square-tree directly. I don't want to do it in elm lol
(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) 
         (* tree tree))
        (else
         (cons (square-tree (car tree))
               (square-tree (cdr tree))))))

(square-tree (list 1 
                  (list 2 (list 3 4) 5) 
                  (list 6 7)))