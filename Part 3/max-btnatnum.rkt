;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname max-btnatnum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
     ;; A binary tree of X (btof X) is either:
     ;;   1. '()
     ;;   2. (list X (btof X) (btof X))

     ;; Sample instances of (btof X)
     (define E-(btof X) '())
     (define (btof X)2  ...)

     ;; (btof X) ... \arrow ...
     ;; Purpose: ...
     (define (f-on-loa a-(btof X) ...)
       (if (empty? a-(btof X))
           ...
           ...(f-on-X   (first a-(btof X)))
              (f-on-(btof X) (second a-loa))
              (f-on-(btof X) (thrid a-loa))...)))

     ;; Sample expressions for f-on-(btof X)
     (define E-(btof X)-VAL ...)
     (define (btof X)2-VAL  ...)
        ...

     ;; Tests using sample computations for f-on-(btof X)
     (check-expect (f-on-(btof X) E-(btof X) ...) E-(btof X)-VAL)
     (check-expect (f-on-(btof X) (btof X)2  ...) (btof X)2-VAL)
        ...

     ;; Tests using sample values for f-on-(btof X)
     (check-expect (f-on-(btof X) ...) ...)
        ...
|#

     ;; Sample instances of (btof int)
     (define E-BTINT '())
     (define BTINT1  (list 200 '() '()))
     (define BTINT2  (list 100
                           (list 1
                                 (list 3 '() '())
                                 (list 4 '() '()))
                           (list 2
                                 (list 5 '() '())
                                 (list 6 '() '()))))
     (define BTINT3  (list -10 '() (list 78 '() '())))
     (define BTINT4  (list -8
                           (list -5
                                 (list 47 '() '())
                                 (list -1 '() '()))
                           '()))

     ;; (btof int) --> int throws error
     ;; Purpose: Find the maximum in the given (btof int)
     (define (max-btint a-btnatnum)
       (cond [(empty? a-btnatnum) (error "An empty (btof natnum) has no maximum value.")]
             [(and (empty? (second a-btnatnum))
                   (empty? (third  a-btnatnum)))
              (first a-btnatnum)]
             [(empty? (second a-btnatnum))
              (max (first a-btnatnum) (max-btint (third a-btnatnum)))]
             [(empty? (third a-btnatnum))
              (max (first a-btnatnum) (max-btint (second a-btnatnum)))]
             [else (max (first a-btnatnum)
                        (max-btint (second a-btnatnum))
                        (max-btint (third a-btnatnum)))]))
       

     ;; Sample expressions for max-btint
     (define BTINT1-VAL  (first BTINT1))
     (define BTINT2-VAL  (max (first BTINT2)
                              (max-btint (second BTINT2))
                              (max-btint (third BTINT2))))
     (define BTINT3-VAL  (max (first BTINT3)
                              (max-btint (third  BTINT3))))
     (define BTINT4-VAL  (max (first BTINT4)
                              (max-btint (second BTINT4))))

     ;; Tests using sample computations for max-btnatnum
     (check-expect (max-btint BTINT1) BTINT1-VAL)
     (check-expect (max-btint BTINT2) BTINT2-VAL)
     (check-expect (max-btint BTINT3) BTINT3-VAL)
     (check-expect (max-btint BTINT4) BTINT4-VAL)

     ;; Tests using sample values for max-btnatnum
     (check-error (max-btint E-BTINT)
                  "An empty (btof natnum) has no maximum value.")
     (check-expect (max-btint (list -67
                                       (list -50 '() '())
                                       (list -8  '() '())))
                   -8)
      