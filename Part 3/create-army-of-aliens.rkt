;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname create-army-of-aliens) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|  A natural number (natnum) is either:
           1. 0
           2. (add1 natnum)

         ;; Sample intances of natnum
         (define ZERO 0)
         (define NATNUMA ...)
              ...

         ;; natnum ... --> ...
         ;; Purpose: ...
         (define (f-on-natnum a-natnum ...)
           (if (= a-natnum 0)
               ...
               (...a-natnum...(f-on-natnum (sub1 a-natnum) ...))))

         ;; Sample expressions for f-on-natnum
         (define ZERO-VAL ...)
         (define NATNUMA-VAL ...)
              ...

         ;; Tests using sample computations for f-on-natnum
         (check-expect (f-on-natnum ZERO ...)    ZERO-VAL)
         (check-expect (f-on-natnum NATNUMA ...) NATNUMA-VAL)
              ...

         ;; Tests using sample values for f-on-natnum
         (check-expect (f-on-natnum ...) ...)
         (check-expect (f-on-natnum ...) ...)
              ...
     |#

#|
     An interval ([low..high]) is two integers such that it is either:
       1. empty     (interpretation: low > high)
       2. non-empty (interpretation: low \(\leq\) high)
          [[low..(sub1 high)] high] or [low [(add1 low)..high]

     ;; Sample instances of interval
     (define LOW1  ...)
     (define HIGH1 ...)
     (define LOW2  ...)
     (define HIGH2 ...)
          ...

     ;; [int..int] ... --> ...
     ;; Purpose: ...
     (define (f-on-interval low high ...)
       (if (> low high)
           ...
           (...high...(f-on-interval low       (sub1 high)...
            ...low....(f-on-interval (add1 low) high)...)))

     ;; Sample expressions for f-on-interval
     (define LOW1-HIGH1-VAL ...)
     (define LOW2-HIGH2-VAL ...)
          ...

     ;; Tests using sample computations for f-on-interval
     (check-expect (f-on-interval LOW1 HIGH1 ...) LOW1-HIGH1-VAL)
     (check-expect (f-on-interval LOW2 HIGH2 ...) LOW2-HIGH2-VAL)
          ...

     ;; Tests using sample values for f-on-interval
     (check-expect (f-on-interval ...) ...)
     (check-expect (f-on-interval ...) ...)
          ...

|#


(define MAX-CHARS-HORIZONTAL 20)
(define ALIENS-PER-LINE 12)

;; Sample intances of natnum
(define ZERO  0)
(define THREE 3)
(define FIVE  5)

;; Sample intances of interval
(define LOW1  THREE)
(define HIGH1 ZERO)
(define LOW2  ZERO)
(define HIGH2 THREE)
(define LOW3  THREE)
(define HIGH3 FIVE)


;; natnum nat-num [image-x..image-x] --> loa
;; Purpose: Create an loa with the given image-y with the given image-x interval
(define (make-alien-line an-image-y low high)
  (if (> low high)
      '()
      (cons (make-posn low an-image-y)
            (make-alien-line an-image-y (add1 low) high))))

;; Sample expressions for make-alien-line
(define LOW1-HIGH1-VAL '())
(define LOW2-HIGH2-VAL (cons (make-posn LOW2 3)
                             (make-alien-line 3 (add1 LOW2) HIGH2)))
(define LOW3-HIGH3-VAL (cons (make-posn LOW3 2)
                             (make-alien-line 2 (add1 LOW3) HIGH3)))

;; Tests using sample computations for make-alien-line
(check-expect (make-alien-line 3 LOW2 HIGH2) LOW2-HIGH2-VAL)
(check-expect (make-alien-line 2 LOW3 HIGH3) LOW3-HIGH3-VAL)

;; Tests using sample values for make-alien-line
(check-expect (make-alien-line 1 17 19) (list (make-posn 17 1)
                                              (make-posn 18 1)
                                              (make-posn 19 1)))

;; natnum --> loa
;; Purpose: Create initial alien army with the given number of lines
(define (create-alien-army num-lines)
  (if (= num-lines 0)
      '()
      (append (make-alien-line
               (sub1 num-lines)
               (- (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))
               (sub1 (+ (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))))
              (create-alien-army (sub1 num-lines)))))

;; Sample expressions for create-alien-army
(define ZERO-VAL  '())
(define THREE-VAL (append (make-alien-line
                           (sub1 THREE)
                           (- (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))
                           (sub1 (+ (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))))
                          (create-alien-army (sub1 THREE))))
(define FIVE-VAL  (append (make-alien-line
                           (sub1 FIVE)
                           (- (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))
                           (sub1 (+ (/ MAX-CHARS-HORIZONTAL 2) (/ ALIENS-PER-LINE 2))))
                          (create-alien-army (sub1 FIVE))))

;; Tests using sample computations for create-alien-army
(check-expect (create-alien-army ZERO)  ZERO-VAL)
(check-expect (create-alien-army THREE) THREE-VAL)
(check-expect (create-alien-army FIVE)  FIVE-VAL)

;; Tests using sample values for create-alien-army
(check-expect (create-alien-army 1) (list (make-posn 4 0)  (make-posn 5 0)  (make-posn 6 0)
                                          (make-posn 7 0)  (make-posn 8 0)  (make-posn 9 0)
                                          (make-posn 10 0) (make-posn 11 0) (make-posn 12  0)
                                          (make-posn 13 0) (make-posn 14 0) (make-posn 15 0)))
;(check-expect (create-alien-army ...) ...)
