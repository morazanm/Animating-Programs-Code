;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname selctors-img) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Star tests
(check-expect (* 2 STAR-HALF-W) STAR-W)
(check-expect (* 2 STAR-HALF-H) STAR-H)
(check-expect (/ STAR-PIXELS STAR-W) STAR-H)
(check-expect (/ STAR-PIXELS STAR-H) STAR-W)

; Rhombus tests
(check-expect (* 2 RHOMBUS-HALF-W) RHOMBUS-W)
(check-expect (* 2 RHOMBUS-HALF-H) RHOMBUS-H)
(check-expect (/ RHOMBUS-PIXELS RHOMBUS-W) RHOMBUS-H)
(check-expect (/ RHOMBUS-PIXELS RHOMBUS-H) RHOMBUS-W)

(define A-STAR-IMG   (radial-star 10 5 35 'outline 'gold))
(define A-RHOMBUS-IMG (rhombus 60 75 'solid 'red))

;; Star computations
(define STAR-W (image-width A-STAR-IMG))
(define STAR-H (image-height A-STAR-IMG))

(define STAR-HALF-W (/ STAR-W 2))
(define STAR-HALF-H (/ STAR-H 2))
(define STAR-PIXELS (* STAR-W STAR-H))

;; Rhombus computations
(define RHOMBUS-W (image-width A-RHOMBUS-IMG))
(define RHOMBUS-H (image-height A-RHOMBUS-IMG))

(define RHOMBUS-HALF-W (/ RHOMBUS-W 2))
(define RHOMBUS-HALF-H (/ RHOMBUS-H 2))
(define RHOMBUS-PIXELS (* RHOMBUS-W RHOMBUS-H))



