;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname filter) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; (X --> Boolean) (listof X) --> (listof X)
;; Purpose: Return the elements in the given list that satisfy the given predicate
(define (filter-pred pred a-lox)
  (cond [(empty? a-lox) '()]
        [(pred (first a-lox))
         (cons (first a-lox) (filter-pred pred (rest a-lox)))]
        [else (filter-pred pred (rest a-lox))]))


;; Sample instances of lon
(define LON1 '())
(define LON2 '(0 1 2 -3 4 5 -6 7 8 9))
(define LON3 '(11 75 -31 49))

;; lon --> lon
;; Purpose: To return list of the even numbers in the given list
(define (extract-evens a-lon) (filter-pred even? a-lon))

;; Sample expressions for extract-evens
(define LON1-VAL '())
(define LON2-VAL (cons (first LON2) (extract-evens (rest LON2))))
(define LON3-VAL (extract-evens (rest LON3)))

;; Tests using sample computations for extract-evens
(check-expect (extract-evens LON1) LON1-VAL)
(check-expect (extract-evens LON2) LON2-VAL)
(check-expect (extract-evens LON3) LON3-VAL)

;; Tests using sample values for extract-evens
(check-expect (extract-evens '(2 4 6 8)) '(2 4 6 8))
(check-expect (extract-evens '(-71 -9 -909 -55)) '())


;; Sample instances of los
(define ELOS '())
(define LOS1 (list (make-posn 8 0) (make-posn 10 5)))
(define LOS2 (list 'NO-SHOT (make-posn 1 2)  'NO-SHOT (make-posn 7 4) 'NO-SHOT))

;; los --> los
;; Purpose: To return list of posn shots in the given list
(define (extract-posn-shots a-los) (filter-pred posn? a-los))

;; Sample expressions for extract-posn-shots
(define ELOS-VAL '())
(define LOS1-VAL (cons (first LOS1) (extract-posn-shots (rest LOS1))))
(define LOS2-VAL (extract-posn-shots (rest LOS2)))

;; Tests using sample computations for extract-posn-shots
(check-expect (extract-posn-shots ELOS) ELOS-VAL)
(check-expect (extract-posn-shots LOS1) LOS1-VAL)
(check-expect (extract-posn-shots LOS2) LOS2-VAL)

;; Tests using sample values for extract-evens
(check-expect (extract-posn-shots '(NO-SHOT NO-SHOT)) '())
(check-expect (extract-posn-shots (list (make-posn 4 5) 'NO-SHOT (make-posn 2 2)))
                                  (list (make-posn 4 5) (make-posn 2 2)))

