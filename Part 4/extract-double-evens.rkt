;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname extract-double-evens) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/abstraction)


;; Sample instances of lon
(define ELON '())
(define LON1 '(0 1 2 3 4 5))
(define LON2 '(7 8 9))

;; (listof number) --> (listof number)
;; Purpose: Return a list of doubled evens in the given list
(define (extract-double-evens a-lon)
  (match a-lon
    ['() '()]
    [(cons (? even?) rlon)
     (cons (* 2 (first a-lon)) (extract-double-evens rlon))]
    [(cons flon rlon) (extract-double-evens rlon)]))

;; Sample expressions for extract-double-evens
(define ELON-VAL '())
(define LON1-VAL (cons (* 2 (first LON1)) (extract-double-evens (rest LON1))))
(define LON2-VAL (extract-double-evens (rest LON2)))

;; Tests using sample computations for extract-double-evens
(check-expect (extract-double-evens ELON) ELON-VAL)
(check-expect (extract-double-evens LON1) LON1-VAL)
(check-expect (extract-double-evens LON2) LON2-VAL)

;; Tests using sample values for extract-double-evens
(check-expect (extract-double-evens '(-3 -7 -11)) '())
(check-expect (extract-double-evens '(88 10 120)) '(176 20 240))
(check-expect (extract-double-evens '(1 2 4 8))   '(4 8 16))
