;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname flatten) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/abstraction)


;; Sample instances of (listof (listof symbol))
(define L0 '())
(define L1 '((a b c) (d e f g h) (i j)))


;; Sample expressions for flatten
(define L0-VAL (for*/list ([a-los L0] (a-symbol a-los))
                 a-symbol))
(define L1-VAL (for*/list ([a-los L1] (a-symbol a-los))
                 a-symbol))

;; (listof (listof symbol)) --> (listof symbol)
;; Purpose: Flatten the given (listof (listof symbol))
(define (flatten-lolos a-lolos)
  (for*/list ([a-los a-lolos] [a-symbol a-los])
    a-symbol))

;; Tests using sample computations for flatten-lolos
(check-expect (flatten-lolos L0) L0-VAL)
(check-expect (flatten-lolos L1) L1-VAL)

;; Tests using sample values for flatten-lolos
(check-expect (flatten-lolos '((x) (y) (z))) '(x y z))
(check-expect (flatten-lolos '((k l m n))) '(k l m n))
(check-expect (flatten-lolos '((o p) () (q r s t) (u)))
              '(o p q r s t u))

