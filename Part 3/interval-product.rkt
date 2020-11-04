;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname interval-product) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
     An interval ([low..high]) is two integers such that it is either:
       1. empty     (interpretation: low > high)
       2. non-empty (interpretation: low \(\leq\) high)
          [[low..(sub1 high)] high] or [low [(add1 low)..high]

     ;; Sample instances of interval
     (define LOW1  ...)
     (define HIGH1 ...)
     (define LOW2  ...)
     (define HIGH2 ...)
          ...

     ;; [int..int] ... --> ...
     ;; Purpose: ...
     (define (f-on-interval low high ...)
       (if (> low high)
           ...
           (...high...(f-on-interval low       (sub1 high)...
            ...low....(f-on-interval (add1 low) high)...)))

     ;; Sample expressions for f-on-interval
     (define LOW1-HIGH1-VAL ...)
     (define LOW2-HIGH2-VAL ...)
          ...

     ;; Tests using sample computations for f-on-interval
     (check-expect (f-on-interval LOW1 HIGH1 ...) LOW1-HIGH1-VAL)
     (check-expect (f-on-interval LOW2 HIGH2 ...) LOW2-HIGH2-VAL)
          ...

     ;; Tests using sample values for f-on-interval
     (check-expect (f-on-interval ...) ...)
     (check-expect (f-on-interval ...) ...)
          ...

|#

     ;; Sample instances of interval
     (define LOW1   1)
     (define HIGH1  0)
     (define LOW2  -3)
     (define HIGH2  5)
     (define LOW3   4)
     (define HIGH3  7)

     ;; [int..int] --> int
     ;; Purpose: Compute the product of the ints in the given interval
     (define (interval-product low high)
       (if (> low high)
           1
           (* high (interval-product low (sub1 high)))))

     ;; Sample expressions for f-on-interval
     (define LOW1-HIGH1-VAL 1)
     (define LOW2-HIGH2-VAL (* HIGH2 (interval-product LOW2 (sub1 HIGH2))))
     (define LOW3-HIGH3-VAL (* HIGH3 (interval-product LOW3 (sub1 HIGH3))))

     ;; Tests using sample computations for interval-product
     (check-expect (interval-product LOW1 HIGH1) LOW1-HIGH1-VAL)
     (check-expect (interval-product LOW2 HIGH2) LOW2-HIGH2-VAL)
     (check-expect (interval-product LOW3 HIGH3) LOW3-HIGH3-VAL)

     ;; Tests using sample values for interval-product
     (check-expect (interval-product 3 5) 60)
     (check-expect (interval-product 6 9) 3024)


     ;; Sample intances of natnum
(define ZERO  0)
(define TEN   10)
(define FIFTY 50)

;; natnum --> natnum
;; Purpose: Compute the factorial of the given natnum
(define (factorial a-natnum)
  (interval-product 1 a-natnum))

;; Sample expressions for factorial
(define ZERO-VAL  (interval-product 1 ZERO))
(define TEN-VAL   (interval-product 1 TEN))
(define FIFTY-VAL (interval-product 1 FIFTY))

;; Tests using sample computations for factorial
(check-expect (factorial ZERO)  ZERO-VAL)
(check-expect (factorial TEN)   TEN-VAL)
(check-expect (factorial FIFTY) FIFTY-VAL)

;; Tests using sample values for f-on-natnum
(check-expect (factorial 3) 6)
(check-expect (factorial 5) 120)