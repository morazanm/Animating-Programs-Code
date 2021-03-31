;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname match-example) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/abstraction)

;; A student is a structure: (make-student string symbol number>=0)
(define-struct student (name year gpa))

(define X 42)
(define B "Basia Mucha")
(define DIMITROVA (make-student "Rositsa Abrasheva" 'senior 3.94))
(define BLST '(#true #true #true))
(define NLST '(1 2 3))
(define ELST '())


;; Any --> string
;; Purpose: Illustrate what is matched
(define (f a-value)
  (match a-value
    [42 "Matched 42"]
    [(? string?) (string-append "Matched a string: " a-value)]
    [(student n y g)
     (string-append "Matched a student whose gpa is: " (number->string g))]
    [(cons (? boolean?) r)
     (string-append "Matched a list that starts with a Boolean: "
                    (boolean->string (first a-value)))]
    [(cons B C) (format "Matched a list whose first element is: ~s" B)]
    [else "Nothing is matched."]))

;; Sample expressions for f
(define X-VAL "Matched 42")
(define B-VAL (string-append "Matched a string: " B))
(define DIMITROVA-VAL (string-append "Matched a student whose gpa is: " (number->string (student-gpa DIMITROVA))))
(define BLST-VAL (string-append "Matched a list that starts with a Boolean: "
                                (boolean->string (first BLST))))
(define NLST-VAL (format "Matched a list whose first element is: ~s" (first NLST)))
(define SQR-VAL "Nothing is matched.")
(define ELST-VAL (f ELST))

;; Tests using sample computations for f
(check-expect (f X)     X-VAL)
(check-expect (f B)     B-VAL)
(check-expect (f DIMITROVA)  DIMITROVA-VAL)
(check-expect (f BLST) BLST-VAL)
(check-expect (f NLST) NLST-VAL)
(check-expect (f ELST)   ELST-VAL)


;; Tests using sample computations for f
(check-expect (f "Matthew Flatt") "Matched a string: Matthew Flatt")
(check-expect (f (make-student "Robby Findler" 'freshman 4))
              "Matched a student whose gpa is: 4")
(check-expect (f '(#false)) "Matched a list that starts with a Boolean: #false")
(check-expect (f '("P. Achten" "J. Hughes" "P. Koopman"))
              "Matched a list whose first element is: \"P. Achten\"")
(check-expect (f (square 10 "solid" "green")) "Nothing is matched.")


    
    
    


      