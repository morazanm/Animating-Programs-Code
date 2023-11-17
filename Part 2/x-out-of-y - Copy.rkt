;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname x-out-of-y) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; number>=0 number>=0 --> number
;; Purpose: Return x/y
(define (x-out-of-y x y)
  (if (> y 0)
      (/ x y)
      (error "x-out-of-y: y cannot be zero.")))

(check-expect (x-out-of-y 2 3)  2/3)
(check-expect (x-out-of-y 3 4)  3/4)
(check-error  (x-out-of-y 10 0) "x-out-of-y: y cannot be zero.")
