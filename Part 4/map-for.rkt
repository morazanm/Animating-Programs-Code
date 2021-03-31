;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname map-for) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/abstraction)

;; <X Y> (X \arrow Y) (listof X) \arrow (listof Y)
;; Purpose: Return the values from applying the given function
;;          to the given list's elements
(define (map-f f a-lox)
  (for/list ([an-x a-lox])
            (f an-x)))

(check-expect (map-f add1 '()) '())
(check-expect (map-f add1 '(1 2 3)) '(2 3 4))