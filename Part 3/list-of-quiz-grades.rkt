;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname list-of-quiz-grades) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Sample values of loq
     (define LOQ1 '())
     (define LOQ2 '(87 65 92 88 98))



     ;; Sample values of loq
     (define LOQ3 '(50 90 80 60 70))

     ;; loq --> number
     ;; Purpose: To compute the sum of the given loq
     (define (sum-loq a-loq)
       (if (empty? a-loq)
           0
           (+ (first a-loq)
              (sum-loq (rest a-loq)))))

     ;; Sample expressions for sum-loq
     (define SUM-LOQ1-VAL 0)
     (define SUM-LOQ2-VAL (+ (first LOQ2) (sum-loq (rest LOQ2))))
     (define SUM-LOQ3-VAL (+ (first LOQ3) (sum-loq (rest LOQ3))))

     ;; Tests using sample computations for sum-loq
     (check-expect (sum-loq LOQ1) SUM-LOQ1-VAL)
     (check-expect (sum-loq LOQ2) SUM-LOQ2-VAL)

     ;; Tests using sample values for sum-loq
     (check-expect (sum-loq '(96 97 99 100)) 392)


                   
     ;; loq --> number
     ;; Purpose: To compute the length of the given loq
     (define (length-loq a-loq)
       (if (empty? a-loq)
           0
           (+ 1 (length-loq (rest a-loq)))))

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


;; loq --> number throws error
;; Purpose: To compute the given loq's average
(define (avg-loq a-loq)
  (if (empty? a-loq)
      (error "avg-loq expects an non-empty.")
      (/ (sum-loq a-loq) (length-loq a-loq))))
     
;; Sample expressions for avg-loq
(define AVG-LOQ2-VAL (avg-loq LOQ2))

;; Tests using sample computations for avg-loq
(check-expect (avg-loq LOQ2) AVG-LOQ2-VAL)

;; Tests using sample values for avg-loq
(check-error (avg-loq LOQ1) "avg-loq expects an non-empty.")

