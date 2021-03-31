;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname all-lt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/abstraction)

;; Sample instances of lon
(define L0 '())
(define L1 '(89 33 77 56 12 8 7))
(define L2 '(8  31 37 44 12 2 4))

; all-lt: (listof number) number --> boolean
; Purpose: To determine if all the numbers in the given list are less than the given number
(define (all-lt L threshold)
  (for/and ([v L])
    (< v threshold)))

;; Sample expressions for all-lt
(define L0-VAL (for/and ([v L0]) (< v 887)))
(define L1-VAL (for/and ([v L1]) (< v 100)))
(define L2-VAL (for/and ([v L2]) (< v 50)))

;; Tests using sample computations for all-lt
(check-expect (all-lt L0 887) L0-VAL)
(check-expect (all-lt L1 100) L1-VAL)
(check-expect (all-lt L2 50)  L2-VAL)

;; Tests using sample values for all-lt
(check-expect (all-lt '() 5)           #true)
(check-expect (all-lt (list -1 2 -3) 0)  #false)
(check-expect (all-lt (list 3 -8 -4) 10) #true)

