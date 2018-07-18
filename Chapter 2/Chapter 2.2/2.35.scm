;; both functions used in modulation
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op 
                initial 
                (cdr sequence)))))

;; Bill's code
(define (enumerate-tree tree)
    (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append 
                (enumerate-tree (car tree))
               (    enumerate-tree (cdr tree))))))

(define (count-leaves-bill tree)
    (accumulate
        +
        0
        (map
            (lambda (x) 1)
            (enumerate-tree t))))

;; My code - doesn't use the map function
(define (count-leaves-moi tree)
    (accumulate
        (lambda (element rest-of-tree)
            (if pair? element)
                (+ (count-leaves x) y)
                (+ 1 y))
    0
    tree))
