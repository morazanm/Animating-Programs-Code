#lang htdp/BSL

(require APS-Aliens-Attack)
(require 2htdp/image)
(require 2htdp/universe)
(require APS-Aliens-Attack)

#|
A rocket is an image-x

An alien is a posn: (make-posn image-x image-y)

A (listof alien), loa, is either:
  1. empty
  2. (cons alien loa)

An alien-direction is either:
  1. 'right
  2. 'left
  3. 'down

A shot is either:
  1. NO-SHOT
  2. A posn: (make-posn image-x image-y)

A (listof shot), los, is either:
  1. empty
  2. (cons shot los)

A key is either:
  1. "right"
  2. "left"
  3. " "
  4. Not "right", "left", or " "

A world is structure: (make-world rocket loa los alien-direction)
|#
(define-struct world (rocket aliens shots dir))

(define ALIENS-PER-LINE 12)

(define ALIEN-LINE-XLOW (- (floor (/ MAX-CHARS-HORIZONTAL 2))
                           (floor (/ ALIENS-PER-LINE 2))))

(define ALIEN-LINE-XHIGH (sub1 (+ (floor (/ MAX-CHARS-HORIZONTAL 2))
                                  (floor (/ ALIENS-PER-LINE 2)))))

(define ZERO 0)
(define THREE 3)
(define FIVE 5)

(define INIT-ALIEN (make-posn (floor (/ MAX-CHARS-HORIZONTAL 2)) 0))

;; image-y [image-x..image-x] → loa
;; Purpose: Create an loa with an alien for each value in
;; the given interval using the given image-y
(define (make-alien-line an-image-y low high)
  (if (> low high)
      '()
      (cons (make-posn low an-image-y)
            (make-alien-line an-image-y (add1 low) high))))

;; Sample instances of interval
(define LOW1 THREE)
(define HIGH1 ZERO)
(define LOW2 ZERO)
(define HIGH2 THREE)
(define LOW3 THREE)
(define HIGH3 FIVE)

;; Sample expressions for make-alien-line
(define LOW1-HIGH1-VAL '())
(define LOW2-HIGH2-VAL (cons (make-posn LOW2 3)
                             (make-alien-line 3 (add1 LOW2) HIGH2)))
(define LOW3-HIGH3-VAL (cons (make-posn LOW3 2)
                             (make-alien-line 2 (add1 LOW3) HIGH3)))

;; Tests using sample computations for make-alien-line
(check-expect (make-alien-line 3 LOW2 HIGH2) LOW2-HIGH2-VAL)
(check-expect (make-alien-line 2 LOW3 HIGH3) LOW3-HIGH3-VAL)

;; Tests using sample values for make-alien-line
(check-expect (make-alien-line 1 17 19)
              (list (make-posn 17 1)
                    (make-posn 18 1)
                    (make-posn 19 1)))

;; natnum → loa
;; Purpose: Create initial alien army
(define (create-alien-army num-lines)
  (if (= num-lines 0)
      '()
      (append
       (make-alien-line (sub1 num-lines)
                        ALIEN-LINE-XLOW
                        ALIEN-LINE-XHIGH)
       (create-alien-army (sub1 num-lines)))))

;; Sample expressions for create-alien-army
(define ZERO-VAL '())
(define THREE-VAL
  (append (make-alien-line (sub1 THREE)
                           ALIEN-LINE-XLOW
                           ALIEN-LINE-XHIGH)
          (create-alien-army (sub1 THREE))))
(define FIVE-VAL
  (append (make-alien-line (sub1 FIVE)
                           ALIEN-LINE-XLOW
                           ALIEN-LINE-XHIGH)
          (create-alien-army (sub1 FIVE))))

;; Tests using sample computations for create-alien-army
(check-expect (create-alien-army ZERO) ZERO-VAL)
(check-expect (create-alien-army THREE) THREE-VAL)
(check-expect (create-alien-army FIVE) FIVE-VAL)

;; Tests using sample values for create-alien-army
(check-expect (create-alien-army 1)
              (list (make-posn 4 0) (make-posn 5 0) (make-posn 6 0)
                    (make-posn 7 0) (make-posn 8 0) (make-posn 9 0)
                    (make-posn 10 0) (make-posn 11 0) (make-posn 12 0)
                    (make-posn 13 0) (make-posn 14 0) (make-posn 15 0)))

(define INIT-ROCKET (/ MAX-CHARS-HORIZONTAL 2))
(define INIT-LOA (create-alien-army 3))
(define INIT-DIR 'right)
(define INIT-LOS '())
(define INIT-WORLD (make-world INIT-ROCKET INIT-LOA INIT-LOS INIT-DIR))


;; world -> image
;; Purpose: Draw the given world in the empty scene
(define (draw-world w)
  (draw-los (world-shots w)
            (draw-loa (world-aliens w)
                      (draw-rocket (world-rocket w) E-SCENE))))

;; world key -> world
;; Purpose: Process the given key to return the next world
(define (process-key w k)
  (cond [(key=? k "right")
         (make-world (move-rckt-right (world-rocket w))
                     (world-aliens w)
                     (world-shots w)
                     (world-dir w))]
        [(key=? k "left")
         (make-world (move-rckt-left (world-rocket w))
                     (world-aliens w)
                     (world-shots w)
                     (world-dir w))]
        [(key=? k " ")
         (make-world (world-rocket w)
                     (world-aliens w)
                     (cons (process-shooting (world-rocket w))
                           (world-shots w))
                     (world-dir w))]
        [else w]))

(check-expect (process-key INIT-WORLD "right")
              (make-world (add1 INIT-ROCKET)
                          INIT-LOA
                          INIT-LOS
                          INIT-DIR))

(check-expect (process-key INIT-WORLD "left")
              (make-world (sub1 INIT-ROCKET)
                          INIT-LOA
                          INIT-LOS
                          INIT-DIR))

(check-expect (process-key INIT-WORLD " ")
              (make-world INIT-ROCKET
                          INIT-LOA
                          (list (make-posn
                                 (world-rocket INIT-WORLD)
                                 (sub1 MAX-CHARS-VERTICAL)))
                          INIT-DIR))

(check-expect (process-key INIT-WORLD "m")
              (make-world INIT-ROCKET
                          INIT-LOA
                          INIT-LOS
                          INIT-DIR))

;; alien alien-direction -> alien
;; Purpose: Move the given alien in the given alien-direction
(define (move-alien an-alien a-dir)
  (cond [(eq? a-dir 'right) (move-alien-right an-alien)]
        [(eq? a-dir 'left) (move-alien-left an-alien)]
        [else (move-alien-down an-alien)]))

(check-expect (move-alien INIT-ALIEN 'right)
              (make-posn (add1 (posn-x INIT-ALIEN))
                         (posn-y INIT-ALIEN)))

(check-expect (move-alien INIT-ALIEN 'left)
              (make-posn (sub1 (posn-x INIT-ALIEN))
                         (posn-y INIT-ALIEN)))

(check-expect (move-alien INIT-ALIEN 'down)
              (make-posn (posn-x INIT-ALIEN)
                         (add1 (posn-y INIT-ALIEN))))

;; alien alien-direction -> alien-direction
;; Purpose: Return the alien-direction for the given alien
;;          moved in the given alien-direction
(define (new-direction-after-tick an-alien a-dir)
  (cond [(eq? a-dir 'right) (new-dir-after-right an-alien)]
        [(eq? a-dir 'left) (new-dir-after-left an-alien)]
        [else (new-dir-after-down an-alien)]))

(check-expect (new-direction-after-tick INIT-ALIEN 'right)
              'right)

(check-expect (new-direction-after-tick INIT-ALIEN 'left)
              'left)

(check-expect (new-direction-after-tick (make-posn 19 5) 'right)
              'down)

(check-expect (new-direction-after-tick (make-posn 0 3) 'left)
              'down)

(check-expect (new-direction-after-tick (make-posn 19 5) 'down)
              'left)

(check-expect (new-direction-after-tick (make-posn 0 3) 'down)
              'right)

;; world -> world
;; Purpose: Return next world after a clock tick by moving
;;          the given world's alien and updating the given
;;          world's alien-direction for the mover alien
(define (process-tick w)
  (make-world (world-rocket w)
              (remove-hit-aliens
               (move-loa (world-aliens w)
                         (world-dir w))
               (move-los (world-shots w)))
              (remove-shots
               (move-los (world-shots w))
               (move-loa (world-aliens w)
                         (world-dir w)))               
              (new-direction-after-tick (move-loa (world-aliens w)
                                                  (world-dir w))
                                        (world-dir w))))

(check-expect (process-tick INIT-WORLD)
              (make-world (world-rocket INIT-WORLD)
                          (move-loa
                           (world-aliens INIT-WORLD)
                           (world-dir INIT-WORLD))
                          (move-los (world-shots INIT-WORLD))
                          (world-dir INIT-WORLD)))

(check-expect (process-tick (make-world
                             2
                             (list (make-posn 1 11))
                             (list (make-posn 13 0))
                             'left))
              (make-world 2
                          (list (make-posn 0 11))
                          '()
                          'down))

(check-expect (process-tick (make-world
                             9
                             (list (make-posn 19 1))
                             '()
                             'down))
              (make-world 9
                          (list (make-posn 19 2))
                          '()
                          'left))

(check-expect (process-tick (make-world
                             9
                             (list (make-posn 19 1))
                             (list (make-posn 8 8))
                             'down))
              (make-world 9
                          (list (make-posn 19 2))
                          (list (make-posn 8 7))
                          'left))

;; world -> Boolean
;; Purpose: Determine if the game is over
(define (game-over? w)
  (or (any-alien-reached-earth? (world-aliens w))
      (empty? (world-aliens w))))

(check-expect (game-over? INIT-WORLD) #f)
(check-expect (game-over? (make-world 6
                                      (list (make-posn
                                             0
                                             (sub1 MAX-CHARS-VERTICAL)))
                                      (list (make-posn 17 12))
                                      'right))
                                      
              #t)
(check-expect (game-over? (make-world 6
                                      (list (make-posn
                                             0
                                             (sub1 MAX-CHARS-VERTICAL)))
                                      '()
                                      'right))
                                      
              #t)
(check-expect
 (game-over? (make-world 12
                         '()
                         (list (make-posn 15 6))
                         'right))
                                      
 #t)

;; world -> image
;; Purpose: Draw the world when the game is over
(define (draw-last-world w)
  (if (any-alien-reached-earth? (world-aliens w))
      (place-image (text "EARTH IS CONQUERED!"
                         26
                         'red)
                   (/ E-SCENE-W 2)
                   (/ E-SCENE-H 4)
                   (draw-world w))
      (place-image (text "EARTH IS SAVED!"
                         26
                         'darkgreen)
                   (/ E-SCENE-W 2)
                   (/ E-SCENE-H 4)
                   (draw-world w))))

; string → world
; Purpose: To run the game
(define (run a-name)
  (big-bang INIT-WORLD
    [on-draw draw-world]
    [name a-name]
    [on-key process-key]
    [on-tick process-tick TICK-RATE]
    [close-on-stop #false]
    [stop-when game-over? draw-last-world]))
