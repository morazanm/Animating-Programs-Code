;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname sorted-lon-len-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

     ;; A lon2 is either:
     ;;  1. '()
     ;;  2. (list number)
     ;;  3. (list number number lon2)

     ;; Function Template for a function on a lon2

     ;; Sample instances of lon2
     ;; (define E-LON2 ...)
     ;; (define A-LON2 ...)
     ;; (define B-LON2 ...)
     ;;      ...

     ;; lon2 ... --> ...
     ;; Purpose: ...
     ;; (define (f-on-lon2 a-lon2 ...)
     ;;   (cond [(empty? a-lon2) ...)
     ;;         [(= (length a-lon2) 1) ...]
     ;;         [else ...(f-on-number (first a-lon2))
     ;;               ...(f-on-number (second a-lon2))
     ;;               ...(f-on-lon2 (rest a-lon2))
     ;;               ...(f-on-lon2 (rest (rest a-lon2)))]))

     ;; Sample expressions for sorted-lon2
     ;; (define E-LON2-VAL ...)
     ;; (define A-LON2-VAL ...)
     ;; (define B-LON2-VAL ...)
     ;;     ...

     ;; Tests using sample computations for sorted-LON2
     ;; (check-expect (sorted-lon2? E-LON2 ...) E-LON2-VAL)
     ;; (check-expect (sorted-lon2? A-LON2 ...) A-LON2-VAL)
     ;; (check-expect (sorted-lon2? B-LON2 ...) B-LON2-VAL)
     ;;     ...

     ;; Tests using sample values for sorted-lon2
     ;; (check-expect (sorted-lon2? ...) ...)
     ;;     ...

     ;; Sample instances of lon2
     (define E-LON2        '())
     (define A-LON2        '(88))
     (define SORTED-LON2   '(8 56 68 788))
     (define UNSORTED-LON2 '(5 7 8 4 9))

     ;; lon2 --> Boolean
     ;; Purpose: To determine if the given lon2 is sorted in nondecreasing order
     (define (sorted-lon2? a-lon2)
       (or (<= 0 (length a-lon2) 1)
           (and (<= (first a-lon2) (second a-lon2))
                (sorted-lon2? (rest a-lon2)))))

     ;; Sample expressions for sorted-lon2
     (define E-LON2-VAL (or (< (length E-LON2) 2)
                              (and (<= (first E-LON2) (second E-LON2))
                                   (sorted-lon2? (rest E-LON2)))))
     (define A-LON2-VAL (or (< (length A-LON2) 2)
                                 (and (<= (first A-LON2) (second A-LON2))
                                      (sorted-lon2? (rest A-LON2)))))
     (define SORTED-LON2-VAL (or (< (length SORTED-LON2) 2)
                                   (and (<= (first SORTED-LON2) (second SORTED-LON2))
                                        (sorted-lon2? (rest SORTED-LON2)))))
     (define UNSORTED-LON2-VAL (or (< (length UNSORTED-LON2) 2)
                                        (and (<= (first UNSORTED-LON2) (second UNSORTED-LON2))
                                             (sorted-lon2? (rest UNSORTED-LON2)))))

     ;; Tests using sample computations for sorted-LON2
     (check-expect (sorted-lon2? E-LON2)        E-LON2-VAL)
     (check-expect (sorted-lon2? A-LON2)        A-LON2-VAL)
     (check-expect (sorted-lon2? SORTED-LON2)   SORTED-LON2-VAL)
     (check-expect (sorted-lon2? UNSORTED-LON2) UNSORTED-LON2-VAL)

     ;; Tests using sample values for sorted-lon2
     (check-expect (sorted-lon2? '(8 7 6 5)) #false)
     (check-expect (sorted-lon2? '(5 6 7 8)) #true)