;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sexpr) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
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


;; (listof sexpr) --> (listof number) throws error
;; Purpose: To evlaute the sexprs in the given list
(define (eval-args a-losexpr)
  (if (empty? a-losexpr)
      '()
      (cons (eval-sexpr (first a-losexpr)) (eval-args (rest a-losexpr)))))

;; slist --> number throws error
;; Purpose: To evaluate the given slist
(define (eval-slist an-slist)
  (apply-f (first an-slist) (eval-args (rest an-slist))))

;; sexpr --> number throws error
;; Purpose: To evaluate the given sexpr
(define (eval-sexpr a-sexpr)
  (cond [(number? a-sexpr) a-sexpr]
        [else (eval-slist a-sexpr)]))

;; function (listof number) --> number throws error
;; Purpose: To apply the given function to the given numbers
(define (apply-f a-function a-lon)
  (cond [(eq? a-function '+) (sum-lon  a-lon)]
        [(eq? a-function '-) (subt-lon a-lon)]
        [else (mult-lon a-lon)]))

;; lon --> number
;; Purpose: To sum the given lon
(define (sum-lon a-lon)
  (if (empty? a-lon)
      0
      (+ (first a-lon) (sum-lon (rest a-lon)))))

;; Sample expressions for sum-lon
(define LON1-SUM 0)
(define LON2-SUM (+ (first LON2) (sum-lon (rest LON2))))

;; Tests using sample computations for sum-lon
(check-expect (sum-lon LON1) LON1-SUM)
(check-expect (sum-lon LON2) LON2-SUM)

;; Tests using sample computations for sum-lon
(check-expect (sum-lon '(-10 0 10)) 0)


;; lon --> number throws error
;; Purpose: To sum the given lon
(define (subt-lon a-lon)
  (if (empty? a-lon)
      (error "No numbers provided to -.")
      (- (first a-lon) (sum-lon (rest a-lon)))))

;; Sample expressions for subt-lon
(define LON2-SUBT (- (first LON2) (sum-lon (rest LON2))))

;; Tests using sample computations for subt-lon
(check-expect (subt-lon LON2) LON2-SUBT)

;; Tests using sample computations for subt-lon
(check-error  (subt-lon LON1) "No numbers provided to -.")
(check-expect (subt-lon '(-10 10 10)) -30)


;; lon --> number
;; Purpose: To multiply the numbers in the given lon
(define (mult-lon a-lon)
  (if (empty? a-lon)
      1
      (* (first a-lon) (mult-lon (rest a-lon)))))

;; Sample expressions for mult-lon
(define LON1-MULT 1)
(define LON2-MULT (* (first LON2) (mult-lon (rest LON2))))

;; Tests using sample computations for mult-lon
(check-expect (mult-lon LON1) LON1-MULT)
(check-expect (mult-lon LON2) LON2-MULT)

;; Tests using sample computations for mult-lon
(check-expect (mult-lon '(-10 0 10)) 0)


;; Sample expressions for eval-args
(define LOSEXPR1-VAL '())
(define LOSEXPR2-VAL (cons (eval-sexpr (first LOSEXPR2)) (eval-args (rest LOSEXPR2))))

;; Tests using sample computations for eval-args
(check-expect (eval-args LOSEXPR1) LOSEXPR1-VAL)
(check-expect (eval-args LOSEXPR2) LOSEXPR2-VAL)

;; Tests using sample values for eval-args
(check-expect (eval-args '((- 1 1) 89)) '(0 89))


;; Sample expressions for eval-slist
(define SLIST1-VAL (apply-f (first SLIST1) (eval-args (rest SLIST1))))
(define SLIST2-VAL (apply-f (first SLIST2) (eval-args (rest SLIST2))))

;; Tests using sample computations for eval-slist
(check-expect (eval-slist SLIST1) SLIST1-VAL)
(check-expect (eval-slist SLIST2) SLIST2-VAL)

;; Tests using sample values for eval-slist
(check-expect (eval-slist '(- (* 10 10) (+ 5 (* 2 3) 7))) 82)



;; Sample expressions for eval-sexpr
(define SEXPR1-VAL SEXPR1)
(define SEXPR3-VAL (eval-slist SEXPR3))

;; Tests using sample computations for eval-sexpr
(check-expect (eval-sexpr SEXPR1) SEXPR1-VAL)
(check-expect (eval-sexpr SEXPR3) SEXPR3-VAL)

;; Tests using sample values for eval-sexpr
(check-expect (eval-sexpr 42) 42)
(check-expect (eval-sexpr (+ -1 (* 6 (+ 8 2)))) 59)


;; Sample expressions for apply-f
(define APPLY1-VAL (sum-lon  LON1))
(define APPLY2-VAL (subt-lon LON2))
(define APPLY3-VAL (mult-lon LON3))

;; Tests using sample computations for apply-f
(check-expect (apply-f '+ LON1) APPLY1-VAL)
(check-expect (apply-f '- LON2) APPLY2-VAL)
(check-expect (apply-f '* LON3) APPLY3-VAL)

;; Tests using sample values for apply-f
(check-expect (apply-f '+ '(10 10 10)) 30)
(check-expect (apply-f '- '(20 0)) 20)
(check-expect (apply-f '* '(9 -2)) -18)



