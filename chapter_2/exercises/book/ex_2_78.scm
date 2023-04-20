#lang simply-scheme

(define (attach-tag type-tag contents)
  contents)


;(define (type-tag datum)
;  (if (pair? datum)
;      (car datum)
;      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (type-tag datum)
  (if (number? datum)
      'scheme-number
      (error "Bad tagged datum: TYPE-TAG" datum)
   )
  )

;(define (contents datum)
;  (if (pair? datum)
;      (cdr datum)
;      (error "Bad tagged datum: CONTENTS" datum)))

(define (contents datum)
  (if (number? datum)
      datum
      (error "Bad tagged datum: CONTENTS" datum)
      )
  )