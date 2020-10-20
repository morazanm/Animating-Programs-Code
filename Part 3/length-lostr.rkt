;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname length-lostr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

     ;; Sample instaces of a (listof string)
     (define E-LOSTR   '())
     (define NE-LOSTR  '("Here" "is" "a" "sigh" "for" "those" "that" "love" "me"))
     (define NE-LOSTR2 '("And" "a" "smile" "for" "to" "those" "who" "hate"))

     ;; (listof string) --> lon
     ;; Purpose: Return a list of the string lengths in the given (listof string)
     (define (lengths-lostr a-lostr)
       (if (empty? a-lostr)
           '()
           (cons (string-length (first a-lostr))
                 (lengths-lostr  (rest a-lostr)))))
    
     ;; Sample expressions for lengths-lostr
     (define E-LOSTR-VAL E-LOSTR)
     (define NE-LOSTR-VAL  (cons (string-length (first NE-LOSTR))
                                 (lengths-lostr  (rest NE-LOSTR))))
     (define NE-LOSTR2-VAL (cons (string-length (first NE-LOSTR))
                                 (lengths-lostr  (rest NE-LOSTR))))
  
     ;; Tests using sample computations for lengths-lostr
     (check-expect (lengths-lostr E-LOSTR)  E-LOSTR-VAL)
     (check-expect (lengths-lostr NE-LOSTR) NE-LOSTR-VAL)

     ;; Tests using sample values for lengths-lostr
     (check-expect (lengths-lostr (list "And" "whatever" "sky's" "above" "me"))
                   (list 3 8 5 5 2))
     (check-expect (lengths-lostr (list "Here's" "a" "heart" "for" "every" "fate"))
                   (list 6 1 5 3 5 4))