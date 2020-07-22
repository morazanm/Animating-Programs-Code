;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname area-washer) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Area of a washer

(define C-AREA5  (* pi (sqr 5)))
(define C-AREA18 (* pi (sqr 18)))

;; Tests using sample computations
(check-within (area-circle 5)  C-AREA5  0.01)
(check-within (area-circle 18) C-AREA18 0.01)

;; Tests using sample values
(check-within (area-circle 0)  0      0.01)
(check-within (area-circle 10) 314.15 0.01)

;; Real>=0 --> Real>= 0
;; Purpose: Compute the area of the circle with the given radius.
(define (area-circle a-radius)
  (* pi (sqr a-radius)))

(define W-AREA6-3 (- (area-circle 6) (area-circle 3)))
(define W-AREA15-9 (- (area-circle 15) (area-circle 9)))
(define W-AREA4-1 (- (area-circle 4) (area-circle 1)))

;; Tests using sample computations
(check-within (area-washer 6 3)  W-AREA6-3  0.01)
(check-within (area-washer 15 9) W-AREA15-9 0.01)
(check-within (area-washer 4 1)  W-AREA4-1  0.01)

;; Tests using sample values
(check-within (area-washer 0 0)  0  0.01)
(check-within (area-washer 10 0)  314.15  0.01)
(check-within (area-washer 7 4)  103.67  0.01)

;; Real>=0 Real>=0 --> Real>= 0
;; Purpose: Compute the area of the washer with the given radii.
;; ASSUMPTION: outer-radius >= inner-radius
(define (area-washer outer-radius inner-radius)
  (- (area-circle outer-radius) (area-circle inner-radius)))

