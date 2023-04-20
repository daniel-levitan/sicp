#lang simply-scheme

;(list 'a 'b 'c)                            ; -> '(a b c)    ☑️
;(list (list 'george))                      ; -> '((george)) ☑️
;(cdr '((x1 x2) (y1 y2)))                   ; -> '(y1 y2)    ❎  '((y1 y2)) ; cdr é o resto da lista
;(cadr '((x1 x2) (y1 y2)))                  ; -> '(x2)       ❎  '(y1 y2) ; Aqui é o mesmo, cdr é o resto da lista
; se fosse '(1 2), (cdr '(1 2)) seria '(2)
;(pair? (car '(a short list)))              ; -> #f          ☑️
;(memq 'red '((red shoes) (blue socks)))    ; -> #f          ☑️
;(memq 'red '(red shoes blue socks))        ; -> '(red shoes blue socks) ☑️