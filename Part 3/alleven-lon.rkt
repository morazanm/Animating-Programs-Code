;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname alleven-lon) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

     ;; Sample instances of lon
     (define E-LON   '())
     (define AE-LON  '(88 98 22 78 506))
     (define NAE-LON '(8 561 683 788))

     ;; lon --> Boolean
     ;; Purpose: To determine if the given lon only has even numbers
     (define (all-even-lon? a-lon)
       (or (empty? a-lon)
           (and (even? (first a-lon))
                (all-even-lon? (rest a-lon)))))

     ;; Sample expressions for all-even-lon?
     (define E-LON-VAL   (or (empty? E-LON)
                             (and (even? (first E-LON))
                                  (all-even-lon? (rest E-LON)))))
     (define AE-LON-VAL  (or  (empty? AE-LON)
                         (and (even? (first AE-LON))
                              (all-even-lon? (rest AE-LON)))))
     (define NAE-LON-VAL (or (empty? NAE-LON)
                             (and (even? (first NAE-LON))
                                  (all-even-lon? (rest NAE-LON)))))

     ;; Tests using sample computations for all-even-lon?
     (check-expect (all-even-lon? E-LON)   E-LON-VAL)
     (check-expect (all-even-lon? AE-LON)  AE-LON-VAL)
     (check-expect (all-even-lon? NAE-LON) NAE-LON-VAL)

     ;; Tests using sample values for all-even-lon?
     (check-expect (all-even-lon? '(9 1 7)) #false)
     (check-expect (all-even-lon? '(4 6 8)) #true)