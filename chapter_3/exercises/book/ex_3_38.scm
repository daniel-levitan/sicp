;#lang simply-scheme
; Initial balance = 100

; a)
; Peter: (set! balance (+ balance 10))
; Paul: (set! balance (- balance 20))
; Mary: (set! balance (- balance (/ balance 2)))

; The possibilities is ordering of abc: abc acb bac bca cab cba

; abc acb
; -> 100: + 10 -> 110 - 20 -> 90 / 2 -> 45
; -> 100: + 10 -> 110 / 2 -> 55 - 20 -> 35

; bac bca
; -> 100: - 20 -> 80 + 10 -> 90 / 2 -> 45
; -> 100: - 20 -> 80 / 2 -> 40 + 10 -> 50

; cab cba
; -> 100: / 2 -> 50 + 10 -> 60 - 20 -> 40
; -> 100: / 2 -> 50 - 20 -> 30 + 10 -> 40

;b) Yes, there are

; Let's say Mary reads the balance, Peter reads the balance, Mary sets the balance to 50, Peter sets the balance to 110,
; Now Paul reads the balance and set's it to 90, which is one of the options that wouldn't occur according to the
; restriction imposed in a
