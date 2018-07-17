;; for the deep reverse
(define (deep-reverse list-thing)
  (cond ((null? list-thing) ())
        ((not (pair? list-thing)) list-thing)
        (else (append (deep-reverse (cdr list-thing))
                      (list (deep-reverse (car list-thing)))
              )
        )
  )
)

;; for the reverse
(define (reverse list-thing)
  (if (null? list-thing)
      ()
      (append (reverse (cdr list-thing))
              (list (car list-thing)))))

(define abomination (list 2 (list 5 (list 4 5) 3) 4 (list 4 5) 3))

(define x 
  (list (list 1 2) (list 3 4)))

(deep-reverse x)