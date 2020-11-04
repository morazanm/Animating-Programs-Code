;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname largest-prime-in-interval) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

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

     ;; Sample instances of interval
     (define LOW1  2)
     (define HIGH1 1)
     (define LOW2  2)
     (define HIGH2 23)
     (define LOW3  13)
     (define HIGH3 16)

     (define LOW4  21)
     (define HIGH4 20)
     (define LOW5  2) 
     (define HIGH5 13)
     (define LOW6  2)
     (define HIGH6 8)

     ;; natnum [natnum..natnum] --> Boolean
     ;; Purpose: Determine if the given natnum is divisible by any natnum in the given interval
     (define (is-divisible? target low high)
       (and (not (> low high))
            (or (= (remainder target low) 0)
                (is-divisible? target (add1 low) high))))
            

     ;; Sample expressions for is-divisible?
     (define LOW4-HIGH4-VAL (and (not (> LOW4 HIGH4))
                                 (or (= (remainder 11 LOW4) 0)
                                     (is-divisible? 11 (add1 LOW4) HIGH4))))
     (define LOW5-HIGH5-VAL (and (not (> LOW5 HIGH5))
                                 (or (= (remainder 27 LOW5) 0)
                                     (is-divisible? 27 (add1 LOW5) HIGH5))))
     (define LOW6-HIGH6-VAL (and (not (> LOW6 HIGH6))
                                 (or (= (remainder 17 LOW6) 0)
                                     (is-divisible? 17 (add1 LOW6) HIGH6))))

     ;; Tests using sample computations for is-divisible?
     (check-expect (is-divisible? 11 LOW4 HIGH4) LOW4-HIGH4-VAL)
     (check-expect (is-divisible? 27 LOW5 HIGH5) LOW5-HIGH5-VAL)
     (check-expect (is-divisible? 17 LOW6 HIGH6) LOW6-HIGH6-VAL)

     ;; Tests using sample values for largest-prime
     (check-expect (is-divisible?  2 2 2) #true)
     (check-expect (is-divisible?  51 2 25) #true)
     (check-expect (is-divisible?  53 2 26) #false)



     ;; [int..int] --> int
     ;; Purpose: Retrun largest prime in given interval. If none, return -1
     ;; ASSUMPTION: low >= 2
     (define (largest-prime low high)
       (cond [(> low high) -1]
             [(not (is-divisible? high 2 (quotient high 2))) high]
             [else (largest-prime low (sub1 high))]))

     ;; Sample expressions for largest-prime
     (define LOW1-HIGH1-VAL -1)
     (define LOW2-HIGH2-VAL HIGH2)
     (define LOW3-HIGH3-VAL (largest-prime LOW3 (sub1 HIGH3)))

     ;; Tests using sample computations for largest-prime
     (check-expect (largest-prime LOW1 HIGH1) LOW1-HIGH1-VAL)
     (check-expect (largest-prime LOW2 HIGH2) LOW2-HIGH2-VAL)
     (check-expect (largest-prime LOW3 HIGH3) LOW3-HIGH3-VAL)

     ;; Tests using sample values for largest-prime
     (check-expect (largest-prime 2 2)   2)
     (check-expect (largest-prime 24 28) -1)
     (check-expect (largest-prime 29 35) 31)
