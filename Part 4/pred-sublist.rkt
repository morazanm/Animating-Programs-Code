;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname pred-sublist) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; X Y --> Boolean
;; Purpose: To determine is the given values are not equal?
(define (not-equal? v1 v2) (not (equal? v1 v2)))

;; Sample expressions for not-equal?
(define VAL1 (not (equal? 5 3)))
(define VAL2 (not (equal? '(1 2) '(1 2))))

;; Tests using sample computations for not-equal?
(check-expect (not-equal? 5 3)           VAL1)
(check-expect (not-equal? '(1 2) '(1 2)) VAL2)

;; Tests using sample values for not-equal?
(check-expect (not-equal? "MATTHIAS" "SHRIRAM") #true)
(check-expect (not-equal? (make-posn (sub1 1) 10) (make-posn 0 (+ 5 5))) #false)


;; (X --> Boolean) X (listof X) --> (listof X)
;; Purpose: To return the sublist of the given list that starts with
;;          the first element that satisfies the given predicate.
(define (pred-sublist pred x a-lox)
  (cond [(empty? a-lox) '()]
        [(pred x (first a-lox)) a-lox]
        [else (pred-sublist pred x (rest a-lox))]))

;; Sample instances of lon
(define LON1 '())
(define LON2 '(1 2 3 4))

;; number lon --> lon
;; Purpose: To return the sublist of the given lon that starts
;; with the first instance of the given number.
(define (xsublist-lon x a-lon) (pred-sublist equal? x a-lon))

;; Sample expressions for xsublist-lon
(define XSUBLIST-LON1-VAL '())
(define XSUBLIST-LON2-VAL1 LON2)
(define XSUBLIST-LON2-VAL2 (xsublist-lon 3 (rest LON2)))
(define XSUBLIST-LON2-VAL3 (xsublist-lon 0 (rest LON2)))

;; Tests using sample computations for xsublist-lon
(check-expect (xsublist-lon 7 LON1) XSUBLIST-LON1-VAL)
(check-expect (xsublist-lon 1 LON2) XSUBLIST-LON2-VAL1)
(check-expect (xsublist-lon 3 LON2) XSUBLIST-LON2-VAL2)
(check-expect (xsublist-lon 0 LON2) XSUBLIST-LON2-VAL3)

;; Tests using sample values for xsublist-lon
(check-expect (xsublist-lon 99 '(96 97 99 100)) '(99 100))
(check-expect (xsublist-lon 87 '(86 47 10)) '())


;; number lon --> lon
;; Purpose: To return the sublist of the given lon that starts
;; with the first number not equal to the given number.
(define (nonxsublist-lon x a-lon) (pred-sublist not-equal? x a-lon))

;; Sample expressions for xsublist-lon
(define NXSUBLIST-LON1-VAL '())
(define NXSUBLIST-LON2-VAL1 LON2)
(define NXSUBLIST-LON2-VAL3 (nonxsublist-lon 3 (rest LON2)))


;; Tests using sample computations for xsublist-lon
(check-expect (nonxsublist-lon 7 LON1) NXSUBLIST-LON1-VAL)
(check-expect (nonxsublist-lon 3 LON2) NXSUBLIST-LON2-VAL1)
(check-expect (nonxsublist-lon 1 LON2) NXSUBLIST-LON2-VAL3)


;; Tests using sample values for xsublist-lon
(check-expect (nonxsublist-lon 99 '(99 99 99 100)) '(100))
(check-expect (nonxsublist-lon 84 '(84 84)) '())


