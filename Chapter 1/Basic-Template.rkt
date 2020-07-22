;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Basic-Template) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|
(define CONSTANT-1 expr)
.
.
.
(define CONSTANT-N expr)

;; Tests using sample computations
(check-expect (f-on-args expr^+) CONSTANT-1)
.
.
.
(check-expect (f-on-args expr^+) CONSTANT-N)

;; Tests using sample values
(check-expect (f-on-args expr^+)value-1)
.
.
.
(check-expect (f-on-args expr^+) value-m)

;; types^+ --> type
;; Purpose:
(define (f-on-args var^+)
  ...)
|#