;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname myappend) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;;An XY is either:
;;       1. X
;;       2. Y

;; Sample instances of (listof X), where X = number
(define LON1 '())
(define LON2'(10 20 30 40))
     
;; Sample instances of (listof Y), where Y = string
(define LOS1 '())
(define LOS2 '("" "A" "BB"))

;; (listof X) (listof Y) --> (listof XY)
;; Purpose: Create a new list with members of the first given list followed by members of the second given list
(define (myappend L1 L2)
  (if (empty? L1)
      L2
      (cons (first L1) (myappend (rest L1) L2))))

;; Sample expressions for myappend
(define LON1-LOS1-VAL LOS1)
(define LON1-LON2-VAL LON2)
(define LOS2-LOS1-VAL (cons (first LOS2) (myappend (rest LOS2) LOS1)))
(define LON2-LOS2-VAL (cons (first LON2) (myappend (rest LON2) LOS2)))

;; Tests using sample computations for myappend
(check-expect (myappend LON1 LOS1)  LON1-LOS1-VAL)
(check-expect (myappend LON1 LON2)  LON1-LON2-VAL)
(check-expect (myappend LOS2 LOS1)  LOS2-LOS1-VAL)
(check-expect (myappend LON2 LOS2)  LON2-LOS2-VAL)

;; Tests using sample values for myappend
(check-expect (myappend '(#true #false) '(a b c)) '(#true #false a b c))
(check-expect (myappend '(M) '(T M)) '(M T M))
