;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname secant) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; number --> number
;; Purpose: Compute the cube of the given number
(define (cube n) (* n n n))

#|
;; Sample expressions for cube
(define CUBE2 (* 2 2 2))
(define CUBE-1.1 (* -1.1 -1.1 -1.1))

;; Tests using sample computations for cube
(check-within (cube 2)    CUBE2    0.01)
(check-within (cube -1.1) CUBE-1.1 0.01)

;; Tests using sample values for cube
(check-within (cube 11.7) 1601.61 0.01)


;; number number --> number
;; Purpose: Approximate the slope of the secant line between the
;;          given x-values for f(x) = x^2
(define (x^2-secant-slope x1 x2)
  (/ (- (sqr x2) (sqr x1)) (- x2 x1)))

;; Sample expressions for x^2-secant-slope
(define MSEC1 (/ (- (sqr 4) (sqr 2)) (- 4 2)))
(define MSEC2 (/ (- (sqr 3.75) (sqr -2.03)) (- 3.75 -2.03)))

;; Tests using sample computations for x^2-secant-slope
(check-within (x^2-secant-slope 2 4)        MSEC1 0.01)
(check-within (x^2-secant-slope -2.03 3.75) MSEC2 0.01)

;; Tests using sample values for x^2-secant-slope
(check-within (x^2-secant-slope 1.5 3.2) 4.7 0.01)


;; number number --> number
;; Purpose: Approximate the slope of the secant line between the
;;          given x-values for f(x) = x^3
(define (x^3-secant-slope x1 x2)
  (/ (- (cube x2) (cube x1)) (- x2 x1)))

;; Sample expressions for x^2-secant-slope
(define MSEC3 (/ (- (cube 5)    (cube 1))    (- 5 1)))
(define MSEC4 (/ (- (cube 10.1) (cube -4.6)) (- 10.1 -4.6)))

;; Tests using sample computations for x^3-secant-slope
(check-within (x^3-secant-slope 1 5)       MSEC3 0.01)
(check-within (x^3-secant-slope -4.6 10.1) MSEC4 0.01)

;; Tests using sample values for x^3-secant-slope
(check-within (x^3-secant-slope 1.5 3.2) 17.29 0.01)
|#

;; (number --> number) number number --> number
;; Purpose: Approximate the slope of the secant line between the
;;          given x-values for the given function
(define (f-sec-slope f x1 x2) (/ (- (f x2) (f x1)) (- x2 x1)))

;; number number --> number
;; Purpose: Approximate the slope of the secant line between the
;;          given x-values for f(x) = x^2
(define (x^2-secant-slope x1 x2) (f-sec-slope sqr x1 x2))

;; Sample expressions for x^2-secant-slope
(define MSEC1 (/ (- (sqr 4) (sqr 2)) (- 4 2)))
(define MSEC2 (/ (- (sqr 3.75) (sqr -2.03)) (- 3.75 -2.03)))

;; Tests using sample computations for x^2-secant-slope
(check-within (x^2-secant-slope 2 4)        MSEC1 0.01)
(check-within (x^2-secant-slope -2.03 3.75) MSEC2 0.01)

;; Tests using sample values for x^2-secant-slope
(check-within (x^2-secant-slope 1.5 3.2) 4.7 0.01)


;; number number --> number
;; Purpose: Approximate the slope of the secant line between the
;;          given x-values for f(x) = x^3
(define (x^3-secant-slope x1 x2) (f-sec-slope cube x1 x2))

;; Sample expressions for x^2-secant-slope
(define MSEC3 (/ (- (cube 5)    (cube 1))    (- 5 1)))
(define MSEC4 (/ (- (cube 10.1) (cube -4.6)) (- 10.1 -4.6)))

;; Tests using sample computations for x^3-secant-slope
(check-within (x^3-secant-slope 1 5)       MSEC3 0.01)
(check-within (x^3-secant-slope -4.6 10.1) MSEC4 0.01)

;; Tests using sample values for x^3-secant-slope
(check-within (x^3-secant-slope 1.5 3.2) 17.29 0.01)





  