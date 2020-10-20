;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname even-lon) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

     ;; Sample instances of lon
     (define LON1 '())
     (define LON2 '(0 1 2 -3 4 5 -6 7 8 9))
     (define LON3 '(11 75 -31 49))

     ;; lon --> lon
     ;; Purpose: To return list of the even numbers in the given list
     (define (extract-evens a-lon)
       (cond [(empty? a-lon) '()]
             [(even? (first a-lon)) (cons (first a-lon) (extract-evens (rest a-lon)))]
             [else (extract-evens (rest a-lon))]))

     ;; Sample expressions for extract-evens
     (define LON1-VAL '())
     (define LON2-VAL (cons (first LON2) (extract-evens (rest LON2))))
     (define LON3-VAL (extract-evens (rest LON3)))

     ;; Tests using sample computations for extract-evens
     (check-expect (extract-evens LON1) LON1-VAL)
     (check-expect (extract-evens LON2) LON2-VAL)
     (check-expect (extract-evens LON3) LON3-VAL)

     ;; Tests using sample values for extract-evens
     (check-expect (extract-evens '(2 4 6 8)) '(2 4 6 8))
     (check-expect (extract-evens '(-71 -9 -909 -55)) '())