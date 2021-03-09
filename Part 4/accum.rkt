;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname accum) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; Sample values of loq
(define LOQ1 '())
(define LOQ2 '(87 65 92 88 98))
(define LOQ3 '(50 90 80 60 70))

;; Sample values of los
(define LOS1 '())
(define LOS2 '("Hello" " " "World" "!"))

;; X --> X
;; Purpose: Return the given input
(define (id an-x) an-x)

;; X --> 1
;; Purpose: Return 1
(define (constant-f1 an-x) 1)

;; X (Y --> X) (X X --> X) loq --> X
;; Purpose: To compute the length of the given loq
(define (accum base-val ffirst comb a-loq)
  (if (empty? a-loq)
      base-val
      (comb (ffirst (first a-loq)) 
            (accum base-val ffirst comb (rest a-loq)))))

;; loq --> number
;; Purpose: To compute the length of the given loq
(define (length-loq a-loq) (accum 0 constant-f1 + a-loq))

;; Sample expressions for length-loq
(define LEN-LOQ1-VAL 0)
(define LEN-LOQ2-VAL (+ 1 (length-loq (rest LOQ2))))
(define LEN-LOQ3-VAL (+ 1 (length-loq (rest LOQ3))))

;; Tests using sample computations for length-loq
(check-expect (length-loq LOQ1) LEN-LOQ1-VAL)
(check-expect (length-loq LOQ2) LEN-LOQ2-VAL)
(check-expect (length-loq LOQ3) LEN-LOQ3-VAL)

;; Tests using sample values for length-loq
(check-expect (length-loq '(96 97 99 100 89 94)) 6)
           
;; loq --> number
;; Purpose: To compute the sum of the given loq
(define (sum-loq a-loq) (accum 0 id + a-loq))

;; Sample expressions for sum-loq
(define SUM-LOQ1-VAL 0)
(define SUM-LOQ2-VAL (+ (first LOQ2) (sum-loq (rest LOQ2))))
(define SUM-LOQ3-VAL (+ (first LOQ3) (sum-loq (rest LOQ3))))

;; Tests using sample computations for sum-loq
(check-expect (sum-loq LOQ1) SUM-LOQ1-VAL)
(check-expect (sum-loq LOQ2) SUM-LOQ2-VAL)

;; Tests using sample values for sum-loq
(check-expect (sum-loq '(96 97 99 100)) 392)

;; lon --> number
;; Purpose: To compute the product of the given lon
(define (product-lon a-lon) (accum 1 id * a-lon))

;; Sample expressions for product-loq
(define PROD-LOQ1-VAL 1)
(define PROD-LOQ2-VAL (* (first LOQ2) (product-lon (rest LOQ2))))
(define PROD-LOQ3-VAL (* (first LOQ3) (product-lon (rest LOQ3))))

;; Tests using sample computations for product-loq
(check-expect (product-lon LOQ1) PROD-LOQ1-VAL)
(check-expect (product-lon LOQ2) PROD-LOQ2-VAL)
(check-expect (product-lon LOQ3) PROD-LOQ3-VAL)

;; Tests using sample values for product-loq
(check-expect (product-lon '(96 97 99 100)) 92188800)

;; los --> string
;; Purpose: To append the strings in the given los
(define (append-los a-los) (accum "" id string-append a-los))

;; Sample expressions for append-los
(define APP-LOS1-VAL "")
(define APP-LOS2-VAL (string-append (first LOS2) (append-los (rest LOS2))))

;; Tests using sample computations for append-los
(check-expect (append-los LOS1) APP-LOS1-VAL)
(check-expect (append-los LOS2) APP-LOS2-VAL)

;; Tests using sample values for append-los
(check-expect (append-los '("Cool " "Beans!")) "Cool Beans!")

;; Sample instances of (listof posn)
(define ELOP '())
(define LOP1 (list (make-posn 1 9) (make-posn 2 8) (make-posn 3 7) (make-posn 4 6)))

;; (listof posn) --> lon
;; Purpose: To extract the x-values in the given list of posns
(define (get-xs-lop a-lop) (accum '() posn-x cons a-lop))

;; Sample expressions for get-xs-lop
(define ELOP-VAL (accum '() posn-x cons ELOP))
(define LOP1-VAL (accum '() posn-x cons LOP1))

;; Tests using sample computations for get-xs-lop
(check-expect (get-xs-lop ELOP) ELOP-VAL)
(check-expect (get-xs-lop LOP1) LOP1-VAL)

;; Tests using sample values for get-xs-lop
(check-expect (get-xs-lop (list (make-posn -10 2) (make-posn -5 7))) '(-10 -5))


;; (listof natnum) --> natnum
;; Purpose: To extract the maximum of the given lonn
;; Assumption: The given list is not empty
(define (max-lonn a-lonn) (accum 0 id max a-lonn))

;; Sample expressions for max-lonn
(define LOQ1-VAL (accum 0 id max LOQ1))
(define LOQ2-VAL (accum 0 id max LOQ2))

;; Tests using sample computations for max-lonn
(check-expect (max-lonn LOQ1) LOQ1-VAL)
(check-expect (max-lonn LOQ2) LOQ2-VAL)

;; Tests using sample values for max-lonn
(check-expect (max-lonn '(88 6 77 54 3 16)) 88)