;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname circumference2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; The circumference of a circle with raduius r is 2 * pi * r

; The circumference of a circle with radius 7
(define CIRCUM-7 (* 2 pi 7))

(check-within CIRCUM-7 43.98 0.01)

