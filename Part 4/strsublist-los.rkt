;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname strsublist-los) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; (X --> Boolean) X (listof X) --> (listof X)
;; Purpose: To return the sublist of the given list that starts with
;;          the first element that satisfies the given predicate.
(define (pred-sublist pred x a-lox)
  (cond [(empty? a-lox) '()]
        [(pred x (first a-lox)) a-lox]
        [else (pred-sublist pred x (rest a-lox))]))

;; Sample instances of los
(define LOS1 '())
(define LOS2 '("Matthias" "Shriram" "Matthew" "Robby"))

;; string los --> los
;; Purpose: To return the sublist of the given los that starts
;; with the first instance of the given string.
(define (strsublist-los a-str a-los) (pred-sublist string=? a-str a-los))

;; Sample expressions for strsublist-los
(define STRSUBLIST-LOS1-VAL (pred-sublist string=? "Janice"   LOS1))
(define STRSUBLIST-LOS2-VAL (pred-sublist string=? "Matthias" LOS2))

;; Tests using sample computations for strsublist-los
(check-expect (strsublist-los "Janice"   LOS1) STRSUBLIST-LOS1-VAL)
(check-expect (strsublist-los "Matthias" LOS2) STRSUBLIST-LOS2-VAL)

;; Tests using sample values for xsublist-lon
(check-expect (strsublist-los "Eladio" '("Roberto" "Eladio" "Marco" "Eladio"))
              '("Eladio" "Marco" "Eladio"))
(check-expect (strsublist-los "zed" '("u" "v" "x" "y" "z" "ZED")) '())
