#lang simply-scheme



(define f
  (let ((r -1))
    (lambda (x)      
      (cond ((= r -1) (begin (set! r x)
                            r))
       (else r))
    )
  )
)



(f 1)
(f 0)

