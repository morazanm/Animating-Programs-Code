;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname motor-vehicles) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
#|
A car is a structure, (make-carr integer>=0 integer>=0 integer>=0 integer>=0
Boolean), with a number of doors, a tank capacity in gallons, miles per
gallon, a maximum speed, and economy mode flag.

;; Sample instances of car
(define CARR1 ...)

;; carr ... --> ...
;; Purpose: ...
(define (f-on-carr a-carr ...)
  ...(carr-gallons a-carr)...(carr-mpg a-carr)
  ...(carr-maxspeed a-carr)...(carr-mode a-carr))

;; Sample expressions for f-on-carr
(define CARR1-VAL ...CARR1...)
   ...

;; Tests using sample computations for f-on-carr
(check-expect (f-on-carr CARR1 ...) CARR1-VAL)
   ...

;; Tests using sample values for f-on-carr
(check-expect (f-on-carr ...) ...)
   ...

A motorcycle, mc, is a structure, (make-mc integer>=0 integer>=0 integer>=0),
with a tank capacity in gallons, miles per gallon, and a maximum speed.

;; Sample instances of mc 
(define MC1 ...)

;; mc ... --> ...
;; Purpose: ...
(define (f-on-mc an-mc ...)
  ...(mc-gallons an-mc)...(mc-mpg an-mc)
  ...(mc-maxspeed an-mc)...)

;; Sample expressions for f-on-mc
(define MC1-VAL ...MC1...)
   ...

;; Tests using sample computations for f-on-mc
(check-expect (f-on-mc MC1 ...) MC1-VAL)
   ...

;; Tests using sample values for f-on-mc
(check-expect (f-on-mc ...) ...)
   ...

A personal transporter, pt, is a structure, (make-pt integer>=0 integer>=0 integer>=0),
with a maximum miles per hour and a maximum hours per charge.

;; Sample instances of pt
(define PT1 ...)

;; pt ... --> ...
;; Purpose: ...
(define (f-on-pt a-pt ...)
  ...(pt-mph a-pt)...(pt-hpc a-pt))

;; Sample expressions for f-on-pt
(define PT1-VAL ...PT1...)
   ...

;; Tests using sample computations for f-on-pt
(check-expect (f-on-pt PT1 ...) PT1-VAL)
   ...

;; Tests using sample values for f-on-pt
(check-expect (f-on-pt ...) ...)
   ...


A motor vehicle, mv, is either:
  1. car
  2. mc
  3. pt

;; Sample instances of mv
(define MVCAR1 ...)
(define MVMC1  ...)
(define MVPT1  ...)

;; mv ... --> ...
;; Purpose: ...
(define (f-on-mv an-mv ...)
  (cond [(car? an-mv) (f-on-car an-mv ...)]
        [(car? an-mv) (f-on-mc  an-mv ...)]
        [else (f-on-mv an-mv ...)]))

;; Sample expressions for f-on-mv
(define MVCAR1-VAL ...MVCAR1...)
(define MVMC1-VAL  ...MVMC1...)
(define MVPT1-VAL  ...MVPT1...)
   ...

;; Tests using sample computations for f-on-mv
(check-expect (f-on-mv MVCAR1 ...) MVCAR1-VAL)
(check-expect (f-on-mv MVMC1 ...)  MVMC1-VAL)
(check-expect (f-on-mv MVPT1 ...)  MVPT1-VAL)
   ...

;; Tests using sample values for f-on-mv
(check-expect (f-on-mv ...) ...)
   ...


|#

;; Structures Definitions
(define-struct carr (gallons mpg maxspeed mode))
(define-struct mc (gallons mpg maxspeed))
(define-struct pt (mph hpc))

;; Sample Instances

(define CARR1 (make-carr 20 35 140 #true))
(define CARR2 (make-carr 22 15 160 #false))
(define MC1   (make-mc   8  22 135))
(define MC2   (make-mc   10 20 145))
(define PT1   (make-pt   7  7))
(define PT2   (make-pt   6 10))
(define MVCARR1 CARR1)
(define MVCARR2 CARR2)
(define MVMC1   MC1)
(define MVMC2   MC2)
(define MVPT1   PT1)
(define MVPT2   PT2)


;; carr --> number>=0
;; Purpose: Return max distance the given carr may travel on full
;; Assumption: (* 1.2 integer>=0 integer>=0) is an exact number>=0
(define (carr-maxdistance a-carr)
  (if (carr-mode a-carr)
      (* 1.2 (carr-gallons a-carr) (carr-mpg a-carr))
      (* (carr-gallons a-carr) (carr-mpg a-carr))))

;; Sample expressions for f-on-carr
(define CARR1-VAL (* 1.2 (carr-gallons  CARR1) (carr-mpg  CARR1)))
(define CARR2-VAL (* (carr-gallons  CARR2) (carr-mpg  CARR2)))

;; Tests using sample computations for carr-maxdistance
(check-expect (carr-maxdistance CARR1) CARR1-VAL )
(check-expect (carr-maxdistance CARR2) CARR2-VAL )

;; Tests using sample values for carr-maxdistance
(check-expect (carr-maxdistance (make-carr 9 21 10 #true)) 226.8 )
(check-expect (carr-maxdistance (make-carr 9 21 10 #false)) 189 )



;; mc --> integer>=0
;; Purpose: Return max distance the given mc may travel on full
(define (mc-maxdistance an-mc)
  (* (mc-gallons an-mc) (mc-mpg an-mc)))

;; Sample expressions for mc-maxdistance
(define MC1-VAL (* (mc-gallons  MC1) (mc-mpg  MC1)))
(define MC2-VAL (* (mc-gallons  MC2) (mc-mpg  MC2)))

;; Tests using sample computations for mc-maxdistance
(check-expect (mc-maxdistance MC1) MC1-VAL)
(check-expect (mc-maxdistance MC1) MC1-VAL)

;; Tests using sample values for mc-maxdistance
(check-expect (mc-maxdistance (make-mc 10 10 120)) 100)
(check-expect (mc-maxdistance (make-mc 8  15 105)) 120)



;; pt --> integer>=0
;; Purpose: Return max distance the given pt may travel on full
(define (pt-maxdistance a-pt)
  (* (pt-mph a-pt) (pt-hpc a-pt)))

;; Sample expressions for f-on-pt
(define PT1-VAL (* (pt-mph PT1) (pt-hpc PT1)))
(define PT2-VAL (* (pt-mph PT2) (pt-hpc PT2)))

;; Tests using sample computations for pt-maxdistance
(check-expect (pt-maxdistance PT1) PT1-VAL)
(check-expect (pt-maxdistance PT2) PT2-VAL)

;; Tests using sample values for pt-maxdistance
(check-expect (pt-maxdistance (make-pt 4 5)) 20)



;; mv --> number>=0
;; Purpose: Return max distance the given mv may travel on full
(define (mv-maxdistance an-mv)
  (cond [(carr? an-mv) (carr-maxdistance an-mv)]
        [(mc? an-mv) (mc-maxdistance  an-mv)]
        [else (pt-maxdistance an-mv)]))

;; Sample expressions for mv-maxdistance
(define MVCARR1-VAL (carr-maxdistance MVCARR1))
(define MVCARR2-VAL (carr-maxdistance MVCARR2))
(define MVMC1-VAL  (mc-maxdistance    MVMC1))
(define MVMC2-VAL  (mc-maxdistance    MVMC2))
(define MVPT1-VAL  (pt-maxdistance    MVPT1))
(define MVPT2-VAL  (pt-maxdistance    MVPT2))

;; Tests using sample computations for mv-maxdistance
(check-expect (mv-maxdistance MVCARR1) MVCARR1-VAL )
(check-expect (mv-maxdistance MVCARR2) MVCARR2-VAL )
(check-expect (mv-maxdistance MVMC1)   MVMC1-VAL )
(check-expect (mv-maxdistance MVMC2)   MVMC2-VAL )
(check-expect (mv-maxdistance MVPT1)   MVPT1-VAL )
(check-expect (mv-maxdistance MVPT2)   MVPT2-VAL )

;; Tests using sample values for mv-maxdistance
(check-expect (mv-maxdistance (make-carr 25 40 140 #true))  1200 )
(check-expect (mv-maxdistance (make-carr 25 40 140 #false)) 1000 )
(check-expect (mv-maxdistance (make-mc 12 25 140)) 300 )
(check-expect (mv-maxdistance (make-pt 8 5)) 40 )
