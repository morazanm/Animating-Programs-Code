;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname choose-f) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; number --> (number --> number)
;; Purpose: Return + if the given number is even. Otherwise, return -
(define (choose-f x) (if (even? x) + -))

(check-expect ((choose-f 4) 1 5) 6)
(check-expect ((choose-f 3) 1 5) -4)