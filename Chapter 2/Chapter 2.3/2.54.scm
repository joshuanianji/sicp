;; I'm pretty sure this works haha: looks really bad though. couldn't do it in elm because I would have had to use a nested list and I'm kinda tired of them. i think i can do it elm though lol

(define list1
    '(this is a list))
  
(define list2
    '(this (is a) list))
  
;; just recursion
(define (equal? a b)
        (cond   ((and (null? a) (null? b)) #t)
                ((and (pair? (car a)) (pair? (car b))) 
                    (and (equal? (car a) (car b)) 
                        (equal? (cdr a) (cdr b))))
                ((eq? (car a) (car b))
                    (equal? (cdr a) (cdr b)))
                (else #f)
        )
)
    
(equal? list2 list2)