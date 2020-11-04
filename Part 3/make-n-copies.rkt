;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname make-n-copies) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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

(define ORIGIN  (make-posn 0 0))
(define MS-VIBE "Finley Baker")

;; Sample intances of natnum
(define ZERO   0)
(define TWENTY 20)
(define FIFTY  50)

;; natnum X --> (listof X)
;; Purpose: To make the given number of copies of the given value
(define (make-n-copies n val)
  (if (= n 0)
      '()
      (cons val (make-n-copies (sub1 n) val))))

;; Sample expressions for make-n-copies
(define ZERO-VAL   '())
(define TWENTY-VAL (cons ORIGIN (make-n-copies (sub1 TWENTY) ORIGIN)))
(define FIFTY-VAL  (cons MS-VIBE  (make-n-copies (sub1 FIFTY) MS-VIBE)))

;; Tests using sample computations for make-n-copies
(check-expect (make-n-copies ZERO   #true)           ZERO-VAL)
(check-expect (make-n-copies TWENTY (make-posn 0 0)) TWENTY-VAL)
(check-expect (make-n-copies FIFTY  MS-VIBE)  FIFTY-VAL)

;; Tests using sample values for make-n-copies
(check-expect (make-n-copies 3 100) '(100 100 100))
(check-expect (make-n-copies 5 'x)  '(x x x x x))



