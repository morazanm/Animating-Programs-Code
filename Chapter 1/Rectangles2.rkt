;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Rectangles2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Area = width * height
;; Perimeter = (2 * width) + (2 * height)

;; Area for rectangle 1
(define AREA1 (* 3 4))

(check-expect AREA1 12)

;; Perimeter for rectangle 1
(define PERIM1 (+ (* 2 3) (* 2 4)))

(check-expect PERIM1 14)

;; Area for rectangle 2
(define AREA2 (* 2 5))

(check-expect AREA2 10)

;; Perimeter for rectangle 2
(define PERIM2 (+ (* 2 2) (* 2 5)))

(check-expect PERIM2 14)

;; Area for rectangle 3
(define AREA3 (* 2 2))

(check-expect AREA3 4)

;; Perimeter for rectangle 3
(define PERIM3 (+ (* 2 2) (* 2 2)))

(check-expect PERIM3 8)



