#lang htdp/BSL

(require APS-Aliens-Attack)

(require 2htdp/image)
(require 2htdp/universe)
(require APS-Aliens-Attack)

#|
A rocket is an image-x

An alien is a posn: (make-posn image-x image-y)

An alien-direction is either:
  1. 'right
  2. 'left
  3. 'down

A world is structure: (make-world rocket alien alien-direction)
|#
(define-struct world (rocket alien dir))

(define INIT-ROCKET (/ MAX-CHARS-HORIZONTAL 2))
(define INIT-ALIEN (make-posn (/ MAX-CHARS-HORIZONTAL 2) 0))
(define INIT-DIR 'right)
(define INIT-WORLD (make-world INIT-ROCKET INIT-ALIEN INIT-DIR))

;; world -> image
;; Purpose: Draw the given world in the empty scene
(define (draw-world w)
  (draw-alien (world-alien w)
              (draw-rocket (world-rocket w) E-SCENE)))

;; world key -> world
;; Purpose: Process the given key to return the next world
(define (process-key w k)
  (cond [(key=? k "right")
         (make-world (move-rckt-right (world-rocket w))
                     (world-alien w)
                     (world-dir w))]
        [(key=? k "left")
         (make-world (move-rckt-left (world-rocket w))
                     (world-alien w)
                     (world-dir w))]
        [else w]))

(check-expect (process-key INIT-WORLD "right")
              (make-world (add1 INIT-ROCKET)
                          INIT-ALIEN
                          INIT-DIR))

(check-expect (process-key INIT-WORLD "left")
              (make-world (sub1 INIT-ROCKET)
                          INIT-ALIEN
                          INIT-DIR))

(check-expect (process-key INIT-WORLD " ")
              (make-world INIT-ROCKET
                          INIT-ALIEN
                          INIT-DIR))

(check-expect (process-key INIT-WORLD "m")
              (make-world INIT-ROCKET
                          INIT-ALIEN
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
              (move-alien (world-alien w) (world-dir w))
              (new-direction-after-tick (move-alien (world-alien w)
                                                    (world-dir w))
                                        (world-dir w))))

(check-expect (process-tick INIT-WORLD)
              (make-world (world-rocket INIT-WORLD)
                          (make-posn
                           (add1 (posn-x (world-alien INIT-WORLD)))
                           (posn-y (world-alien INIT-WORLD)))                                   
                          (world-dir INIT-WORLD)))

(check-expect (process-tick (make-world
                             2
                             (make-posn 1 11)
                             'left))
              (make-world 2 (make-posn 0 11) 'down))

(check-expect (process-tick (make-world
                             9
                             (make-posn 19 1)
                             'down))
              (make-world 9 (make-posn 19 2) 'left))

;; world -> Boolean
;; Purpose: Determine if the game is over
(define (game-over? w)
  (alien-reached-earth? (world-alien w)))

(check-expect (game-over? INIT-WORLD) #f)
(check-expect (game-over? (make-world 6
                                      (make-posn
                                       0
                                       (sub1 MAX-CHARS-VERTICAL))
                                      'right))
                                      
              #t)

;; world -> image
;; Purpose: Draw the world when the game is over
(define (draw-last-world w)
  (place-image (text "EARTH IS CONQUERED"
                     26
                     'red)
               (/ E-SCENE-W 2)
               (/ E-SCENE-H 4)
               (draw-world w)))

; string → world
; Purpose: To run the game
(define (run a-name)
  (big-bang INIT-WORLD
    [on-draw draw-world]
    [name a-name]
    [on-key process-key]
    [on-tick process-tick TICK-RATE]
    [stop-when game-over? draw-last-world]))
