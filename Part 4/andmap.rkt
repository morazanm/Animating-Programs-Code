;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname andmap) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; (X --> Boolean) (listof X) --> Boolean
;; Purpose: Determine if the elements of the list satisfy the given predicate
(define (andmap-pred pred a-lox)
  (or (empty? a-lox)
      (and (pred (first a-lox))
           (andmap-pred pred (rest a-lox)))))

;; Sample instances of lon
(define E-LON '())
(define AE-LON '(88 98 22 78 506))
(define NAE-LON '(8 561 683 788))

;; lon --> Boolean
;; Purpose: To determine if the given lon only has even numbers
(define (all-even-lon? a-lon)
  (andmap-pred even? a-lon))

;; Sample expressions for all-even-lon?
(define E-LON-VAL (or (empty? E-LON)
                      (and (even? (first E-LON))
                           (all-even-lon? (rest E-LON)))))
(define AE-LON-VAL (or (empty? AE-LON)
                       (and (even? (first AE-LON))
                            (all-even-lon? (rest AE-LON)))))
(define NAE-LON-VAL (or (empty? NAE-LON)
                        (and (even? (first NAE-LON))
                             (all-even-lon? (rest NAE-LON)))))

;; Tests using sample computations for all-even-lon?
(check-expect (all-even-lon? E-LON) E-LON-VAL)
(check-expect (all-even-lon? AE-LON) AE-LON-VAL)
(check-expect (all-even-lon? NAE-LON) NAE-LON-VAL)

;; Tests using sample values for all-even-lon?
(check-expect (all-even-lon? '(9 1 7)) #false)
(check-expect (all-even-lon? '(4 6 8)) #true)


;; Sample instances of lostr
(define ELOS '())
(define LASS '("Argie" "Darla"))
(define WCLB '("Kostas" "Andrew" "Diego" "Marco"))

;; string --> Boolean
;; Purpose: Determine if the length of the given string is <= 5
(define (string-len<5? a-str) (<= (string-length a-str) 5))
     
;; (listof string) --> Boolean
;; Purpose: Determine if the given (listof string) only has strings of length <= 5
(define (string-all-len<5? a-lostr)
  (andmap-pred string-len<5? a-lostr))

;; Sample expressions for string-all-len<5?
(define ELOS-VAL (or (empty? ELOS)
                      (and (string-len<5? (first ELOS))
                           (string-all-len<5? (rest ELOS)))))
(define LASS-VAL (or (empty? LASS)
                       (and (string-len<5? (first LASS))
                            (string-all-len<5? (rest LASS)))))
(define WCLB-VAL (or (empty? WCLB)
                        (and (string-len<5? (first WCLB))
                             (string-all-len<5? (rest WCLB)))))

;; Tests using sample computations for string-all-len<5?
(check-expect (string-all-len<5? ELOS) ELOS-VAL)
(check-expect (string-all-len<5? LASS) LASS-VAL)
(check-expect (string-all-len<5? WCLB) WCLB-VAL)

;; Tests using sample values for string-all-len<5?
(check-expect (string-all-len<5? '("Joanie" "Basia" "Rositsa" "Josie")) #false)
(check-expect (string-all-len<5? '("Josh" "Sach" "Peter")) #true)