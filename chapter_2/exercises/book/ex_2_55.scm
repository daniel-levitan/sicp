#lang simply-scheme

(car ''abracadabra)

;''abc

; 'abc -> (quote abc)

(car (quote (quote abracadabra)))

(car (quote (command something)))

; We can see what is happening by substituting the inner quote for a word, let's say, command.
; The outer quote transforms the inner quote (or command), meaning that everything after it is quoted.
; What's inside the parenthesis is a list then and car recovers the left element from the list (first pair).
; So, (car (command something)) returns something, so (car (quote something)) return quote.
; That means that the first quote is applied to the whole thing

; This is strange since I see (quote (quote abc)) as ''abc