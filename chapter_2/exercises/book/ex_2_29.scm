#lang simply-scheme

; A binary mobile consists of two branches, a left branch and a right branch. Each branch is a rod of
; a certain length, from which hangs either a weight or another binary mobile. We can represent a binary mobile
; using compound data by constructing it from two branches (for example, using list):

(define (make-mobile left right)
  (list left right))

; A branch is constructed from a length (which must be a number) together with a structure, which may be either a
; number (representing a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

(define b1 (make-branch 2 3))
(define b2 (make-branch 4 5))
(define m1 (make-mobile b1 b2))
(define m2 (make-mobile b1 m1))


; a. Write the corresponding selectors left-branch and right-branch, which return the branches of a mobile,
; and branch-length and branch-structure, which return the components of a branch.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))


;(left-branch m2)
;(right-branch m2)


; b. Using your selectors, define a procedure total-weight that returns the total weight of a mobile.

(define (total-weight branch)
  (if (not (pair? (branch-structure branch)))
      (branch-structure branch)
      (+ (total-weight (right-branch branch)) (total-weight (left-branch branch)))))

;(total-weight b2)

; c. A mobile is said to be balanced if the torque applied by its top-left branch is equal to that applied
; by its top-right branch (that is, if the length of the le rod multiplied by the weight hanging from that
; rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off
; its branches is balanced. Design a predicate that tests whether a binary mobile is balanced.

(define (balanced? mobile)
  (equal? (total-weight (left-branch m2)) (total-weight (right-branch m2))))

(balanced? m2)

; d. Suppose we change the representation of mobiles so that the constructors are
(define (make-mobile-2 left right) (cons left right))

(define (make-branch-2 length structure)
  (cons length structure))

(define b1-2 (make-branch-2 2 3))
(define b2-2 (make-branch-2 4 5))
(define m1-2 (make-mobile-2 b1-2 b2-2))
(define m2-2 (make-mobile-2 b1-2 m1-2))

;(total-weight b2-2)


; How much do you need to change your programs to convert to the new representation?
; Vou ter de mudar algo
