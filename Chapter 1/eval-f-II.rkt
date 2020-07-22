;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname eval-f-II) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Evaluating f(x) = x^2 + 3x - 10

(check-expect F-X10 120)
(check-expect F-X0 -10)
(check-expect F-X1 -6)
(check-expect F-X20 450)
(check-expect F-X100 10290)
(check-expect (f 11) 144)
(check-expect (f 12) 170)
(check-expect (f 13) 198)
(check-expect (f 14) 228)
(check-expect (f 15) 260)
(check-expect (f 16) 294)
(check-expect (f 17) 330)
(check-expect (f 18) 368)
(check-expect (f 19) 408)
              
(define F-X10 (+ (sqr 10) (* 3 10) -10))
(define F-X0  (+ (sqr 0) (* 3 0) -10))
(define F-X1  (+ (sqr 1) (* 3 1) -10))
(define F-X20 (+ (sqr 20) (* 3 20) -10))
(define F-X100 (+ (sqr 100) (* 3 100) -10))

; number --> number
; Purpose: To compute f(x)
(define (f x)
  (+ (sqr x) (* 3 x) -10))





