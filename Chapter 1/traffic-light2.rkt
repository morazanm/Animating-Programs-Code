;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define BACKGROUND (rectangle 60 180 'solid 'black))

(define R-ON (overlay (above (circle 25 'solid 'red)
                             (square 10 'solid 'transparent)
                             (circle 25 'outline 'yellow)
                             (square 10 'solid 'transparent)
                             (circle 25 'outline 'green))
                      BACKGROUND))

(define Y-ON (overlay (above (circle 25 'outline 'red)
                             (square 10 'solid 'transparent)
                             (circle 25 'solid 'yellow)
                             (square 10 'solid 'transparent)
                             (circle 25 'outline 'green))
                      BACKGROUND))

(define G-ON (overlay (above (circle 25 'outline 'red)
                             (square 10 'solid 'transparent)
                             (circle 25 'outline 'yellow)
                             (square 10 'solid 'transparent)
                             (circle 25 'solid 'green))
                      BACKGROUND))


;; A traffic light (tl) is a member of either
;;  1. [0..13]  --means the green light is on
;;  2. [14..27] --means the yellow light is on
;;  3. [28..41] --means the red light is on


;; STEP 2: Sample expressions for ticks to tl
(define TL-0 (remainder 11  42))
(define TL-1 (remainder 60  42))
(define TL-2 (remainder 123 42))

;; STEP 5: Tests using sample expressions
(check-expect (tick->tl 11) TL-0)
(check-expect (tick->tl 60) TL-1)
(check-expect (tick->tl 123) TL-2)

;; STEP 5: Tests using sample values
(check-expect (tick->tl 0) 0)
(check-expect (tick->tl 325) 31)
(check-expect (tick->tl 650) 20)

#|
STEP 3:
;; tick --> tl
;; Purpose: Convert the given tick to a tl
|#
;; STEPS 4 and 6
(define (tick->tl a-tick)
  (remainder a-tick 42))

;; STEP 5: Tests using sample values
(check-expect (image-of-tl 10) G-ON)
(check-expect (image-of-tl 22) Y-ON)
(check-expect (image-of-tl 37) R-ON)

#|
STEP 3:
;; tl --> image
;; Purpose: To return the traffic light image for the given tl
|#
;; STEPS 4 and 6
(define (image-of-tl a-tl)
  (cond [(<= 0 a-tl 13)  G-ON]
        [(<= 14 a-tl 27) Y-ON]
        [else R-ON]))

;; Sample expressions for ticks to images
(define TICK9-IMG (image-of-tl (tick->tl 9)))
(define TICK57-IMG (image-of-tl (tick->tl 57)))
(define TICK36-IMG (image-of-tl (tick->tl 36)))

;; Tests using sample expressions for ticks to images
(check-expect (draw-tick 9)  TICK9-IMG)
(check-expect (draw-tick 57) TICK57-IMG)
(check-expect (draw-tick 36) TICK36-IMG)

;; Tests using sample values for ticks to images
(check-expect (draw-tick 145) Y-ON)
(check-expect (draw-tick 170) G-ON)
(check-expect (draw-tick 114) R-ON)

;; tick --> image
;; Purpose: Compute the traffic light image for the given tick
(define (draw-tick a-tick)
  (image-of-tl (tick->tl a-tick)))

(animate draw-tick)

