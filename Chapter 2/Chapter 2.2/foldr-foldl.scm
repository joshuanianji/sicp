;; Scheme's foldl and foldr functions (lmao they're defined by myself but trust me they are the same as haskell's) are different than Elm's

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
	  (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
	    result
	(iter (op result (car rest))
	      (cdr rest))))
  (iter initial sequence))

(print (fold-right / 1 (list 1 2 3)))
(print (fold-left / 1 (list 1 2 3)))
(print (fold-right list '() (list 1 2 3)))
(print (fold-left list '() (list 1 2 3)))
(print (fold-right + 0 '(1 2 3)))
(print (fold-left + 0 '(1 2 3)))