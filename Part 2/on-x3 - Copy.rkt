;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname on-x3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
;; DATA DEFINITIONS and SAMPLE INSTANCES

;; An x-coordinate (xcoord) is an integer
;; Sample instances of xcoord
(define AN-XCOORD ...) 
     ...

;; A y-coordinate (ycoord) is an integer
;; Sample instances of ycoord
(define A-YCOORD ...) 
     ...
     
;; A 2D-point is a structure, (make-posn a b), where a is an xcoord and b is a ycoord.
;; Sample instances of 2D-point
(define A-2D-POINT ...) 
     ...


;; FUNCTION TEMPLATES

;; xcoord ... --> ...
;; Purpose: ...
(define (f-on-xcoord an-xcoord ...)
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
(define (f-on-ycoord a-ycoord ...)
  ...a-ycoord...)

;; Sample expressions for f-on-ycoord
(define YCOORD-VAL ...)
     ...

;; Tests using sample computations for f-on-ycoord
(check-expect (f-on-ycoord ...) YCOORD-VAL)
     ...

;; Tests using sample values for f-on-ycoord
(check-expect (f-on-ycoord ...) ...)
     ...


A 2D-point is a structure, (make-posn a b), where a is an
xcoord and b is a ycoord.

;; 2D-point ... --> ...
;; Purpose: ...
(define (f-on-2D-point a-2Dpoint ...)
  ...(f-on-xcoord (posn-x a-2Dpoint))...
  ...(f-on-ycoord (posn-y a-2Dpoint))...)

;; Sample expressions for f-on-2D-point
(define 2D-POINT-VAL ...)

;; Tests using sample computations for f-on-2D-point
(check-expect (f-on-2D-point ...) 2D-POINT-VAL)
     ...

;; Tests using sample values for f-on-2D-point
(check-expect (f-on-2D-point ...) ...)

|#
(define X1 3)
(define X2 -2.5)

(define Y1 27)
(define Y2 39)

(define 2D-POINT1 (make-posn X1 Y1))
(define 2D-POINT2 (make-posn X2 Y2))

;; xcoord --> xcoord
;; Purpose: To cube the given xcoord
(define (cube an-xcoord)
  (expt an-xcoord 3))

;; Sample expressions for f-on-xcoord
(define XCOORD-VAL1 (expt -2 3))
(define XCOORD-VAL2 (expt 8 3))

;; Tests using sample computations for f-on-xcoord
(check-expect (cube -2) XCOORD-VAL1)
(check-expect (cube  8) XCOORD-VAL2)

;; Tests using sample values for f-on-xcoord
(check-expect (cube 0) 0)
(check-within (cube -2.5) -15.62 0.01) 

;; 2D-point --> Boolean
;; Purpose: Determine if the given point is on the graph of f(x) = x^3
(define (on-x^3? a-2Dpoint)
  (= (cube (posn-x a-2Dpoint)) (posn-y a-2Dpoint)))

;; Sample expressions for on-x^3?
(define 2D-POINT1-VAL (= (cube (posn-x 2D-POINT1)) (posn-y 2D-POINT1)))
(define 2D-POINT2-VAL (= (cube (posn-x 2D-POINT2)) (posn-y 2D-POINT1)))

;; Tests using sample computations for on-x^3?
(check-expect (on-x^3? 2D-POINT1) 2D-POINT1-VAL)
(check-expect (on-x^3? 2D-POINT2) 2D-POINT2-VAL)

;; Tests using sample values for on-x^3?
(check-expect (on-x^3? (make-posn 0 0)) #true)
(check-expect (on-x^3? (make-posn -3.3 -35.937 )) #true)
(check-expect (on-x^3? (make-posn 5 25)) #false)



