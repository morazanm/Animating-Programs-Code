;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname extractStrings-btstring) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

     ;; Sample instances of (btof X)
     (define E-BTSTRING '())
     (define BTSTRING2  (list "Pokemon"
                              (list "Attack of Titan"
                                    (list "Dragon Ball" '() '())
                                    (list "One Piece" '() '()))
                              (list "Naruto"
                                    (list "Death Note" '() '())
                                    (list "Detective Conan" '() '()))))

     ;; (btof string) --> (listof string)
     ;; Purpose: To extract the strings in the given (btof string) in preorder
     (define (btstring-extract a-btstring)
       (if (empty? a-btstring)
           '()
           (cons (first a-btstring)
                 (append (btstring-extract (second a-btstring))
                         (btstring-extract (third  a-btstring))))))
       

     ;; Sample expressions for btstring-extract
     (define EBTSTRING-VAL  '())
     (define BTSTRING2-VAL  (cons (first BTSTRING2)
                                  (append (btstring-extract (second BTSTRING2))
                                          (btstring-extract (third  BTSTRING2)))))

     ;; Tests using sample computations for btstring-extract
     (check-expect (btstring-extract E-BTSTRING) EBTSTRING-VAL)
     (check-expect (btstring-extract BTSTRING2)   BTSTRING2-VAL)

     ;; Tests using sample values for btstring-extract
     (check-expect (btstring-extract (list "Attack on Titan"
                                           '()
                                           (list "Sailor Moon"
                                                 (list "Fullmetal Alchemist" '() '())
                                                 '())))
                   (list "Attack on Titan"
                         "Sailor Moon"
                         "Fullmetal Alchemist"))

     (check-expect (btstring-extract (list "This"
                                           (list "BT"
                                                 (list "is"
                                                       (list "like"
                                                             (list "a"
                                                                   (list "list." '() '())
                                                                   '())
                                                             '())
                                                       '())
                                                 '())
                                           '()))
                   (list "This" "BT" "is" "like" "a" "list."))
      