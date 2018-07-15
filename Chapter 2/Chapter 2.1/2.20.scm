; Lmao i'm using scheme because Elm doesn't have support for an arbitrary amount of parameters in functions

(define (is-even number)
  (cond ((< number 0) #f)
        ((= number 0) #t)
        ((> number 0) (is-even (- number 2)))
  )
)

(define (is-odd number)
  (cond ((< number 1) #f)
        ((= number 1) #t)
        ((> number 1) (is-odd (- number 2)))
  )
)

(define (parity? num1 num2)
  (if (is-even num1)
    (is-even num2)
    (is-odd num2)
  )
)

(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) 
                     (+ 1 count))))
  (length-iter items 0))

(define null-list (list))


(define (same-parity num . otherVars)
  (define (same-parity-iter n l answer)
    (if (= (length l) 0)
      answer
      (if (parity? n (car l) )
        (same-parity-iter
          n
          (cdr l)
          (append answer (list (car l))))
        (same-parity-iter
          n
          (cdr l)
          answer)
      )
    )
  )
  (same-parity-iter num otherVars (list num))
)

; sometimes you have to put print in front of it
(same-parity 1 2 3 4 5 6 7 8 9 10)