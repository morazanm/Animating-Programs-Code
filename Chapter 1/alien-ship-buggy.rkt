;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname alien-ship-buggy) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)

(define WIDTH 200)
(define HEIGHT 100)
(define E-SCENE (empty-scene WIDTH HEIGHT 'darkgreen))

(define ALIEN-SHIP0 (overlay (circle 7 'solid 'gray)
                             (rectangle 23 3 'solid 'gray)))

(define ALIEN-SHIP1 (overlay (circle 7 'solid 'pink)
                             (rectangle 23 3 'solid 'pink)))

(define ALIEN-SHIP2 (overlay (circle 7 'solid 'white)
                             (rectangle 23 3 'solid 'white)))

(define SCN0 (place-image ALIEN-SHIP0 15 30 E-SCENE))

(define SCN1 (place-image ALIEN-SHIP1 197 80 SCN0))

(define SCN2 (place-image ALIEN-SHIP2 (/ WIDTH 2) (/ HEIGHT 2)SCN1))