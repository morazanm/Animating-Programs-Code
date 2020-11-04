;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname factorial) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|  A natural number (natnum) is either:
           1. 0
           2. (add1 natnum)

         ;; Sample intances of natnum
         (define ZERO 0)
         (define NATNUMA ...)
              ...

         ;; natnum ... --> ...
         ;; Purpose: ...
         (define (f-on-natnum a-natnum ...)
           (if (= a-natnum 0)
               ...
               (...a-natnum...(f-on-natnum (sub1 a-natnum) ...))))

         ;; Sample expressions for f-on-natnum
         (define ZERO-VAL ...)
         (define NATNUMA-VAL ...)
              ...

         ;; Tests using sample computations for f-on-natnum
         (check-expect (f-on-natnum ZERO ...)    ZERO-VAL)
         (check-expect (f-on-natnum NATNUMA ...) NATNUMA-VAL)
              ...

         ;; Tests using sample values for f-on-natnum
         (check-expect (f-on-natnum ...) ...)
         (check-expect (f-on-natnum ...) ...)
              ...
     |#

;; Sample intances of natnum
(define ZERO  0)
(define TEN   10)
(define FIFTY 50)

;; natnum --> natnum
;; Purpose: Compute the factorial of the given natnum
(define (factorial a-natnum)
  (if (= a-natnum 0)
      1
      (* a-natnum (factorial (sub1 a-natnum)))))

;; Sample expressions for factorial
(define ZERO-VAL  1)
(define TEN-VAL   (* 10 (factorial (sub1 10))))
(define FIFTY-VAL (* 50 (factorial (sub1 50))))

;; Tests using sample computations for factorial
(check-expect (factorial ZERO)  ZERO-VAL)
(check-expect (factorial TEN)   TEN-VAL)
(check-expect (factorial FIFTY) FIFTY-VAL)

;; Tests using sample values for f-on-natnum
(check-expect (factorial 3) 6)
(check-expect (factorial 5) 120)
