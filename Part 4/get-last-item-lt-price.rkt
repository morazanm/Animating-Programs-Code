;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname get-last-item-lt-price) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; An item is a structure, (make-item string number), with the
;; name of the item and the price of the item.
(define-struct item (name price))

;; Sample item
(define ITEM0 (make-item "ball"  10))
(define ITEM1 (make-item "doll"  8))
(define ITEM2 (make-item "bat"   12))
(define ITEM3 (make-item "glove" 15))
(define ITEM4 (make-item "cap"   7))
(define ITEM5 (make-item "bike"  100))

;; Sample (listof item)
(define LOI0 '())
(define LOI1 (list ITEM0 ITEM1 ITEM2 ITEM3 ITEM4 ITEM5))
(define LOI2 (list ITEM1 ITEM2 ITEM3 ITEM5))
(define LOI3 (list ITEM1 ITEM2 ITEM4 ITEM5))

;; A result is either: 1. '() or 2. item

;; number (listof item) --> result
;; Purpose: Return the last item in the given list that costs less than the given price
(define (get-last-item<price a-price a-loi)
  (cond [(empty? a-loi) '()]
        [(< (item-price (first a-loi)) a-price)
         (if (empty? (get-last-item<price a-price (rest a-loi)))
             (first a-loi)
             (get-last-item<price a-price (rest a-loi)))]
        [else (get-last-item<price a-price (rest a-loi))]))

;; Sample expressions for get-last-item<price
(define LOI0-VAL '())
(define LOI1-VAL (get-last-item<price 10 (rest LOI1)))
(define LOI2-VAL (first LOI2))
(define LOI3-VAL (get-last-item<price 11 (rest LOI3)))

;; Tests using sample computations for get-last-item<price
(check-expect (get-last-item<price 120 LOI0) LOI0-VAL)
(check-expect (get-last-item<price 10  LOI1) LOI1-VAL)
(check-expect (get-last-item<price 9   LOI2) LOI2-VAL)
(check-expect (get-last-item<price 11 LOI3) LOI3-VAL)

;; Tests using sample values for get-last-item<price
(check-expect (get-last-item<price 150
                                   (list (make-item "pen" 100)
                                         (make-item "ring" 600)
                                         (make-item "knife" 125)))
              (make-item "knife" 125))
(check-expect (get-last-item<price 120
                                   (list (make-item "pen" 100)
                                         (make-item "ring" 600)
                                         (make-item "knife" 125)))
              (make-item "pen" 100))

;; number (listof item) --> result    
;; Purpose: Get last item < given price
(define (get-last a-price a-loi)
  (cond [(empty? a-loi) '()]
        [(< (item-price (first a-loi)) a-price)
         (local [(define rest-result (get-last a-price (rest a-loi)))]
           (if (empty? rest-result) 
               (first a-loi) 
               rest-result))]
        [else (get-last a-price (rest a-loi))]))

;; Sample expressions for get-last
(define LOI0-V '())
(define LOI1-V (get-last 10 (rest LOI1)))
(define LOI2-V (first LOI2))
(define LOI3-V (get-last 11 (rest LOI3)))

;; Tests using sample computations for get-last
(check-expect (get-last 120 LOI0) LOI0-V)
(check-expect (get-last 10  LOI1) LOI1-V)
(check-expect (get-last 9   LOI2) LOI2-V)
(check-expect (get-last 11 LOI3)  LOI3-V)

;; Tests using sample values for get-last
(check-expect (get-last 150
                        (list (make-item "pen" 100)
                              (make-item "ring" 600)
                              (make-item "knife" 125)))
              (make-item "knife" 125))
(check-expect (get-last 120
                        (list (make-item "pen" 100)
                              (make-item "ring" 600)
                              (make-item "knife" 125)))
              (make-item "pen" 100))

;; <X Y> X (int ! Y) (Y X ! X) [int..int] ! X
;; Purpose: Compute a value by traversing the given interval from low to
;; high using the given base value, function to apply to low,
;; and combining function.
(define (interval-accum-l2h base-val ffirst comb low high)
  (if (> low high)
      base-val
      (comb (ffirst low)
            (interval-accum-l2h base-val ffirst comb (add1 low) high))))

;; int --> item
;; Purpose: Returns a doll item that costs 30
(define (make-doll-item n) (make-item "doll" 30))

;; Sample expressions for make-doll-item
(define DOLL1 (make-item "doll" 30))
(define DOLL2 (make-item "doll" 30))

;; Tests using sample computations for make-doll-item
(check-expect (make-doll-item 4) DOLL1)
(check-expect (make-doll-item 8) DOLL2)

;; Tests using sample values for make-doll-item
(check-expect (make-doll-item -5) (make-item "doll" 30))
(check-expect (make-doll-item 0)  (make-item "doll" 30))


(define LOIL (interval-accum-l2h '() make-doll-item cons 0 19))

(time (get-last-item<price 1200 LOIL))
(time (get-last            1200 LOIL))
