;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname list-searching) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
     ;; Sample instances of lon
     (define LON1 '())
     (define LON2 '(1 2 3 4))

     ;; number lon --> lon
     ;; Purpose: To return the sublist of the given lon that starts
     ;;          with the first instance of the given number.
     (define (xsublist-lon x a-lon)
       (cond [(empty? a-lon) '()]
             [(equal? x (first a-lon)) a-lon]
             [else (xsublist-lon x (rest a-lon))]))

     ;; Sample expressions for xsublist-lon
     (define XSUBLIST-LON1-VAL '())
     (define XSUBLIST-LON2-VAL1 LON2)
     (define XSUBLIST-LON2-VAL2 (xsublist-lon 3 (rest LON2)))
     (define XSUBLIST-LON2-VAL3 (xsublist-lon 0 (rest LON2)))
     

     ;; Tests using sample computations for xsublist-lon
     (check-expect (xsublist-lon 7 LON1)  XSUBLIST-LON1-VAL)
     (check-expect (xsublist-lon 1 LON2)  XSUBLIST-LON2-VAL1)
     (check-expect (xsublist-lon 3 LON2)  XSUBLIST-LON2-VAL2)
     (check-expect (xsublist-lon 0 LON2)  XSUBLIST-LON2-VAL3)

     ;; Tests using sample values for xsublist-lon
     (check-expect (xsublist-lon 99 '(96 97 99 100)) '(99 100))
     (check-expect (xsublist-lon 87 '(86 47 10)) '())

                   