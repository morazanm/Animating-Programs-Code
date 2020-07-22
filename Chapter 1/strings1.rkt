;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname strings1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define CAT "cat")

(check-expect CAT (string-append "c" "a" "t"))
(check-expect (substring CAT 0 1) "c")
(check-expect (substring CAT 1 2) "a")
(check-expect (substring CAT 2 3) "t")
(check-expect (substring CAT 3 3) "")
(check-expect (substring CAT 0) CAT)
