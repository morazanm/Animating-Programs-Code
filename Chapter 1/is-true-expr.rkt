;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname is-true-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define A-STRING "This is not true.")
(define A-SYMBOL 'not-true)
(define A-NUMBER 87)
(define A-BOOL #true)
(define A-BOOL2 #false)
     
(define IS-TRUE-A-STRING (and (boolean? A-STRING) (not (false? A-STRING))))
(define IS-TRUE-A-SYMBOL (and (boolean? A-SYMBOL) (not (false? A-SYMBOL))))
(define IS-TRUE-A-NUMBER (and (boolean? A-NUMBER) (not (false? A-NUMBER))))
(define IS-TRUE-A-BOOL   (and (boolean? A-BOOL)   (not (false? A-BOOL))))
(define IS-TRUE-A-BOOL2  (and (boolean? A-BOOL2)  (not (false? A-BOOL2))))
     
(check-expect IS-TRUE-A-STRING #false)
(check-expect IS-TRUE-A-SYMBOL #false)
(check-expect IS-TRUE-A-NUMBER #false)
(check-expect IS-TRUE-A-BOOL #true)
(check-expect IS-TRUE-A-BOOL2 #false)

#|
;; Exercise

(define AND-FERR (and #false (/ 5 0)))
(define OR-FERR (or #false (string-append "Hi " "there!")))

(check-expect AND-FERR #false)
(check-expect OR-FERR #true)
|#