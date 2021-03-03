;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname merge) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Sample instances of lon
(define ELON '())
(define SL1  '(1 22 30))
(define SL2  '(13 22 108 346))
(define SL3  '(-89 -50 0 6 90))
(define SL4  '(-240))

;; (listof num) (listof num) --> (listof num)
;; Purpose: Return a list sorted in nondecreasing order that only contains all the elements of the given lists
;; Assumption: The given lists are sorted in nondecreasing order
(define (merge sl1 sl2)
  (cond [(and (empty? sl1) (empty? sl2)) '()]
        [(and (empty? sl1) (cons? sl2))  sl2]
        [(and (cons? sl1)  (empty? sl2)) sl1]
        [else (if (<= (first sl1) (first sl2))
                  (cons (first sl1) (merge (rest sl1) sl2))
                  (cons (first sl2) (merge sl1 (rest sl2))))]))

;; Sample expressions for merge
(define ELON-ELON-VAL '())
(define ELON-SL1-VAL SL1)
(define ELON-SL2-VAL SL2)
(define SL3-ELON-VAL SL3)
(define SL4-ELON-VAL SL4)
(define SL1-SL2-VAL (cons (first SL1) (merge (rest SL1) SL2)))
(define SL3-SL2-VAL (cons (first SL3) (merge (rest SL3) SL2)))
(define SL3-SL4-VAL (cons (first SL4) (merge SL3 (rest SL4))))
(define SL1-SL4-VAL (cons (first SL4) (merge SL1 (rest SL4))))

;; Tests using sample computations for merge
(check-expect (merge ELON ELON) ELON-ELON-VAL)
(check-expect (merge ELON SL1)  ELON-SL1-VAL)
(check-expect (merge ELON SL2)  ELON-SL2-VAL)
(check-expect (merge SL3 ELON)  SL3-ELON-VAL)
(check-expect (merge SL4 ELON)  SL4-ELON-VAL)
(check-expect (merge SL1 SL2)   SL1-SL2-VAL)
(check-expect (merge SL3 SL2)   SL3-SL2-VAL)
(check-expect (merge SL3 SL4)   SL3-SL4-VAL)
(check-expect (merge SL1 SL4)   SL1-SL4-VAL)

;; Tests using sample values for merge
(check-expect (merge '() '()) '())
(check-expect (merge '() '(8 77)) '(8 77))
(check-expect (merge '(43 67 91) '())  '(43 67 91))
(check-expect (merge '(15 31 67) '(22 44 87 100)) '(15 22 31 44 67 87 100))
(check-expect (merge '(66 99) '(1 56 83)) '(1 56 66 83 99))