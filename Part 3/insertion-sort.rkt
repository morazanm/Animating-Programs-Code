;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname insertion-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Sample instances of a lon
(define E-LON        '())
(define SORTED-LON   '(17 18 29 37 41 52))
(define UNSORTED-LON '(89 21 1 77 23))
(define SORTED-LON2  '(31 87 95 102))
(define INSERT-NUM1 20)
(define INSERT-NUM2 90)


; insert: number lon --> lon
; Purpose: To sort the given lon in non-decreasing order
(define (insert a-num a-lon)
  (cond [(empty? a-lon) (list a-num)]
        [(<= a-num (first a-lon)) (cons a-num a-lon)]
        [else (cons (first a-lon) (insert a-num (rest a-lon)))]))


; sort: lon --> lon
; Purpose: To sort the given lon in non-decreasing order
(define (sort-lon a-lon)
  (cond [(empty? a-lon) '()]
        [else (insert (first a-lon) (sort-lon (rest a-lon)))]))

;; Sample expressions for sort-lon
(define E-LON-VAL '())
(define SORTED-LON-VAL (insert (first SORTED-LON)
                               (sort-lon (rest SORTED-LON))))
(define UNSORTED-LON-VAL (insert (first UNSORTED-LON)
                                 (sort-lon (rest UNSORTED-LON))))

;; Tests using sample computations for sort-lon
(check-expect (sort-lon E-LON)        E-LON-VAL)
(check-expect (sort-lon SORTED-LON)   SORTED-LON-VAL)
(check-expect (sort-lon UNSORTED-LON) UNSORTED-LON-VAL)


;; Tests using sample values for sort-lon
(check-expect (sort-lon '(5 4 3 2 1)) '(1 2 3 4 5))
(check-expect (sort-lon '(63 12 76 99 0)) '(0 12 63 76 99))

;; Sample expressions for insert
(define ELON-VAL (list INSERT-NUM1))
(define SORTEDLON-VAL (cons INSERT-NUM1 SORTED-LON2))
(define UNSORTEDLON-VAL (cons (first SORTED-LON2)
                              (insert INSERT-NUM2
                                      (rest SORTED-LON2))))

;; Tests using sample computations for insert
(check-expect (insert INSERT-NUM1 E-LON) ELON-VAL)
(check-expect (insert INSERT-NUM1 SORTED-LON2)
              SORTEDLON-VAL)
(check-expect (cons (first SORTED-LON2)
                    (insert INSERT-NUM2 (rest SORTED-LON2)))
              UNSORTEDLON-VAL)


;; Tests using sample values for insert
(check-expect (insert 3 '(1 2 4 5)) '(1 2 3 4 5))
(check-expect (insert 101 '(-5 -7 0 2 232)) '(-5 -7 0 2 101 232))