(define (fringe x)
  (define (fringe-iter x list-iter)
    (cond ((null? x) ())
          ((not (pair? x))
            (append list-iter (list x)))
          (else (append (fringe-iter (car x) list-iter)
                        (fringe-iter (cdr x) list-iter)))
    )
  )
  (fringe-iter x ())
)


(define abomination (list 2 (list 5 (list 4 5) 3) 4 (list 4 5) 3))

(fringe abomination)