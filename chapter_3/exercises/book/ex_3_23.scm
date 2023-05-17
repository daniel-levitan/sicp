;#lang simply-scheme
;(load "/Users/daniel/Documents/projects/cs61a/chapter_3/exercises/book/ex_3_23.scm")

; A deque (“double-ended queue”) is a sequence in which items can be inserted and deleted at either the
; front or the rear. Operations on deques are:

; 1. the constructor make-deque,
; 2. the predicate empty-deque?,
; 3. selectors:
;    3a. front-deque and
;    3b. rear-deque,
; 4. mutators
;    4a. front-insert-deque!,
;    4b. rear-insert-deque!,
;    4c. front-delete-deque!, and
;    4d. rear-delete-deque!.

; Show how to represent deques using pairs, and give implementations of the operations.
; All operations should be accomplished in theta(1) steps.

; For the last operation to run in theta(1) steps, we need to be able to set the cdr of one before the
; last to '()

; A deque is a pair whose car is a pointer to front and cdr is a pointer to rear
(define (make-deque) (cons '() '()))

; Getting front and rear ptrs
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))

; Setting front and rear ptrs
(define (set-front-ptr! deque item)
  (set-car! deque item))
(define (set-rear-ptr! deque item)
  (set-cdr! deque item))

(define (empty-deque? deque)
  (null? (and (front-ptr deque)
              (rear-ptr deque))))

; An item is a pair whose car is the value and the cdr is a pair of pointers
; car of this pointers is the previous element and cdr is the next element
(define (make-item value previous next)
  (cons value (cons previous next)))

(define (previous-ptr item) (cadr item))
(define (next-ptr item) (cddr item))
(define (set-previous-ptr! item previous)
  (set-car! (cdr item) previous))
(define (set-next-ptr! item next)
  (set-cdr! (cdr item) next))


;(define (set-previous! item) (

; Reading front and rear elements
(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (car (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" deque)
      (car (rear-ptr deque))))

; Insertion of elements
(define (front-insert-deque! deque item)
  (cond ((empty-deque? deque)
         (let ((new-pair (make-item item '() '())))
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque))
        (else
         (let ((new-pair (make-item item '() (front-ptr deque))))
           (set-previous-ptr! (front-ptr deque) new-pair)
           (set-front-ptr! deque new-pair)          
           deque))))

(define (rear-insert-deque! deque item)
  (cond ((empty-deque? deque)
         (let ((new-pair (make-item item '() '())))
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque new-pair)
           deque))
        (else
         (let ((new-pair (make-item item (rear-ptr deque) '())))
           (set-next-ptr! (rear-ptr deque) new-pair)
           (set-rear-ptr! deque new-pair)          
           deque))))


; Print on screen to see what is happening
(define (print-deque lst)
  (if (null? lst)
      (newline)      
      (begin
        (display (car lst)) (display " ")
        (print-deque (next-ptr lst))
             )))

; Deletion
(define (front-delete-deque! deque)
  (if (eq? (front-ptr deque) (rear-ptr deque))
      (begin (set-front-ptr! deque '())
             (set-rear-ptr! deque '()))
      (begin (set-front-ptr! deque (next-ptr (front-ptr deque)))
             (set-previous-ptr! (front-ptr deque) '()))))

(define (rear-delete-deque! deque)
  (if (eq? (front-ptr deque) (rear-ptr deque))
      (begin (set-front-ptr! deque '())
             (set-rear-ptr! deque '()))
      (begin (set-rear-ptr! deque (previous-ptr (rear-ptr deque)))
             (set-next-ptr! (rear-ptr deque) '()))))

; -- Testing
(define d (make-deque))
(front-insert-deque! d 1)
(rear-insert-deque! d 2)
(rear-insert-deque! d 3)

(print-deque (front-ptr d))

(rear-delete-deque! d)
(print-deque (front-ptr d))

(rear-delete-deque! d)
(print-deque (front-ptr d))
  
;(front-delete-deque! d)
;(print-deque (front-ptr d))

;(front-delete-deque! d)
;(print-deque (front-ptr d))

;(rear-insert-deque! d 2)
;(rear-insert-deque! d 3)
;(front-insert-deque! d 4)
;(front-insert-deque! d 5)

