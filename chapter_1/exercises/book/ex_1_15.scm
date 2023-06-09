#lang simply-scheme

; The sine of an angle (specified in radians) can be computed by making use of the approximation sin x ≈ x
; if x is sufficiently small, and the trigonometric identity sin x = 3 sin x/3 - 4 sin^3 x / 3
; to reduce the size of the argument of sin. (For purposes of this exercise an angle is considered
; “sufficiently small” if its magnitude is not greater than 0.1 radians.) These ideas are
; incorporated in the following procedures:

(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))

  
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

; a. How many times is the procedure p applied when (sine 12.15) is evaluated?
; b. What is the order of growth in space and number of steps (as a function of a) used by the process generated
;    by the sine procedure when (sine a) is evaluated?

;(trace sine)
(sine 12.15)


;>(sine 12.15 0)
;> (sine 4.05 1)
;> >(sine 1.3499999999999999 2)
;> > (sine 0.44999999999999996 3)
;> > >(sine 0.15 4)
;> > > (sine 0.049999999999999996 5)
;< < < 0.049999999999999996
;< < <0.1495
;< < 0.4351345505
;< <0.9758465331678772
;< -0.7895631144708228
;<-0.39980345741334
;-0.39980345741334

; a) We see that there are 5 steps involved.
; b) Need to think about it