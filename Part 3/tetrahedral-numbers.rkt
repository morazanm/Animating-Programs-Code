;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tetrahedral-numbers) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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
(define NINE  9)
(define SIXTY 60)


;; natnum --> natnum
;; Purpose: Compute the triangular number for the given natnum
(define (nth-tri a-natnum)
  (if (= a-natnum 0)
      0
      (+ a-natnum (nth-tri (sub1 a-natnum)))))

;; Sample expressions for nth-tri
(define ZERO-VAL-TRI  0)
(define NINE-VAL-TRI  (+ NINE (nth-tri (sub1 NINE))))
(define SIXTY-VAL-TRI (+ SIXTY (nth-tri (sub1 SIXTY))))

;; Tests using sample computations for nth-tri
(check-expect (nth-tri ZERO)  ZERO-VAL-TRI)
(check-expect (nth-tri NINE)  NINE-VAL-TRI)
(check-expect (nth-tri SIXTY) SIXTY-VAL-TRI)

;; Tests using sample values for f-on-natnum
(check-expect (nth-tri 4) 10)
(check-expect (nth-tri 8) 36)



;; natnum --> natnum
;; Purpose: Compute the n^th tetrahedral number
(define (nth-tetra a-natnum)
  (if (= a-natnum 0)
      0
      (+ (nth-tri a-natnum) (nth-tetra (sub1 a-natnum)))))

;; Sample expressions for nth-tetra
(define ZERO-VAL  0)
(define NINE-VAL  (+ (nth-tri NINE) (nth-tetra (sub1 NINE))))
(define SIXTY-VAL (+ (nth-tri SIXTY) (nth-tetra (sub1 SIXTY))))

;; Tests using sample computations for nth-tetra
(check-expect (nth-tetra ZERO) ZERO-VAL)
(check-expect (nth-tetra NINE) NINE-VAL)

;; Tests using sample values for nth-tetra
(check-expect (nth-tetra 3) 10)
(check-expect (nth-tetra 2) 4)