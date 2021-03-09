;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname contains) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

     ;; contains?: symbol (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains the given symbol
     (define (contains? a-symbol a-los)
 	  (and (not (empty a-los))
           (or (symbol=? (first a-los) a-symbol)
               (contains? a-symbol (rest a-los)))))


     ;; contains-laptop?: (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains 'laptop
     (define (contains-laptop? a-los) (contains? 'laptop a-los))

     ;; contains-pen?: (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains 'pen
     (define (contains-pen? a-los) (contains? 'pen a-los))


     ;; contains-book?: (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains 'book
     (define (contains-book? a-los) (contains? 'book a-los))

     ;; contains-keys?: (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains 'keys
     (define (contains-keys? a-los) (contains? 'keys a-los))
     
     ;; contains-money?: (listof symbol) --> Boolean
     ;; Purpose: Determine if the given list contains 'money
     (define (contains-money? a-los) (contains? 'money a-los))

