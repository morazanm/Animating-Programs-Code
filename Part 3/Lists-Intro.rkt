;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Lists-Intro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NO-SHOT 'no-shot)

(define E-GLIST '())
(define E-LOA   '())
(define E-LOS   '())
     
(check-expect (empty? E-GLIST) #true)
(check-expect (empty? E-LOA) #true)
(check-expect (empty? E-LOS) #true)

(define A-GLIST (cons "milk"
                      (cons "apples"
                            E-GLIST)))
(define A-LOA   (cons (make-posn 10 2)
                      (cons (make-posn 5 12)
                            (cons (make-posn 4 8)
                                  (cons (make-posn 15 7)
                                        (cons (make-posn 6 6)
                                              E-LOA))))))
(define A-LOS   (cons (make-posn 4 2)
                      (cons NO-SHOT
                            (cons (make-posn 17 3)
                                  E-LOS))))

(check-expect (cons? E-GLIST) #false)
(check-expect (cons? E-LOA) #false)
(check-expect (cons? E-LOS) #false)
(check-expect (cons? A-GLIST) #true)
(check-expect (cons? A-LOA) #true)
(check-expect (cons? A-LOS) #true)

(check-error (first E-GLIST))
(check-error (first E-LOA))
(check-error (first E-LOS))

(check-expect (first A-GLIST) "milk")
(check-expect (first A-LOA)   (make-posn 10 2))
(check-expect (first A-LOS)   (make-posn 4 2))

(check-expect (rest A-GLIST) (cons "apples" E-GLIST))
(check-expect (rest A-LOA)   (cons (make-posn 5 12)
                                   (cons (make-posn 4 8)
                                         (cons (make-posn 15 7)
                                               (cons (make-posn 6 6)
                                                     E-LOA)))))
(check-expect (rest A-LOS) (cons NO-SHOT (cons (make-posn 17 3) E-LOS)))

(check-error (rest E-GLIST))
(check-error (rest E-LOA))
(check-error (rest E-LOS))

(check-error (first (rest E-GLIST)))
(check-expect (first (rest A-GLIST)) "apples")

(check-error  (first (rest (rest A-GLIST))))
(check-expect (first (rest (rest A-LOA))) (make-posn 4 8))

(check-expect (second A-GLIST) (first (rest A-GLIST)))
(check-expect (third  A-LOA)  (first (rest (rest A-LOA))))

(check-error (cons 1 2))


(define THE-DIGITS (cons 0
                         (cons 1
                               (cons 2
                                     (cons 3
                                           (cons 4
                                                 (cons 5
                                                       (cons 6
                                                             (cons 7
                                                                   empty)))))))))
(check-expect (first THE-DIGITS) 0)
(check-expect (second THE-DIGITS) 1)
(check-expect (third THE-DIGITS) 2)
(check-expect (fourth THE-DIGITS) 3)
(check-expect (fifth THE-DIGITS) 4)
(check-expect (sixth THE-DIGITS) 5)
(check-expect (seventh THE-DIGITS) 6)
(check-expect (eighth THE-DIGITS) 7)

(define SOME-SQRS1 (cons (sqr 0)
                         (cons (sqr 1)
                               (cons (sqr 2)
                                     empty))))
                                     
(define SOME-SQRS2 '((sqr 0) (sqr 1) (sqr 2)))                                    

(check-expect SOME-SQRS1 '(0 1 4))
(check-expect (not (equal? SOME-SQRS1 SOME-SQRS2)) #true)

(define SOME-SQRS1-1 (cons (sqr 0)
                         (cons (sqr 1)
                               (cons (sqr 2)
                                     empty))))

(define SOME-SQRS2-1 (list (sqr 0) (sqr 1) (sqr 2)))

(check-expect SOME-SQRS1-1 '(0 1 4))
(check-expect (equal? SOME-SQRS1-1 SOME-SQRS2-1) #true)

(define X 2)
(define Y 3)
(define Z 4)

(define A-LIST  '((add1 X)  J  (* Z Y)))
(define A-LIST2 `(,(add1 X) J ,(* Z Y)))

(check-expect (first A-LIST)  '(add1 X))
(check-expect (first A-LIST2) 3)

(check-expect (second A-LIST)  'J)
(check-expect (second A-LIST2) 'J)

(check-expect (third A-LIST)  '(* Z Y))
(check-expect (third A-LIST2) 12)

