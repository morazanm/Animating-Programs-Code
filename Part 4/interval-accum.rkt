;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname interval-accum) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))




;; X Y --> number
;; Purpose

;; Sample instances of interval
(define PLOW1 1)
(define PHIGH1 0)
(define PLOW2 -3)
(define PHIGH2 5)
(define PLOW3 4)
(define PHIGH3 7)

;; X (int --> Y) (Y X --> X) [int..int] --> X
;; Purpose: Compute the product of the squares of the ints in the given interval
(define (interval-accum-low2high base-val ffirst comb low high)
  (if (> low high)
      base-val
      (comb (ffirst low) (interval-accum-low2high base-val ffirst comb (add1 low) high))))


;; [int..int] --> (listof string)
;; Purpose: Construct the list of strings for the ints in the given interval
(define (interval->lostr low high)
  (interval-accum-low2high '() number->string cons low high))
      

;; Sample expressions for interval->lostr
(define PLOW1-PHIGH1-VAL '())
(define PLOW2-PHIGH2-VAL (cons (number->string PLOW2) (interval->lostr (add1 PLOW2) PHIGH2)))
(define PLOW3-PHIGH3-VAL (cons (number->string PLOW3) (interval->lostr (add1 PLOW3) PHIGH3)))

;; Tests using sample computations for interval->lostr
(check-expect (interval->lostr PLOW1 PHIGH1) PLOW1-PHIGH1-VAL)
(check-expect (interval->lostr PLOW2 PHIGH2) PLOW2-PHIGH2-VAL)
(check-expect (interval->lostr PLOW3 PHIGH3) PLOW3-PHIGH3-VAL)

;; Tests using sample values for interval->lostr
(check-expect (interval->lostr 3 5) '("3" "4" "5"))
(check-expect (interval->lostr 6 9) '("6" "7" "8" "9"))



;; [int..int] --> int
;; Purpose: Compute the product of the squares of the ints in the given interval
(define (interval-product-sqrs low high)
  (interval-accum-low2high 1 sqr * low high)) 

;; Sample expressions for interval-product-sqrs
(define PLOW1-PHIGH1-VAL1 1)
(define PLOW2-PHIGH2-VAL2 (* (sqr PLOW2) (interval-product-sqrs (add1 PLOW2) PHIGH2)))
(define PLOW3-PHIGH3-VAL3 (* (sqr PLOW3) (interval-product-sqrs (add1 PLOW3) PHIGH3)))

;; Tests using sample computations for interval-product-sqrs
(check-expect (interval-product-sqrs PLOW1 PHIGH1) PLOW1-PHIGH1-VAL1)
(check-expect (interval-product-sqrs PLOW2 PHIGH2) PLOW2-PHIGH2-VAL2)
(check-expect (interval-product-sqrs PLOW3 PHIGH3) PLOW3-PHIGH3-VAL3)

;; Tests using sample values for interval-product-sqrs
(check-expect (interval-product-sqrs 3 5) 3600)
(check-expect (interval-product-sqrs 6 9) 9144576)

