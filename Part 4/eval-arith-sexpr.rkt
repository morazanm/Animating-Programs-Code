;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname eval-arith-sexpr) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "abstraction.rkt" "teachpack" "2htdp")) #f)))

;; A function is either: 1. '+  2. '-  3. '*



;; sexpr --> number throws error
;; Purpose: To evaluate the given sexpr
(define (eval-sexpr a-sexpr)
  (local 
    [;; slist --> number throws error
     ;; Purpose: Evaluate given slist
     (define (eval-slist sl)
       (apply-f 
        (first sl) 
        (accum '() (λ (a-sexpr) (eval-sexpr a-sexpr)) cons (rest sl))))
     
     ;; <X Y Z> Z (X --> Y) (Y Z --> Z) (listof X) --> Z
     ;; Purpose: Summarize given list
     (define (accum base-val ffirst comb a-lox)
       (match a-lox
         ['() base-val]
         [(cons x xs) (comb (ffirst x) (accum base-val ffirst comb xs))]))
     
     ;; function (listof number) --> number throws error
     ;; Purpose: Apply funct to nums
     (define (apply-f a-function a-lon)
       (local [;; X --> X
               ;; Purpose: Return the given input
               (define (id x) x)
               ;; (listof number) \arrow number Purpose: Sum given lon
               (define (sum-lon a-lon) (accum 0 id + a-lon))]
         (cond [(eq? a-function '+) (sum-lon a-lon)]
               [(eq? a-function '-)
                (match a-lon
                  ['() (error "No numbers provided to -.")]
                  [(cons fnum rnums) (* -1 (sum-lon (cons (* -1 fnum) rnums)))])]
               [else (accum 1 id * a-lon)])))
     
     ;; sexpr --> number throws error  Purpose: Evaluate the given sexpr
     (define (eval-sexpr a-sexpr)
       (match a-sexpr
         [(cons op args)
          (apply-f op (accum '()  (λ (a-sexpr) (eval-sexpr a-sexpr)) cons  args))]
         [else a-sexpr]))]
    (eval-sexpr a-sexpr)))

(check-expect (eval-sexpr 31) 31)
(check-expect (eval-sexpr '(+ 1 2 3)) 6)
(check-expect (eval-sexpr '(- 1 2 3)) -4)
(check-expect (eval-sexpr '(* 2 4 6)) 48)
