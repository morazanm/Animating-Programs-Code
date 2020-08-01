;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname in-Q1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; xcoord ycoord --> Boolean
;; Purpose: To determine if the given coordinates for a point in Q1
(define (in-Q1? x y)
  (and (> x 0) (> y 0)))

;; Sample expression definitions for in-Q1?
(define CONSTANT-1 (and (> 3 0) (> 11 0)))
(define CONSTANT-2 (and (> -5 0) (> 23 0)))

;; Tests using sample computations for in-Q1?
(check-expect (in-Q1? 3 11)  CONSTANT-1)
(check-expect (in-Q1? -5 23) CONSTANT-2)

;; Tests using sample values for in-Q1?
(check-expect (in-Q1? -3 -7) #false)
(check-expect (in-Q1? 83 -4) #false)

#|
An x-coordinate (xcoord) is an integer

;; xcoord ... --> ...
;; Purpose: ...
(f-on-xcoord an-xcoord ...)
  ...an-xcoord...)

;; Sample expressions for f-on-xcoord
(define XCOORD-VAL ...)

;; Tests using sample computations for f-on-xcoord
(check-expect (f-on-xcoord ...) XCOORD-VAL)
     ...

;; Tests using sample values for f-on-xcoord
(check-expect (f-on-xcoord ...) ...)
     ...


A y-coordinate (ycoord) is an integer

;; ycoord ... --> ...
;; Purpose: ...
(f-on-ycoord a-ycoord ...)
  ...a-ycoord...)

;; Sample expressions for f-on-ycoord
(define YCOORD-VAL ...)

;; Tests using sample computations for f-on-ycoord
(check-expect (f-on-ycoord ...) YCOORD-VAL)
     ...

;; Tests using sample values for f-on-ycoord
(check-expect (f-on-ycoord ...) ...)

|#

