;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bst-cr-II) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


;; A criminal record (cr) is a structure, (make-cr natnum nickname string),
;; with an id number, a string, and a string.
(define-struct cr (id nickmane name))

(define TEFLONDON (make-cr 241 "The Teflon Don" "John Gotti Jr."))

(define BABYFACE  (make-cr 77  "Babyface Nelson" "Lester Joseph Gillis"))

(define SCARFACE  (make-cr 23  "Scarface" "Alphonse Gabriel Capone"))

(define DILLINGER (make-cr 675 "Gentleman John" "John Herbert Dillinger "))

(define BUGSY     (make-cr 874 "Bugsy" "Benjamin Siegel"))

(define PAULIE    (make-cr 1 "Big Pauli" "Paul Castellano"))

(define VITO      (make-cr 55  "Don Vitone" "Vito Genovese"))

(define DNE-CR (make-cr 0 "DNE" "CR DOES NOT EXIST"))

;; A criminal database is a (listof cr).

;; Sample instances
(define CR-DB0 '())
(define CR-DB1 (list TEFLONDON BABYFACE SCARFACE DILLINGER BUGSY))

;; number (listof cr)arrow cr
;; Purpose: To return list of the even numbers in the given list
(define (get-record-locr id a-locr)
  (cond [(empty? a-locr) DNE-CR]
        [(= (cr-id (first a-locr)) id) (first a-locr)]
        [else (get-record-locr id (rest a-locr))]))

;; Sample expressions for get-record-locr
(define GR1-VAL DNE-CR)
(define GR2-VAL TEFLONDON)
(define GR3-VAL (get-record-locr 675 (rest CR-DB1)))

;; Tests using sample computations for get-record-locr
(check-expect (get-record-locr 899 CR-DB1) GR1-VAL)
(check-expect (get-record-locr 241 CR-DB1) GR2-VAL)
(check-expect (get-record-locr 675 CR-DB1) GR3-VAL)

;; Tests using sample values for get-record-locr
(check-expect (get-record-locr 55 (list PAULIE VITO)) VITO)
(check-expect (get-record-locr 1  (list PAULIE VITO)) PAULIE)


(define CR-DB3 (list DILLINGER
                     (list BABYFACE '() (list SCARFACE '() '()))
                     (list TEFLONDON (list BUGSY '() '()) '())))

;; number (btof cr) --> cr
;; Purpose: To return list of the even numbers in the given list
(define (get-record-btocr id a-btocr)
  (cond [(empty? a-btocr) DNE-CR]
        [(= (cr-id (first a-btocr)) id) (first a-btocr)]
        [(equal? (get-record-btocr id (second a-btocr)) DNE-CR)
         (get-record-btocr id (third a-btocr))]
        [else (get-record-btocr id (second a-btocr))]))

;; Sample expressions for get-record-btocr
(define GRBT1-VAL DNE-CR)
(define GRBT2-VAL DILLINGER)
(define GRBT3-VAL (get-record-btocr 874 (third CR-DB3)))
(define GRBT4-VAL (get-record-btocr 77 (second CR-DB3)))

;; Tests using sample computations for get-record-btocr
(check-expect (get-record-btocr 899 CR-DB0) GRBT1-VAL)
(check-expect (get-record-btocr 675 CR-DB3) GRBT2-VAL)
(check-expect (get-record-btocr 874 CR-DB3) GRBT3-VAL)
(check-expect (get-record-btocr 77  CR-DB3) GRBT4-VAL)

;; Tests using sample values for get-record-locr
(check-expect (get-record-btocr 55 (list PAULIE '() (list VITO '() '())))
              VITO)
(check-expect (get-record-btocr 1 (list PAULIE '() (list VITO '() '())))
              PAULIE)
(check-expect (get-record-btocr 16 (list BABYFACE
                                         (list SCARFACE '() '())
                                         (list BUGSY '() '())))
              DNE-CR)
