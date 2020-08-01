;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname in-Q1-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|
;; DATA DEFINITIONS and SAMPLE INSTANCES

;; An integer x-coordinate (ixcoord) is an integer

;; An integer y-coordinate (iycoord) is an integer

;; A 2D-ipoint is a structure, (make-posn a b), where a is an ixcoord and
;;                                                    b is an iycoord.

;; ixcoord ... --> ...
;; Purpose: ...
(define (f-on-ixcoord an-ixcoord ...)
  ...an-ixcoord...)

;; Sample expressions for f-on-ixcoord
(define IXCOORD-VAL ...)

;; Tests using sample computations for f-on-ixcoord
(check-expect (f-on-ixcoord ...) IXCOORD-VAL)
  ...

;; Tests using sample values for f-on-ixcoord
(check-expect (f-on-ixcoord ...) ...)
  ...

;; iycoord ... --> ...
;; Purpose: ...
(define (f-on-iycoord a-iycoord ...)
  ...a-iycoord...)

;; Sample expressions for f-on-iycoord
(define IYCOORD-VAL ...)
  ...

;; Tests using sample computations for f-on-iycoord
(check-expect (f-on-iycoord ...) IYCOORD-VAL)
  ...

;; Tests using sample values for f-on-iycoord
(check-expect (f-on-iycoord ...) ...)
  ...

;; 2D-ipoint ... --> ...
;; Purpose: ...
(define (f-on-2D-ipoint a-2Dipoint ...)
  ...(f-on-ixcoord (posn-x a-2Dipoint))...
  ...(f-on-iycoord (posn-y a-2Dipoint))...)

;; Sample expressions for f-on-2D-ipoint
(define 2D-IPOINT-VAL ...)
  ...

;; Tests using sample computations for f-on-2D-ipoint
(check-expect (f-on-2D-ipoint ...) 2D-IPOINT-VAL)
  ...

;; Tests using sample values for f-on-2D-ipoint
(check-expect (f-on-2D-ipoint ...) ...)
  ...

|#

;; Sample instances of ixcoord
(define AN-IXCOORD1 3)
(define AN-IXCOORD2 -5)

;; Sample instances of iycoord
(define AN-IYCOORD1 11)
(define AN-IYCOORD2 23)

;; Sample instances of 2D-ipoint
(define A-2D-IPOINT1 (make-posn AN-IXCOORD1 AN-IYCOORD1))
(define A-2D-IPOINT2 (make-posn AN-IXCOORD2 AN-IYCOORD2))

;; ixcoord --> Boolean
;; Purpose: To determine if the given ixcoord is in the Q1 range
(define (ixcoord-in-Q1? an-ixcoord)
  (> an-ixcoord 0))

;; Sample expressions for ixcoord-in-Q1?
(define IXCOORD-VAL1 (> AN-IXCOORD1 0))
(define IXCOORD-VAL2 (> AN-IXCOORD2 0))

;; Tests using sample computations for ixcoord-in-Q1?
(check-expect (ixcoord-in-Q1? AN-IXCOORD1) IXCOORD-VAL1)
(check-expect (ixcoord-in-Q1? AN-IXCOORD2) IXCOORD-VAL2)

;; Tests using sample values for ixcoord-in-Q1?
(check-expect (ixcoord-in-Q1? 0) #false)
(check-expect (ixcoord-in-Q1? 19380) #true)

;; iycoord --> Boolean
;; Purpose: To determine if the given iycoord is in the Q1 range
(define (iycoord-in-Q1? an-iycoord)
  (> an-iycoord 0))

;; Sample expressions for iycoord-in-Q1?
(define IYCOORD-VAL1 (> AN-IYCOORD1 0))
(define IYCOORD-VAL2 (> AN-IYCOORD2 0))

;; Tests using sample computations for iycoord-in-Q1?
(check-expect (iycoord-in-Q1? AN-IYCOORD1) IYCOORD-VAL1)
(check-expect (iycoord-in-Q1? AN-IYCOORD2) IYCOORD-VAL2)

;; Tests using sample values for iycoord-in-Q1?
(check-expect (iycoord-in-Q1? 0) #false)
(check-expect (iycoord-in-Q1? 19380) #true)


;; 2D-ipoint --> Boolean     
;; Purpose: To determine if the give 2D-ipoint is in the first quadrant
(define (in-Q1? a-2Dipoint)
  (and (ixcoord-in-Q1? (posn-x a-2Dipoint))
       (iycoord-in-Q1? (posn-y a-2Dipoint))))
  
;; Sample expressions for in-Q1?
(define 2D-IPOINT-VAL1 (and (ixcoord-in-Q1? (posn-x A-2D-IPOINT1))
                            (iycoord-in-Q1? (posn-y A-2D-IPOINT1))))

(define 2D-IPOINT-VAL2 (and (ixcoord-in-Q1? (posn-x A-2D-IPOINT2))
                            (iycoord-in-Q1? (posn-y A-2D-IPOINT2))))

;; Tests using sample computations for in-Q1?
(check-expect (in-Q1? A-2D-IPOINT1) 2D-IPOINT-VAL1)
(check-expect (in-Q1? A-2D-IPOINT2) 2D-IPOINT-VAL2)

;; Tests using sample values for in-Q1?
(check-expect (in-Q1? (make-posn -3 -7))   #false)
(check-expect (in-Q1? (make-posn 83 -4))   #false)
(check-expect (in-Q1? (make-posn 100 864)) #true)