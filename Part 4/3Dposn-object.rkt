;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3Dposn-object) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(require 2htdp/abstraction)

;; number number number \arrow 3Dposn
;; Purpose: To return an instance of a \texttt{3Dposn}
(define (make-3Dposn x y z)
  (local [;; 3Dposn \arrow number
          ;; Purpose: Return distance to origin of this 3Dposn
          (define (dist-origin x y z)
            (sqrt (+ (sqr x) (sqr y) (sqr z))))

          ;; 3Dpson --> number
          ;; Purpose: Compute the distance from this to the given 3Dposn
          (define (distance a-3dposn)
            (sqrt (+ (sqr (- x (3Dposn-x a-3dposn)))
                     (sqr (- y (3Dposn-y a-3dposn)))
                     (sqr (- z (3Dposn-z a-3dposn))))))

          ;; message --> service
          ;; Purpose: To manage messages for a 3Dposn
          (define (manager m)
            (match m
              ['getx x]
              ['gety y]
              ['getz z]
              ['d2o  (dist-origin x y z)]
              ['d2p  distance]
              [else (error (string-append "Unknown message to 3Dposn: "
                                          (symbol->string m)))]))]
    manager))

;; Sample instances of 3Dposn
(define ORIGIN  (make-3Dposn 0 0 0))
(define A3DPOSN (make-3Dposn 2 3 5))
(define B3DPOSN (make-3Dposn 1 1 1))

;; Tests using sample computations for 3Dposn
(check-within (ORIGIN  'getx) 0    0.01)
(check-within (A3DPOSN 'gety) 3    0.01)
(check-within (ORIGIN  'getz) 0    0.01)
(check-within (A3DPOSN 'd2o)  6.16 0.01)

;; Tests using sample values for 3Dposn
(check-within ((make-3Dposn 10 20 30) 'd2o)
              37.42 0.01)
(check-error (A3DPOSN 'move-r)
             "Unknown message to 3Dposn: move-r")

;; Wrapper Functions

;; 3Dposn --> number
;; Purpose: Return the x-coordinate of the given 3Dposn
(define (3Dposn-x a-3dposn) (a-3dposn 'getx))

;; Sample expressions for 3Dposn-x
(define ORIGINX  (ORIGIN  'getx))
(define A3DPOSNX (A3DPOSN 'getx))

;; Tests using sample computations for 3Dposn-x
(check-within (3Dposn-x ORIGIN)  ORIGINX  0.01)
(check-within (3Dposn-x A3DPOSN) A3DPOSNX 0.01)

;; Tests using sample values for 3Dposn-x
(check-within (3Dposn-x (make-3Dposn 10 20 30)) 10 0.01)

;; 3Dposn --> number
;; Purpose: Return the y-coordinate of the given 3Dposn
(define (3Dposn-y a-3dposn) (a-3dposn 'gety))

;; Sample expressions for 3Dposn-y
(define ORIGINY  (ORIGIN  'gety))
(define A3DPOSNY (A3DPOSN 'gety))

;; Tests using sample computations for 3Dposn-y
(check-within (3Dposn-y ORIGIN)  ORIGINY  0.01)
(check-within (3Dposn-y A3DPOSN) A3DPOSNY 0.01)

;; Tests using sample values for 3Dposn-y
(check-within (3Dposn-y (make-3Dposn 10 20 30)) 20 0.01)

;; 3Dposn --> number
;; Purpose: Return the z-coordinate of the given 3Dposn
(define (3Dposn-z a-3dposn) (a-3dposn 'getz))

;; Sample expressions for 3Dposn-z
(define ORIGINZ  (ORIGIN  'getz))
(define A3DPOSNZ (A3DPOSN 'getz))

;; Tests using sample computations for 3Dposn-z
(check-within (3Dposn-z ORIGIN)  ORIGINZ  0.01)
(check-within (3Dposn-z A3DPOSN) A3DPOSNZ 0.01)

;; Tests using sample values for 3Dposn-z
(check-within (3Dposn-z (make-3Dposn 10 20 30)) 30 0.01)

;; 3Dposn --> number
;; Purpose: Return the distance to origin of the given 3Dposn
(define (dist-origin a-3dposn) (a-3dposn 'd2o))

;; Sample expressions for dist-origin
(define ORIGIND  (ORIGIN  'd2o))
(define A3DPOSND (A3DPOSN 'd2o))

;; Tests using sample computations for dist-origin
(check-within (dist-origin ORIGIN)  ORIGIND  0.01)
(check-within (dist-origin A3DPOSN) A3DPOSND 0.01)

;; Tests using sample values for dist-origin
(check-within (dist-origin (make-3Dposn 10 20 30)) 37.42 0.01)

;; 3Dposn 3Dposn --> number
;; Purpose: Return the distance between the given 3Dposns
(define (3Dposn-distance p1 p2) ((p1 'd2p) p2))

;; Sample expressions for 3Dposn-distance
(define ORIGINDP  ((ORIGIN  'd2p) ORIGIN))
(define A3DPOSNDP ((A3DPOSN 'd2p) B3DPOSN))

;; Tests using sample computations 3Dposn-distance
(check-within (3Dposn-distance ORIGIN ORIGIN)    ORIGINDP  0.01)
(check-within (3Dposn-distance A3DPOSN B3DPOSN) A3DPOSNDP 0.01)

;; Tests using sample values for 3Dposn-distance
(check-within (3Dposn-distance (make-3Dposn 10 20 30)
                               (make-3Dposn 2  3   4))
              32.07
              0.01)



