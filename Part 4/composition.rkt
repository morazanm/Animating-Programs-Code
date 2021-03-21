;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname composition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; number --> number
;; Purpose: Add 4 to the given number
(define (add4 x) (+ x 4))

;; Sample expressions for add4
(define ADD4-VAL1 (+ 5 4))
(define ADD4-VAL2 (+ -7 4))

;; Tests using sample computations for add4
(check-expect (add4 5) ADD4-VAL1)
(check-expect (add4 -7) ADD4-VAL2)

;; Tests using sample values for add4
(check-expect (add4 0) 4)
(check-expect (add4 -10) -6)

;; number --> number
;; Purpose: Double the given number
(define (double x) (* 2 x))

;; Sample expressions for double
(define DOUBLE-VAL1 (* 2 10))
(define DOUBLE-VAL2 (* 2 -3))

;; Tests using sample computations for double
(check-expect (double 10) DOUBLE-VAL1)
(check-expect (double -3) DOUBLE-VAL2)

;; Tests using sample values for double
(check-expect (double -7) -14)
(check-expect (double 65) 130)

;; (number --> number) (number --> number) number --> number
;; Purpose: Return f(g(x))
(define (f-o-g f g x) (f (g x)))

;; number --> number
;; Purpose: Add 4 to the double of the given number
(define (add4-o-double x) (f-o-g add4 double x))

;; Sample expressions for add4-o-double
(define ADD4-DOUBLE-VAL1 (add4 (double 0)))
(define ADD4-DOUBLE-VAL2 (add4 (double -1)))

;; Tests using sample computations for add4-o-double
(check-expect (add4-o-double 0)  ADD4-DOUBLE-VAL1)
(check-expect (add4-o-double -1) ADD4-DOUBLE-VAL2)

;; Tests using sample values for add4-o-double
(check-expect (add4-o-double -8) -12)
(check-expect (add4-o-double 50) 104)

;; number --> number
;; Purpose: Double the sum of the given number and 4
(define (double-o-add4 x) (f-o-g double add4 x))

;; Sample expressions for double-o-add4
(define DOUBLE-ADD4-VAL1 (double (add4 10)))
(define DOUBLE-ADD4-VAL2 (double (add4 -2)))

;; Tests using sample computations for double-o-add4
(check-expect (double-o-add4 10)  DOUBLE-ADD4-VAL1)
(check-expect (double-o-add4 -2) DOUBLE-ADD4-VAL2)

;; Tests using sample values for double-o-add4
(check-expect (double-o-add4 40) 88)
(check-expect (double-o-add4 -6) -4)
