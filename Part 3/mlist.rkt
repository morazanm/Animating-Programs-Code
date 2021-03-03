;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname mlist) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Sample instances of lon
(define ELON '())
(define HOURS-WORKED '(1 23 39 27))
(define HOURLY-RATES '(13 22 18 34))
(define QUANTITIES   '(10 3 86 27 8))
(define PRICES       '(80 50 5 10 20))

; mlist: (listof num) (listof num) --> (listof num)
; Purpose: Return a list with the products of corresponding elements in the given lists
; Assumption: The given lists are of the same length
(define (mlist l1 l2)
  (if (empty? l1)
      l1
      (cons (* (first l1) (first l2)) (mlist (rest l1) (rest l2)))))

;; Sample expressions for mlist
(define NOTHING '())
(define GROSSPAY (cons (*     (first HOURS-WORKED) (first HOURLY-RATES))
                       (mlist (rest HOURS-WORKED)  (rest HOURLY-RATES))))

(define TOTALS   (cons (*     (first QUANTITIES)   (first  PRICES))
                       (mlist (rest  QUANTITIES)   (rest   PRICES))))

;; Tests using sample computations for mlist
(check-expect (mlist ELON         '())          NOTHING)
(check-expect (mlist HOURS-WORKED HOURLY-RATES) GROSSPAY)
(check-expect (mlist QUANTITIES   PRICES)       TOTALS)

;; Tests using sample values for mlist
(check-expect (mlist '(1 2 3) '(1 2 3)) '(1 4 9))