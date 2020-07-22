;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rotate-rocket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define FUSELAGE (ellipse 20 40 'solid 'green))
(define FUSELAGE-W (image-width FUSELAGE))
(define FUSELAGE-H (image-width FUSELAGE))
(define WINDOW  (ellipse 10 15 'solid 'darkgray))
(define BOOSTER (rotate 180 (triangle 10 'solid 'red)))
(define NACELLE (overlay (beside BOOSTER BOOSTER)
                         (rectangle (* 1.3 FUSELAGE-W)
                                    (* 0.3 FUSELAGE-H)
                                    'solid
                                    'red)))
(define NACELLE-W (image-width NACELLE))
(define NACELLE-H (image-height NACELLE))
(define ROCKET-IMG (overlay/xy NACELLE
                               (/ NACELLE-W 10)
                               (* -1.7 FUSELAGE-H)
                               (overlay/xy WINDOW
                                           (/ FUSELAGE-W -4)
                                           (/ FUSELAGE-H -10)
                                           FUSELAGE)))
#|
   STEP 1: DATA DEFINITIONS

;; An alphanumeric keystroke (aks) is a member of either:
;;  1. ["a".."z"] -- means a letter keystroke
;;  2. ["0".."9"] -- means a numeric keystroke

;; A change image keystroke (ciks) is either:
;;  1. "right" -- means rotate image 90 degrees clockwise
;;  2. "down"  -- means rotate image 180 degrees
;;  3. "left"  -- means rotate image 90 degrees counterclockwise 
;;  4. "up"    -- means double image size
;;  5. a ks    -- means do nothing to image

   STEP 2: FUNCTION TEMPLATES

;; ciks ... --> ...
;; Purpose: ...
(define (f-on-ciks a-ciks ...)
  (cond [(key=? a-ciks "right") ...]
        [(key=? a-ciks "down")  ...]
        [(key=? a-ciks "left")  ...]
        [(key=? a-ciks "up")    ...]
        [else ...]))

;; Sample expressions for f-on-ciks
(define CIKS-RIGHT ...)
(define CIKS-DOWN  ...)
(define CIKS-LEFT  ...)
(define CIKS-UP ...))
(define CIKS-ALPHANUM ...))

;; Tests for f-on-ciks using sample computations
(check-expect (f-on-ciks "right" ...) CIKS-RIGHT)
(check-expect (f-on-ciks "down" ...)  CIKS-DOWN)
(check-expect (f-on-ciks "left" ...)  CIKS-LEFT)
(check-expect (f-on-ciks "up" ...)    CIKS-UP)
(check-expect (f-on-ciks <aks> ...)   CIKS-ALPHANUM)

;; Tests for f-on-ciks using sample values
(check-expect (f-on-ciks "left" ...)  ...)
(check-expect (f-on-ciks "right" ...) ...)
(check-expect (f-on-ciks "down" ...)  ...)
(check-expect (f-on-ciks "up" ...)    ...)
(check-expect (f-on-ciks <aks> ...)   ...)


;; aks ... --> ...
;; Purpose: ...
(define (f-on-akks a-aks ...)
  (cond [(string<=? "a" a-aks "b") ...]
        [(string<=? "0" a-aks "9")  ...]))

;; Sample expressions for f-on-aks
(define AKS-LETTER ...) ;; for <aks1>
(define AKS-NUM  ...)   ;; <aks2>

;; Tests for f-on-aks using sample computations
(check-expect (f-on-aks <aks1> ...) AKS-LETTER)
(check-expect (f-on-aks <aks2> ...) AKS-NUM)

;; Tests for f-on-aks using sample values
(check-expect (f-on-aks <aks3> ...)  ...)
(check-expect (f-on-aks <aks4> ...) ...)               |#

#| STEP 3
   Use the functions rotate and scale to compute the new image
|#

;; STEP 5
;; image ciks --> image
;  Purpose: Rotate 90/180/270 degrees, double, or do nothing to the given image
;; STEP 6 and 8
(define (change-img an-img a-ciks)
  (cond [(key=? a-ciks "right") (rotate 90 an-img)]
        [(key=? a-ciks "down")  (rotate 180 an-img)]
        [(key=? a-ciks "left")  (rotate 270 an-img)]
        [(key=? a-ciks "up")    (scale 2 an-img)]
        [else an-img]))

;; STEP 4: Sample expressions for change-img
(define RRIGHT-RCKT (rotate 90 ROCKET-IMG))
(define RDOWN-RCKT  (rotate 180 ROCKET-IMG))
(define RLEFT-RCKT  (rotate 270 ROCKET-IMG))
(define DOUBLE-RCKT (scale 2 ROCKET-IMG))

;; STEP 7: TESTS
;; Tests for change-img using sample computations
(check-expect (change-img ROCKET-IMG "right") RRIGHT-RCKT)
(check-expect (change-img ROCKET-IMG "down")  RDOWN-RCKT)
(check-expect (change-img ROCKET-IMG "left")  RLEFT-RCKT)
(check-expect (change-img ROCKET-IMG "up")    DOUBLE-RCKT)
(check-expect (change-img ROCKET-IMG "m")     ROCKET-IMG)
;; Tests for change-img using sample values
(check-expect (change-img (rectangle 10 30 'solid 'red) "left")
              (rectangle 30 10 'solid 'red))
(check-expect (change-img (ellipse 75 35 'outline 'pink) "right")
              (ellipse 35 75 'outline 'pink))
(check-expect (change-img (triangle 25 'solid 'gold) "down")
              (flip-vertical (triangle 25 'solid 'gold)))
(check-expect (change-img (square 15 'outline 'green) "up")
              (square 30 'outline 'green))
(check-expect (change-img (star 10 'solid 'yellow) "y")
              (star 10 'solid 'yellow))
