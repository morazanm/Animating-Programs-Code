;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname List-Interface) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/abstraction)

;; A listofx is an interface offering
;;  empty: Boolean
;;  first: X
;;  rest:  listofx
;;  cons: X --> listofx
;;  map:   (X --> Y) --> listofy
;;  2Rlst: (listof X)

;; Z --> listofx
;; Purpose: Return an empty listofx object
(define (mtList dont-care-param)
  (local [;; X --> listofx
          ;; Purpose: Add given X to the front of this list
          (define (add2front an-x) (consList an-x manager))
          ;; (X --> Y) --> (listof Y)
          ;; Purpose: Map the given function to this list
          (define (map f) (mtList 'D))
          ;; message --> service throws error
          ;; Purpose: Provide service for the given message
          (define (manager m)
            (match m
              ['empty? #true]
              ['first  (error "first requested from the empty list")]
              ['rest   (error "rest requested from the empty list")]
              ['cons   add2front]
              ['map    map]
              ['2Rlst  '()]
              [else (error (format "Unknown list service requested: ~s" m))]))]
    manager))

;; X listofx --> listofx
;; Purpose: Return a non-empty listofx object
(define (consList first rest)
  (local [;; X --> listofx
          ;; Purpose: Add given X to the front of this list
          (define (add2front an-x) (consList an-x manager))
          ;; (X --> Y) --> (listof Y)
          ;; Purpose: Map the given function to this list
          (define (map f) (consList (f first) ((rest 'map) f)))
          ;; message --> service throws error
          ;; Purpose: Provide service for the given message
          (define (manager m)
            (match m
              ['empty? #false]
              ['first  first]
              ['rest   rest]
              ['cons   add2front]
              ['map    map]
              ['2Rlst  (cons first (rest '2Rlst))]
              [else (error (format "Unknown list service requested: ~s" m))]))]
    manager))

;; Sample listofx objects
(define L0 (mtList 'dummyvalue))
(define L1 (consList 1 (consList 2 (consList 3 (mtList 'dumval)))))

;; listofx --> Boolean
;; Purpose: Determine if the given listofx is empty
(define (listofx-empty? lox-o) (lox-o 'empty?))

;; Sample expressions for listofx-empty?
(define L0E (L0 'empty?))
(define L1E (L1 'empty?))

;; Tests using sample computations for listofx-empty?
(check-expect (listofx-empty? L0) L0E)
(check-expect (listofx-empty? L1) L1E)

;; Tests using sample values for listofx-empty?
(check-expect (listofx-empty? (mtList 'dc)) #true)
(check-expect (listofx-empty? (consList 'hi (mtList 'dc))) #false)



;; listofx --> X throws error
;; Purpose: Return first element of given list
(define (listofx-first lox-o) (lox-o 'first))

;; Sample expressions for listofx-first
(define L1F (L1 'first))

;; Tests using sample computations for listofx-first
(check-expect (listofx-first L1) L1F)

;; Tests using sample values for listofx-first
(check-error  (listofx-first L0)           "first requested from the empty list")
(check-error  (listofx-first (mtList 'dc)) "first requested from the empty list")
(check-expect (listofx-first (consList 'hi (mtList 'dc))) 'hi)



;; listofx --> listofx throws error
;; Purpose: Return rest of given list
(define (listofx-rest lox-o) (lox-o 'rest))

;; Sample expressions for listofx-rest
(define L1R (L1 'rest))

;; Tests using sample computations for listofx-rest
(check-expect (listofx-2Rlst (listofx-rest L1)) '(2 3))

;; Tests using sample values for listofx-rest
(check-error  (listofx-rest L0)           "rest requested from the empty list")
(check-error  (listofx-rest (mtList 'dc)) "rest requested from the empty list")
(check-expect (listofx-2Rlst (listofx-rest (consList 'hi (mtList 'dc))))
              '())



;; X --> listofx
;; Purpose: Add the given value to the front of the given listofx
(define (listofx-cons lox-o an-x) ((lox-o 'cons) an-x))

;; Sample expressions for listofx-cons
(define L0C ((L0 'cons) 31))
(define L1C ((L1 'cons) 0))

;; Tests using sample computations for listofx-cons
(check-expect (listofx-2Rlst (listofx-cons L0 31))
              (listofx-2Rlst L0C))
(check-expect (listofx-2Rlst (listofx-cons L1 0))
              (listofx-2Rlst L1C))

;; Tests using sample values for listofx-cons
(check-expect (listofx-2Rlst (listofx-cons (consList "hi" (mtList "dc"))
                                           "hey"))
              '("hey" "hi"))



;; <X Y> listofx (X --> Y) --> listofy
;; Purpose: Map given function onto given list
(define (listofx-map lox-o f) ((lox-o 'map) f))

;; Sample expressions for listofx-map
(define L0M ((L0 'map) sub1))
(define L1M ((L1 'map) (λ (n) (* 2 n))))

;; Tests using sample computations for listofx-map
(check-expect (listofx-2Rlst (listofx-map L0 sub1))
              (listofx-2Rlst  L0M))
(check-expect (listofx-2Rlst (listofx-map L1 (λ (n) (* 2 n))))
              (listofx-2Rlst L1M))

;; Tests using sample values for listofx-map
(check-expect (listofx-2Rlst (listofx-map (consList "hi" (mtList "dc"))
                                          string-length))
              '(2))



;; listofx --> Boolean
;; Purpose: Convert given listofx to a ISL+ list
(define (listofx-2Rlst lox-o) (lox-o '2Rlst))

;; Sample expressions for listofx-2Rlst
(define L0RL (L0 '2Rlst))
(define L1RL (L1 '2Rlst))

;; Tests using sample computations for listofx-2Rlst
(check-expect (listofx-2Rlst L0) L0RL)
(check-expect (listofx-2Rlst L1) L1RL)

;; Tests using sample values for listofx-2Rlst
(check-expect (listofx-2Rlst (mtList 'dc)) '())
(check-expect (listofx-2Rlst (consList 'hi (mtList 'dc))) '(hi))



