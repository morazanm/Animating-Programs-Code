;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ormap) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(define MAX-CHARS-HORIZONTAL 20)

(define MAX-CHARS-VERTICAL 15)

(define MAX-IMG-X (sub1 MAX-CHARS-HORIZONTAL))

(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))

;; (X --> Boolean) lox --> Boolean
;; Purpose: Determine if any list element satisfies the given predicate
(define (ormap-pred pred? a-lox)
  (and (not (empty? a-lox))
       (or (pred? (first a-lox))
           (ormap-pred pred? (rest a-lox)))))

;; Sample instances of loa
(define E-LOA '())

(define INIT-LOA
  (list (make-posn 8 0) (make-posn 9 0) (make-posn 10 0)
        (make-posn 11 0) (make-posn 12 0) (make-posn 13 0)
        (make-posn 8 1) (make-posn 9 1) (make-posn 10 1)
        (make-posn 11 1) (make-posn 12 1) (make-posn 13 1)
        (make-posn 8 2) (make-posn 9 2) (make-posn 10 2)
        (make-posn 11 2) (make-posn 12 2) (make-posn 13 2)))

(define EARTH-REACHED-LOA (list (make-posn 1 11)
                                (make-posn MAX-IMG-X MAX-IMG-Y)))

;; alien ! Boolean
;; Purpose: Determine if the given alien reached earth
(define (alien-reached-earth? an-alien)
  (= (posn-y an-alien) MAX-IMG-Y))

;; loa --> Boolean
;; Purpose: Determine if any alien has reached earth
(define (any-alien-reached-earth? a-loa)
  (ormap-pred alien-reached-earth? a-loa))

;; Sample expressions for any-alien-reached-earth?
(define ANY-REACHED-VAL1
  (and (not (empty? E-LOA))
       (or (alien-reached-earth? (first E-LOA))
           (any-alien-reached-earth? (rest E-LOA)))))

(define ANY-REACHED-VAL2
  (and (not (empty? INIT-LOA))
       (or (alien-reached-earth? (first INIT-LOA))
           (any-alien-reached-earth? (rest INIT-LOA)))))

(define ANY-REACHED-VAL3
  (and (not (empty? EARTH-REACHED-LOA))
       (or (alien-reached-earth? (first EARTH-REACHED-LOA))
           (any-alien-reached-earth? (rest EARTH-REACHED-LOA)))))

;; Tests using sample computations for any-alien-reached-earth?
(check-expect (any-alien-reached-earth? E-LOA)
              ANY-REACHED-VAL1)
(check-expect (any-alien-reached-earth? INIT-LOA)
              ANY-REACHED-VAL2)
(check-expect (any-alien-reached-earth? EARTH-REACHED-LOA)
              ANY-REACHED-VAL3)

;; Tests using sample values for any-alien-reached-earth?
(check-expect (any-alien-reached-earth? (list (make-posn 3 MAX-IMG-Y)
                                              (make-posn 7 5)
                                              (make-posn 8 2)))
              #true)
(check-expect (any-alien-reached-earth? (list (make-posn 3 12)
                                              (make-posn 7 5)
                                              (make-posn 8 2)))
              #false)


(define ELON '())

(define LON1 '(1 2 3 4 5))

(define LON2 '(1 3 5 7))

;; lon --> Boolean
;; Purpose: Determine if the list of numbers contains an even number
(define (has-even-lon? a-lon) (ormap-pred even? a-lon))

;; Sample expressions for has-even-lon?
(define ELON-VAL
  (and (not (empty? ELON))
       (or (even? (first ELON))
           (has-even-lon? (rest ELON)))))

(define LON1-VAL
  (and (not (empty? LON1))
       (or (even? (first LON1))
           (has-even-lon? (rest LON1)))))

(define LON2-VAL
  (and (not (empty? LON2))
       (or (even? (first LON2))
           (has-even-lon? (rest LON2)))))

;; Tests using sample computations for has-even-lon?
(check-expect (has-even-lon? ELON) ELON-VAL)
(check-expect (has-even-lon? LON1) LON1-VAL)
(check-expect (has-even-lon? LON2) LON2-VAL)

;; Tests using sample values for has-even-lon?
(check-expect (has-even-lon? '(-3 -5 -100 -67 -33))
              #true)
(check-expect (has-even-lon? '(-45 -77 49 -27))
              #false)


(define MIN-IMG-X 0)
(define MIN-IMG-Y 0)
(define ALIEN-8-0 (make-posn 8 0))

(define INIT-ALIEN (make-posn 10 0))
(define LEFT-EDGE-ALIEN (make-posn MIN-IMG-X 10))
(define RIGHT-EDGE-ALIEN (make-posn MAX-IMG-X 6))

;; Sample instances of loa
(define EDGE-LOA (list ALIEN-8-0
                       (make-posn MIN-IMG-X 11)
                       (make-posn 5 5)))
(define EDGE-LOA2 (list (make-posn 1 11) (make-posn MAX-IMG-X 5)))


;; alien --> Boolean
;; Purpose: Determine if he given alien is at the left edge
(define (alien-at-left-edge? an-alien)
  (= (posn-x an-alien) MIN-IMG-X))

;; Sample expressions for alien-at-left-edge?
(define LEDGE-VAL1 (= (posn-x INIT-ALIEN)      MIN-IMG-X))
(define LEDGE-VAL2 (= (posn-x LEFT-EDGE-ALIEN) MIN-IMG-X))

;; Tests using sample computations for alien-at-left-edge?
(check-expect (alien-at-left-edge? INIT-ALIEN) LEDGE-VAL1)
(check-expect (alien-at-left-edge? LEFT-EDGE-ALIEN) LEDGE-VAL2)
;; Tests using sample values for alien-at-left-edge?

(check-expect (alien-at-left-edge? (make-posn 3 2)) #false)
(check-expect (alien-at-left-edge? (make-posn MIN-IMG-X 8)) #true)


;; alien -->  Boolean
;; Purpose: Determine if he given alien is at the right edge
(define (alien-at-right-edge? an-alien)
  (= (posn-x an-alien) MAX-IMG-X))

;; Sample expressions for alien-at-right-edge?
(define REDGE-VAL1 (= (posn-x INIT-ALIEN) MAX-IMG-X))
(define REDGE-VAL2 (= (posn-x (make-posn MAX-IMG-X 8)) MAX-IMG-X))
  
;; Tests using sample computations for alien-at-right-edge?
(check-expect (alien-at-right-edge? INIT-ALIEN) REDGE-VAL1)
(check-expect (alien-at-right-edge? RIGHT-EDGE-ALIEN) REDGE-VAL2)
  
;; Tests using sample values for alien-at-right-edge?
(check-expect (alien-at-right-edge? (make-posn 1 1)) #false)
(check-expect (alien-at-right-edge? RIGHT-EDGE-ALIEN) #true)


;; loa -->  Boolean
;; Purpose: To determine if any alien is at scene’s left edge
(define (any-alien-at-left-edge? a-loa)
  (ormap alien-at-left-edge? a-loa))

;; Sample expressions for any-alien-at-left-edge?
(define LEDGE-E-LOA-VAL
  (and (not (empty? E-LOA))
       (or (alien-at-left-edge? (first E-LOA))
           (any-alien-at-left-edge? (rest E-LOA)))))
(define LEDGE-INIT-LOA-VAL
  (and (not (empty? INIT-LOA))
       (or (alien-at-left-edge? (first INIT-LOA))
           (any-alien-at-left-edge? (rest INIT-LOA)))))
(define LEDGE-LOA-VAL
  (and (not (empty? EDGE-LOA))
       (or (alien-at-left-edge? (first EDGE-LOA))
           (any-alien-at-left-edge? (rest EDGE-LOA)))))


;; loa --> Boolean
;; Purpose: To determine if any alien is at scene’s right edge
(define (any-alien-at-right-edge? a-loa)
  (ormap-pred alien-at-right-edge? a-loa))

;; Sample expressions for any-alien-at-right-edge?
(define EDGE-E-LOA-VAL
  (and (not (empty? E-LOA))
       (or (alien-at-right-edge? (first E-LOA))
           (any-alien-at-right-edge? (rest E-LOA)))))
(define EDGE-INIT-LOA-VAL
  (and (not (empty? INIT-LOA))
       (or (alien-at-right-edge? (first INIT-LOA))
           (any-alien-at-right-edge? (rest INIT-LOA)))))
(define EDGE-LOA-VAL
  (and (not (empty? EDGE-LOA))
       (or (alien-at-right-edge? (first EDGE-LOA))
           (any-alien-at-right-edge? (rest EDGE-LOA)))))
(define EDGE-LOA2-VAL (and (not (empty? EDGE-LOA2))
                           (or (alien-at-right-edge? (first EDGE-LOA2))
                               (any-alien-at-right-edge? (rest EDGE-LOA2)))))
;; Tests using sample computations any-alien-at-right-edge?
(check-expect (any-alien-at-right-edge? E-LOA) EDGE-E-LOA-VAL)
(check-expect (any-alien-at-right-edge? INIT-LOA) EDGE-INIT-LOA-VAL)
(check-expect (any-alien-at-right-edge? EDGE-LOA) EDGE-LOA-VAL)
(check-expect (any-alien-at-right-edge? EDGE-LOA2) EDGE-LOA2-VAL)
;; Tests using sample values for any-alien-at-right-edge?
(check-expect (any-alien-at-right-edge? (list (make-posn MIN-IMG-X 8)
                                              (make-posn 6 3)
                                              (make-posn MAX-IMG-X 10)))
              #true)
(check-expect (any-alien-at-right-edge? (list (make-posn 3 8)
                                              (make-posn MAX-IMG-X 3)
                                              (make-posn 5 2)))
              #true)
(check-expect (any-alien-at-right-edge? (list (make-posn MIN-IMG-Y 8)))
              #false)
(check-expect (any-alien-at-right-edge? (list (make-posn 3 8)
                                              (make-posn 5 2)))
              #false)