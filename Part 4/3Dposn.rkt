;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3Dposn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; A 3Dposn is a structure: (make-3Dposn number number number)
(define-struct 3Dposn (x y z))

;; Sample instances of 3Dposn
(define ORIGIN  (make-3Dposn 0 0 0))
(define A3DPOSN (make-3Dposn 2 3 5))

;; 3Dposn \arrow number
;; Purpose: Return the distance to the origin of the given 3Dposn
(define (dist-origin a-3dposn)
  (sqrt (+ (sqr (3Dposn-x a-3dposn))
           (sqr (3Dposn-y a-3dposn))
           (sqr (3Dposn-z a-3dposn)))))

;; Sample expressions for dist-origin
(define ORIGIND  (sqrt (+ (sqr (3Dposn-x ORIGIN))
                          (sqr (3Dposn-y ORIGIN))
                          (sqr (3Dposn-z ORIGIN)))))
(define A3DPOSND (sqrt (+ (sqr (3Dposn-x A3DPOSN))
                          (sqr (3Dposn-y A3DPOSN))
                          (sqr (3Dposn-z A3DPOSN)))))

;; Tests using sample computations for dist-origin
(check-within (dist-origin ORIGIN)  ORIGIND  0.01)
(check-within (dist-origin A3DPOSN) A3DPOSND 0.01)

;; Tests using sample values for dist-origin
(check-within (dist-origin (make-3Dposn 10 20 30))  37.42 0.01)