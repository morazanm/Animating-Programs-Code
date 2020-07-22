;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Rectangles1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Area = width * height
;; Perimeter = (2 * width) + (2 * height)

;; Area for rectangle 1
"The area for rectangle 1 is: "
(* 3 4)

(check-expect (* 3 4) 12)

;; Perimeter for rectangle 1
"The perimeter for rectangle 1 is: "
(+ (* 2 3) (* 2 4))

(check-expect (+ (* 2 3) (* 2 4)) 14)

;; Area for rectangle 2
"The area for rectangle 2 is: "
(* 2 5)

(check-expect (* 2 5) 10)

;; Perimeter for rectangle 2
"The perimeter for rectangle 2 is: "
(+ (* 2 2) (* 2 5))

(check-expect (+ (* 2 2) (* 2 5)) 14)

;; Area for rectangle 3
"The area for rectangle 3 is: "
(* 2 2)

(check-expect (* 2 2) 4)

;; Perimeter for rectangle 3
"The perimeter for rectangle 3 is: "
(+ (* 2 2) (* 2 2))

(check-expect (+ (* 2 2) (* 2 2)) 8)



