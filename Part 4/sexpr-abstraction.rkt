;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sexpr-abstraction) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
A symbolic expression (sexpr) is either:    
  1. number                                            
  2. slist                                                 

A symbolic list (slist) is:                  
  (cons function (listof sexpr))

A function is either: '+, '-, '*


;; Samples of sexpr
(define SEXPR1 ...)
(define SEXPR2 ...)

;; sexpr ... --> ...
;; Purpose:
(define (f-on-sexpr a-sexpr)
  (if (number? a-sexpr)
      (f-on-number a-sexpr ...)
      (f-on-slist a-sexpr ...)))

;; Sample expressions for f-on-sexpr
(define SEXPR1-VAL ...)
(define SEXPR2-VAL ...)

;; Tests using sample computations for f-on-sexpr
(check-expect (f-on-sexpr SEXPR1) SEXPR1-VAL)
(check-expect (f-on-sexpr SEXPR2) SEXPR2-VAL)

;; Tests using sample values for f-on-sexpr
(check-expect (f-on-sexpr ... ...) ...)



;; Samples of slist
(define SLIST1 '())
(define SLIST2 ...)

;; slist ... --> ...
;; Purpose:
(define (f-on-slist an-slist)
  (if (empty? an-slist)
      ...
      (cons (f-on-sexpr (first an-slist) ...)
            (f-on-slist (rest an-slist) ...))))

;; Sample expressions for f-on-slist
(define SLIST1-VAL ...)
(define SLIST2-VAL ...)

;; Tests using sample computations for f-on-slist
(check-expect (f-on-slist SLIST1 ...) SLIST1-VAL)
(check-expect (f-on-slist SLIST2 ...) SLIST2-VAL)

;; Tests using sample values for f-on-slist
(check-expect (f-on-slist ... ...) ...)


;; Samples of function
(define PLUS '+)
(define SUBT '-)
(define MULT '*)

;; function ... --> ...
;; Purpose:
(define (f-on-function a-function)
  (cond [(eq? a-function '+) ...]
        [(eq? a-function '-) ...]
        [else ...]))

;; Sample expressions for f-on-function
(define PLUS-VAL ...)
(define SUBT-VAL ...)
(define MULT-VAL ...)

;; Tests using sample computations for f-on-function
(check-expect (f-on-function PLUS ...) PLUS-VAL)
(check-expect (f-on-function SUBT ...) SUBT-VAL)
(check-expect (f-on-function MULT ...) SUBT-VAL)

;; Tests using sample values for f-on-function
(check-expect (f-on-function ... ...) ...)

|#
(require 2htdp/abstraction)



;; Sample intances of slist
(define SLIST1 '(* (+ 44 -44) (- 20 10)))
(define SLIST2 '(* 3 (+ 6 4)))

;; Sample instances of sexpr
(define SEXPR1 67)
(define SEXPR2 SLIST1)
(define SEXPR3 SLIST2)

;; Sample instances of (listof sexpr)
(define LOSEXPR1 '())
(define LOSEXPR2 '(80 (+ 70 20) (* 4 (- 30 5))))

;; Sample instances of (listof number)
(define LON1 '())
(define LON2 '(1 2 3 4 5))
(define LON3 '(-10 -20 -30))



;; sexpr --> number throws error
;; Purpose: To evaluate the given sexpr
(define (eval-sexpr a-sexpr)
  (local [;; <X Y Z> Z (X --> Y) (Y Z --> Z) (listof X) --> Z
          ;; Purpose: Summarize given list
          (define (accum base-val ffirst comb a-lox)
            (match a-lox
              ['() base-val]
              [(cons x xs)
               (comb (ffirst x) (accum base-val ffirst comb xs))]))

          ;; function (listof number) --> number throws error
          ;; Purpose: To apply the given function to the given numbers
          (define (apply-f a-function a-lon)
            (local [;; X --> X
                    ;; Purpose: Return the given input
                    (define (id x) x)
                    ;; (listof number) --> number
                    ;; Purpose: Sum given lon
                    (define (sum-lon a-lon)
                      (accum 0 id + a-lon))]
              (cond [(eq? a-function '+) (sum-lon a-lon)]
                    [(eq? a-function '-)
                     (match a-lon
                       ['() (error "No numbers provided to -.")]
                       [(cons fnum rnums)
                        (* -1 (sum-lon (cons (* -1 fnum) rnums)))])]
                    [else (accum 1 id * a-lon)])))

          ;; sexpr --> number throws error
          ;; Purpose: To evaluate the given sexpr
          (define (eval-sexpr a-sexpr)
            (match a-sexpr
              [(cons op args)
               (apply-f op (accum '() (λ (a-sexpr) (eval-sexpr a-sexpr)) cons args))]
              [else a-sexpr]))]
    (eval-sexpr a-sexpr)))

;; Sample expressions for eval-sexpr
(define SEXPR1-VAL (eval-sexpr SEXPR1))
;(define SEXPR2-VAL (eval-sexpr SEXPR2))
(define SEXPR3-VAL (eval-sexpr SEXPR3))

;; Tests using sample computations for eval-sexpr
(check-expect (eval-sexpr SEXPR1) SEXPR1-VAL)
;(check-expect (eval-sexpr SEXPR2) SEXPR2-VAL)
(check-expect (eval-sexpr SEXPR3) SEXPR3-VAL)

;; Tests using sample values for eval-sexpr
(check-expect (eval-sexpr 42) 42)
(check-expect (eval-sexpr (+ -1 (* 6 (+ 8 2)))) 59)
;; new
(check-expect (eval-sexpr '(- 3 5 6)) -8)
(check-error  (eval-sexpr '(-)) "No numbers provided to -.")

