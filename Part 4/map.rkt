;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname map) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(define MAX-CHARS-HORIZONTAL 20)

(define MAX-CHARS-VERTICAL 15)

(define MAX-IMG-X (sub1 MAX-CHARS-HORIZONTAL))

(define MIN-IMG-Y 0)

(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))

(define NO-SHOT #false)

;; (X --> Y) (listof X) --> (listof Y)
;; Purpose: Return a list of the result from applying the given function
;;          to the given list's elements
(define (map-f f a-lox)
  (if (empty? a-lox)
      '()
      (cons (f (first a-lox))
            (map-f f (rest a-lox)))))

;; image-y>min \arrow image-y
;; Purpose: To move the given image-y>min up
(define (move-up-image-y an-img-y>min) (sub1 an-img-y>min))


;; Samle instances of los
(define E-LOS '())

(define A-LOS (cons (make-posn 4 2)
                    (cons NO-SHOT
                          (cons (make-posn 17 3)
                                E-LOS))))

;; shot --> shot
;; Purpose: To move the given shot
(define (move-shot a-shot)
  (cond [(eq? a-shot NO-SHOT) a-shot]
        [(= (posn-y a-shot) MIN-IMG-Y) NO-SHOT]
        [else (make-posn (posn-x a-shot)
                         (move-up-image-y (posn-y a-shot)))]))

;; los --> los
;; Purpose: To move the given list of shots
(define (move-los a-los) (map-f move-shot a-los))

;; Sample expressions for move-los
(define MOVED-E-LOS-VAL E-LOS)
(define MOVED-A-LOS-VAL (cons (move-shot (first A-LOS))
                              (move-los  (rest A-LOS))))

;; Tests using sample computations for move-los
(check-expect (move-los E-LOS) MOVED-E-LOS-VAL)
(check-expect (move-los A-LOS) MOVED-A-LOS-VAL)

;; Tests using sample values for move-los
(check-expect (move-los (cons (make-posn 12 7)
                              (cons NO-SHOT E-LOS)))
              (cons (make-posn 12 6)
                    (cons NO-SHOT E-LOS)))


;; Sample instaces of a (listof string)
(define E-LOSTR  '())
(define NE-LOSTR '("Here's" "a" "sigh" "to" "those" "who" "love" "me."))
(define NE-LOSTR2 '("And" "a" "smile" "for" "to" "those" "who" "hate"))

;; (listof string) --> lon
;; Purpose: Return a list of the string lengths in the given (listof string)
(define (lengths-lostr a-lostr) (map-f string-length a-lostr))

;; Sample expressions for lengths-lostr
(define E-LOSTR-VAL '())
(define NE-LOSTR-VAL  (cons (string-length (first NE-LOSTR))
                            (lengths-lostr (rest NE-LOSTR))))
(define NE-LOSTR2-VAL (cons (string-length (first NE-LOSTR))
                            (lengths-lostr (rest NE-LOSTR))))

;; Tests using sample computations for lengths-lostr
(check-expect (lengths-lostr E-LOSTR)  E-LOSTR-VAL)
(check-expect (lengths-lostr NE-LOSTR) NE-LOSTR-VAL)

;; Tests using sample values for lengths-lostr
(check-expect (lengths-lostr
               (list "And" "whatever" "sky's" "above" "me"))
              (list 3 8 5 5 2))
(check-expect (lengths-lostr
               (list "Here's" "a" "heart" "for" "every" "fate"))
              (list 6 1 5 3 5 4))


