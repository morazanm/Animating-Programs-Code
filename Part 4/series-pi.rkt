;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname series-pi) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; natunum --> natnum
;; Purpose: Return ith odd number
(define (ith-odd i)
  (add1 (* 2 i)))

;; Sample expressions for ith-odd
(define 0TH-ODD (add1 (* 2 0)))
(define 9TH-ODD (add1 (* 2 9)))

;; Tests using sample computations for ith-odd
(check-expect (ith-odd 0) 0TH-ODD)
(check-expect (ith-odd 9) 9TH-ODD)

;; Tests using sample values for ith-odd
(check-expect (ith-odd 2) 5)
(check-expect (ith-odd 4) 9)

;; (natnum --> number) --> (natnum --> number)
;; Purpose: Return a function for the sequence defined by the given function
(define (series term-f)
  (lambda (n)
    (local [;; natnum --> number
            ;; Purpose: Compute the series using the given number of terms
            (define (add-terms n)
              (if (= n 0)
                  (term-f 0)
                  (+ (term-f n) (add-terms (sub1 n)))))]
      (if (= n 0)
          (term-f 0)
          (add-terms (sub1 n))))))

;; natnum --> natnum
;; Purpose: Compute the square of the given number
(define n-square (series ith-odd))

;; Sample expressions for nth-square
(define ZERO-SQ  (n-square 0))
(define THREE-SQ (n-square 3))

;; Tests using sample computations for nth-square
(check-expect (n-square 0) ZERO-SQ)
(check-expect (n-square 3) THREE-SQ)

;; Tests using sample values for nth-square
(check-expect (n-square 10)  100)
(check-expect (n-square 4)   16)
(check-expect (n-square 325) (sqr 325))
(check-expect (n-square 57)  (sqr 57))


;; natnum --> natnum
;; Purpose: Return the sum of the first n cubes
(define sum-cubes (series (lambda (n) (* n n n))))

(check-expect (integer? (sqrt (sum-cubes 0))) true)
(check-expect (integer? (sqrt (sum-cubes 5))) true)
(check-expect (integer? (sqrt (sum-cubes 209))) true)

;; natnum --> number
;; Purpose: Approximate pi using the given number of terms
(define pi-series (series (lambda (n) (* 4 (/ (expt -1 n) (ith-odd n))))))

(check-within (pi-series 700)   3.1415 0.01)   ;; 3.140164
(check-within (pi-series 3000)  3.1415 0.001)  ;; 3.141259
(check-within (pi-series 12000) 3.1415 0.0001) ;; 3.141509

