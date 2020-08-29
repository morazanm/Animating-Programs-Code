;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 2Dpoint) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
A 2Dpoint is a structure (make-2Dpoint number number).

;; 2Dpoint ... --> ...
;; Purpose: ...
(define (f-on-2Dpoint a-2dpoint ...)
  ...(2Dpoint-xval a-2dpoint)...(2Dpoint-yval a-2dpoint)...)

;; Sample Instances of 2Dpoint
(define P1 (make-2Dpoint ...))

;; Sample expressions for f-on-2Dpoint
(define 2DP-VAL1 ...)
     ...

;; Tests using sample computations for f-on-2Dpoint
(check-within (f-on-2Dpoint ...) 2DP-VAL1)
     ...

;; Tests using sample values for f-on-2Dpoint
(check-within (f-on-2Dpoint ...) ...)
     ...
|#

(define-struct 2Dpoint (xval yval))

;; Sample instances of 2Dpoint
(define P1 (make-2Dpoint 5 10))
(define P2 (make-2Dpoint 25 11))

(check-expect (2Dpoint-xval P1)  5)
(check-expect (2Dpoint-xval P2) 25)
(check-expect (2Dpoint-yval P1) 10)
(check-expect (2Dpoint-yval P2) 11)

;; 2Dpoint --> real-number
;; Purpose: To compute the distance to the origin for the given 2Dpoint
(define (distance-to-origin a-2dpoint)
  (sqrt (+ (sqr (2Dpoint-xval a-2dpoint))
           (sqr (2Dpoint-yval a-2dpoint)))))

;; Sample expressions for distance-to-origin
(define 2DP-VAL1 (sqrt (+ (sqr 5)  (sqr 10))))
(define 2DP-VAL2 (sqrt (+ (sqr 25) (sqr 11))))

;; Tests using sample computations for distance-to-origin
(check-within (distance-to-origin P1) 2DP-VAL1 0.01)
(check-within (distance-to-origin P2) 2DP-VAL2 0.01)

;; Tests using sample values for distance-to-origin
(check-within (distance-to-origin (make-2Dpoint  0  0)) 0 0.01)
(check-within (distance-to-origin (make-2Dpoint -3 -4)) 5 0.01)