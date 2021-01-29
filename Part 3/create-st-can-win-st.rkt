;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname create-st-can-win-st) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; A board is a structure: (make-board bval bval bval bval bval bval bval bval bval)
(define-struct board (p0 p1 p2 p3 p4 p5 p6 p7 p8))

;; A node is a structure: (make-node board (listof st))
(define-struct node (board children))

;; A solution tree (st) is either:
;;  1. '()
;;  2. node

;; Sample board values
(define INIT-BOARD (make-board 'B 'B 'B 'B 'B 'B 'B 'B 'B))
(define BOARD1     (make-board 'X 'O 'X
                               'O 'X 'O
                               'X 'O 'X))
(define BOARD2     (make-board 'X 'B 'B
                               'O 'B 'B
                               'B 'B 'B))
(define BOARD3     (make-board 'X 'B 'B
                               'X 'O 'B
                               'B 'B 'B))
(define BOARD7     (make-board 'X 'B 'O
                               'B 'X 'X
                               'O 'X 'O))

;; board bpos turn --> board
;; Purpose: Place the given turn on the given board at the given board position
(define (place-on-board a-board a-pos a-turn)
  (cond [(= a-pos 0)
         (make-board a-turn             (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 1)
         (make-board (board-p0 a-board) a-turn             (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 2)
         (make-board (board-p0 a-board) (board-p1 a-board) a-turn
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 3)
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     a-turn             (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 4)
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) a-turn             (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 5)
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) a-turn
                     (board-p6 a-board) (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 6)
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     a-turn             (board-p7 a-board) (board-p8 a-board))]
        [(= a-pos 7)
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) a-turn             (board-p8 a-board))]
        [else
         (make-board (board-p0 a-board) (board-p1 a-board) (board-p2 a-board)
                     (board-p3 a-board) (board-p4 a-board) (board-p5 a-board)
                     (board-p6 a-board) (board-p7 a-board) a-turn)]))

;; Sample expressions for place-on-board
(define PLACE0 (make-board 'X                    (board-p1 INIT-BOARD) (board-p2 INIT-BOARD)
                           (board-p3 INIT-BOARD) (board-p4 INIT-BOARD) (board-p5 INIT-BOARD)
                           (board-p6 INIT-BOARD) (board-p7 INIT-BOARD) (board-p8 INIT-BOARD)))
(define PLACE1 (make-board (board-p0 INIT-BOARD) 'X                    (board-p2 INIT-BOARD)
                           (board-p3 INIT-BOARD) (board-p4 INIT-BOARD) (board-p5 INIT-BOARD)
                           (board-p6 INIT-BOARD) (board-p7 INIT-BOARD) (board-p8 INIT-BOARD)))
(define PLACE2 (make-board (board-p0 INIT-BOARD) (board-p1 INIT-BOARD) 'X
                           (board-p3 INIT-BOARD) (board-p4 INIT-BOARD) (board-p5 INIT-BOARD)
                           (board-p6 INIT-BOARD) (board-p7 INIT-BOARD) (board-p8 INIT-BOARD)))
(define PLACE3 (make-board (board-p0 INIT-BOARD) (board-p1 INIT-BOARD) (board-p2 INIT-BOARD)
                           'X                    (board-p4 INIT-BOARD) (board-p5 INIT-BOARD)
                           (board-p6 INIT-BOARD) (board-p7 INIT-BOARD) (board-p8 INIT-BOARD)))
(define PLACE4 (make-board (board-p0 INIT-BOARD) (board-p1 INIT-BOARD) (board-p2 INIT-BOARD)
                           (board-p3 INIT-BOARD) 'X                    (board-p5 INIT-BOARD)
                           (board-p6 INIT-BOARD) (board-p7 INIT-BOARD) (board-p8 INIT-BOARD)))
(define PLACE5 (make-board (board-p0 BOARD1) (board-p1 BOARD1) (board-p2 BOARD1)
                           (board-p3 BOARD1) (board-p4 BOARD1) 'O
                           (board-p6 BOARD1) (board-p7 BOARD1) (board-p8 BOARD1)))
(define PLACE6 (make-board (board-p0 BOARD1) (board-p1 BOARD1) (board-p2 BOARD1)
                           (board-p3 BOARD1) (board-p4 BOARD1) (board-p5 BOARD1)
                           'O                (board-p7 BOARD1) (board-p8 BOARD1)))
(define PLACE7 (make-board (board-p0 BOARD1) (board-p1 BOARD1) (board-p2 BOARD1)
                           (board-p3 BOARD1) (board-p4 BOARD1) (board-p5 BOARD1)
                           (board-p6 BOARD1) 'O                (board-p8 BOARD1)))
(define PLACE8 (make-board (board-p0 BOARD1) (board-p1 BOARD1) (board-p2 BOARD1)
                           (board-p3 BOARD1) (board-p4 BOARD1) (board-p5 BOARD1)
                           (board-p6 BOARD1) (board-p7 BOARD1) 'O))

;; Tests using sample computations for place-on-board
(check-expect (place-on-board INIT-BOARD 0 'X) PLACE0)
(check-expect (place-on-board INIT-BOARD 1 'X) PLACE1)
(check-expect (place-on-board INIT-BOARD 2 'X) PLACE2)
(check-expect (place-on-board INIT-BOARD 3 'X) PLACE3)
(check-expect (place-on-board INIT-BOARD 4 'X) PLACE4)
(check-expect (place-on-board BOARD1     5 'O) PLACE5)
(check-expect (place-on-board BOARD1     6 'O) PLACE6)
(check-expect (place-on-board BOARD1     7 'O) PLACE7)
(check-expect (place-on-board BOARD1     8 'O) PLACE8)

;; Tests using sample values for place-on-board
(check-expect (place-on-board (make-board 'B 'X 'O 'X 'O 'X 'O 'X 'O) 0 'X)
              (make-board 'X 'X 'O 'X 'O 'X 'O 'X 'O))
(check-expect (place-on-board (make-board 'B 'X 'O 'X 'B 'X 'O 'X 'O) 4 'O)
              (make-board 'B 'X 'O 'X 'O 'X 'O 'X 'O))


;; board (listof bpos) turn --> (listof st)
;; Purpose: Build the st for the given board and its given list of blank positions
(define (process-blanks a-board a-lobpos a-turn)
  (if (empty? a-lobpos)
      '()
      (cons (create-st (place-on-board a-board (first a-lobpos) a-turn)
                       (if (eq? a-turn 'X) 'O 'X))
            (process-blanks a-board (rest a-lobpos) a-turn))))


;; board --> (listof natnums)
;; Purpose: Return a list of blank positions in the given board
(define (find-blanks a-board)
  (append (if (eq? (board-p0 a-board) 'B) (list 0) '())
          (if (eq? (board-p1 a-board) 'B) (list 1) '())
          (if (eq? (board-p2 a-board) 'B) (list 2) '())
          (if (eq? (board-p3 a-board) 'B) (list 3) '())
          (if (eq? (board-p4 a-board) 'B) (list 4) '())
          (if (eq? (board-p5 a-board) 'B) (list 5) '())
          (if (eq? (board-p6 a-board) 'B) (list 6) '())
          (if (eq? (board-p7 a-board) 'B) (list 7) '())
          (if (eq? (board-p8 a-board) 'B) (list 8) '())))

;; Sample expressions for find-blanks
(define BLANKS-INIT
  (append (if (eq? (board-p0 INIT-BOARD) 'B) (list 0) '())
          (if (eq? (board-p1 INIT-BOARD) 'B) (list 1) '())
          (if (eq? (board-p2 INIT-BOARD) 'B) (list 2) '())
          (if (eq? (board-p3 INIT-BOARD) 'B) (list 3) '())
          (if (eq? (board-p4 INIT-BOARD) 'B) (list 4) '())
          (if (eq? (board-p5 INIT-BOARD) 'B) (list 5) '())
          (if (eq? (board-p6 INIT-BOARD) 'B) (list 6) '())
          (if (eq? (board-p7 INIT-BOARD) 'B) (list 7) '())
          (if (eq? (board-p8 INIT-BOARD) 'B) (list 8) '())))

(define BLANKS-B2
  (append (if (eq? (board-p0 BOARD2) 'B) (list 0) '())
          (if (eq? (board-p1 BOARD2) 'B) (list 1) '())
          (if (eq? (board-p2 BOARD2) 'B) (list 2) '())
          (if (eq? (board-p3 BOARD2) 'B) (list 3) '())
          (if (eq? (board-p4 BOARD2) 'B) (list 4) '())
          (if (eq? (board-p5 BOARD2) 'B) (list 5) '())
          (if (eq? (board-p6 BOARD2) 'B) (list 6) '())
          (if (eq? (board-p7 BOARD2) 'B) (list 7) '())
          (if (eq? (board-p8 BOARD2) 'B) (list 8) '())))

;; Tests using sample computations for find-blanks
(check-expect (find-blanks INIT-BOARD) BLANKS-INIT)
(check-expect (find-blanks BOARD2)     BLANKS-B2)

;; Tests using sample values for find-blanks
(check-expect (find-blanks (make-board 'B 'X 'O 'X 'B 'B 'O 'X 'B))
              (list 0 4 5 8))

;; board turn --> st
;; Purpose: Create the st for the given board
(define (create-st a-board a-turn)
  (make-node a-board
             (process-blanks a-board (find-blanks a-board) a-turn)))

;; Sample expressions for process-blanks
(define PROC-0BLANKS  '())
(define PROC-6BLANKS (cons (create-st (place-on-board BOARD3 (first '(1 2 5 6 7 8)) 'O)
                                      (if (eq? 'O 'X) 'O 'X))
                           (process-blanks BOARD3 (rest '(1 2 5 6 7 8)) 'O)))

;; Tests using sample computations for process-blanks
(check-expect (process-blanks BOARD1 '()            'X) PROC-0BLANKS)
(check-expect (process-blanks BOARD3 '(1 2 5 6 7 8) 'O) PROC-6BLANKS)

;; Tests using sample values for process-blanks
(check-expect (process-blanks (make-board 'B 'X 'O 'O 'X 'X 'O 'X 'O) '(0) 'X)
              (list (make-node (make-board 'X 'X 'O 'O 'X 'X 'O 'X 'O) '())))


;; Sample expressions for create-st
(define BOARD1-VAL (make-node BOARD1
                              (process-blanks BOARD1
                                              (find-blanks BOARD1)
                                              'O)))
(define BOARD2-VAL (make-node BOARD2
                              (process-blanks BOARD2
                                              (find-blanks BOARD2)
                                              'X)))

;; Tests using sample computations for create-st
(check-expect (create-st BOARD1 'O) BOARD1-VAL)
(check-expect (create-st BOARD2 'X) BOARD2-VAL)

;; Tests using sample values for create-st
(check-expect (create-st (make-board 'X 'O 'X 'O 'X 'O 'X 'B 'B) 'O)
              (make-node
               (make-board 'X 'O 'X 'O 'X 'O 'X 'B 'B)
               (list
                (make-node
                 (make-board 'X 'O 'X 'O 'X 'O 'X 'O 'B)
                 (list
                  (make-node
                   (make-board 'X 'O 'X 'O 'X 'O 'X 'O 'X)
                   '())))
                (make-node
                 (make-board 'X 'O 'X 'O 'X 'O 'X 'B 'O)
                 (list
                  (make-node
                   (make-board 'X 'O 'X 'O 'X 'O 'X 'X 'O)
                   '()))))))

;; board turn --> Boolean
;; Purpose: Determine if the given turn has three in a row
(define (has-win? a-board a-turn)
  (or (and (eq? (board-p0 a-board) (board-p1 a-board))
           (eq? (board-p1 a-board) (board-p2 a-board))
           (eq? (board-p2 a-board) a-turn))
      (and (eq? (board-p3 a-board) (board-p4 a-board))
           (eq? (board-p4 a-board) (board-p5 a-board))
           (eq? (board-p5 a-board) a-turn))
      (and (eq? (board-p6 a-board) (board-p7 a-board))
           (eq? (board-p7 a-board) (board-p8 a-board) )
           (eq? (board-p8 a-board) a-turn))
      (and (eq? (board-p0 a-board) (board-p3 a-board))
           (eq? (board-p3 a-board) (board-p6 a-board))
           (eq? (board-p6 a-board) a-turn))
      (and (eq? (board-p1 a-board) (board-p4 a-board))
           (eq? (board-p4 a-board) (board-p7 a-board))
           (eq? (board-p7 a-board) a-turn))
      (and (eq? (board-p2 a-board) (board-p5 a-board))
           (eq? (board-p5 a-board) (board-p8 a-board))
           (eq? (board-p8 a-board) a-turn))
      (and (eq? (board-p0 a-board) (board-p4 a-board))
           (eq? (board-p4 a-board) (board-p8 a-board))
           (eq? (board-p8 a-board) a-turn))
      (and (eq? (board-p2 a-board) (board-p4 a-board))
           (eq? (board-p4 a-board) (board-p6 a-board))
           (eq? (board-p6 a-board) a-turn))))


;; Sample st values
(define INIT-ST (create-st INIT-BOARD 'X))
(define BRD7-ST (create-st BOARD7     'O))

;; Sample expressions for has-win?
(define O-WIN-FALSE (or (and (eq? (board-p0 BOARD7) (board-p1 BOARD7))
                             (eq? (board-p1 BOARD7) (board-p2 BOARD7))
                             (eq? (board-p2 BOARD7) 'O))
                        (and (eq? (board-p3 BOARD7) (board-p4 BOARD7))
                             (eq? (board-p4 BOARD7) (board-p5 BOARD7))
                             (eq? (board-p5 BOARD7) 'O))
                        (and (eq? (board-p6 BOARD7) (board-p7 BOARD7))
                             (eq? (board-p7 BOARD7) (board-p8 BOARD7) )
                             (eq? (board-p8 BOARD7) 'O))
                        (and (eq? (board-p0 BOARD7) (board-p3 BOARD7))
                             (eq? (board-p3 BOARD7) (board-p6 BOARD7))
                             (eq? (board-p6 BOARD7) 'O))
                        (and (eq? (board-p1 BOARD7) (board-p4 BOARD7))
                             (eq? (board-p4 BOARD7) (board-p7 BOARD7))
                             (eq? (board-p7 BOARD7) 'O))
                        (and (eq? (board-p2 BOARD7) (board-p5 BOARD7))
                             (eq? (board-p5 BOARD7) (board-p8 BOARD7))
                             (eq? (board-p8 BOARD7) 'O))
                        (and (eq? (board-p0 BOARD7) (board-p4 BOARD7))
                             (eq? (board-p4 BOARD7) (board-p8 BOARD7))
                             (eq? (board-p8 BOARD7) 'O))
                        (and (eq? (board-p2 BOARD7) (board-p4 BOARD7))
                             (eq? (board-p4 BOARD7) (board-p6 BOARD7))
                             (eq? (board-p6 BOARD7) 'O))))

(define X-WIN-TRUE (or (and (eq? (board-p0 BOARD1) (board-p1 BOARD1))
                            (eq? (board-p1 BOARD1) (board-p2 BOARD1))
                            (eq? (board-p2 BOARD1) 'X))
                       (and (eq? (board-p3 BOARD1) (board-p4 BOARD1))
                            (eq? (board-p4 BOARD1) (board-p5 BOARD1))
                            (eq? (board-p5 BOARD1) 'X))
                       (and (eq? (board-p6 BOARD1) (board-p1 BOARD1))
                            (eq? (board-p1 BOARD1) (board-p8 BOARD1) )
                            (eq? (board-p8 BOARD1) 'X))
                       (and (eq? (board-p0 BOARD1) (board-p3 BOARD1))
                            (eq? (board-p3 BOARD1) (board-p6 BOARD1))
                            (eq? (board-p6 BOARD1) 'X))
                       (and (eq? (board-p1 BOARD1) (board-p4 BOARD1))
                            (eq? (board-p4 BOARD1) (board-p1 BOARD1))
                            (eq? (board-p1 BOARD1) 'X))
                       (and (eq? (board-p2 BOARD1) (board-p5 BOARD1))
                            (eq? (board-p5 BOARD1) (board-p8 BOARD1))
                            (eq? (board-p8 BOARD1) 'X))
                       (and (eq? (board-p0 BOARD1) (board-p4 BOARD1))
                            (eq? (board-p4 BOARD1) (board-p8 BOARD1))
                            (eq? (board-p8 BOARD1) 'X))
                       (and (eq? (board-p2 BOARD1) (board-p4 BOARD1))
                            (eq? (board-p4 BOARD1) (board-p6 BOARD1))
                            (eq? (board-p6 BOARD1) 'X))))

;; Tests using sample computations for has-win?
(check-expect (has-win? BOARD7 'O) O-WIN-FALSE)
(check-expect (has-win? BOARD1 'X) X-WIN-TRUE)

;; Tests using sample values for has-win?
(check-expect (has-win? (make-board 'O 'O 'B
                                    'X 'X 'B
                                    'X 'B 'B)
                        'X)
              #false)
(check-expect (has-win? (make-board 'O 'X 'O
                                    'X 'O 'B
                                    'O 'X 'X)
                        'O)
              #true)

;; turn --> turn
;; Purpose: Return the other turn
(define (flip a-turn)
  (if (eq? a-turn 'X) 'O 'X))

;; Sample expressions for flip
(define FLIPO (if (eq? 'O 'X) 'O 'X))
(define FLIPX (if (eq? 'X 'X) 'O 'X))

;; Tests using sample computations for flip
(check-expect (flip 'O) FLIPO)
(check-expect (flip 'X) FLIPX)

;; Tests using sample computations for flip
(check-expect (flip 'O) 'X)
(check-expect (flip 'X) 'O)


;; Sample instances of ST
(define WIN-ST1 '())
(define WIN-ST2 (create-st INIT-BOARD 'X))
(define WIN-ST3 (create-st BOARD7     'O))

;; Sample instances of node
(define WIN-NODE2 WIN-ST2)
(define WIN-NODE3 WIN-ST3)

;; Sample instances of (listof st)
(define WIN-LOST1 '())
(define WIN-LOST2 (node-children WIN-NODE2))
(define WIN-LOST3 (node-children WIN-NODE3))

;; (listof st) turn --> Boolean
;; Purpose: Determine if the given turn can win through any st
(define (lost-can-win? an-lost a-turn)
  (and (not (empty? an-lost))
       (or (st-can-win? (first an-lost) a-turn)
           (lost-can-win? (rest an-lost) a-turn))))

;; node turn --> Boolean
;; Purpose: To determine if the given turn can reach a win
(define (node-can-win? a-node a-turn)
  (or (and (not (has-win? (node-board a-node) (flip a-turn)))
           (has-win? (node-board a-node) a-turn))
      (lost-can-win?  (node-children a-node) a-turn)))

;; st turn --> Boolean
;; Purpose: Determine if there is a sequence of moves for the given turn to win
(define (st-can-win? an-st a-turn)
  (if (empty? an-st)
      #false
      (node-can-win? an-st a-turn)))

;; Sample expressions for st-can-win?
(define WIN-ST1-VAL #false)
(define WIN-ST2-VAL (node-can-win? INIT-ST 'X))
(define WIN-ST3-VAL (node-can-win? BRD7-ST 'O))

;; Tests using sample computations st-can-win?
(check-expect (st-can-win? WIN-ST1 'X) WIN-ST1-VAL)
(check-expect (st-can-win? WIN-ST2 'X) WIN-ST2-VAL)
(check-expect (st-can-win? WIN-ST3 'O) WIN-ST3-VAL)

;; Tests using sample values can-win-st?
(check-expect (st-can-win? (create-st (make-board 'O 'X 'B
                                                  'X 'O 'X
                                                  'O 'X 'O)
                                      'X)
                           'X)
              #false)

(check-expect (st-can-win? (create-st (make-board 'B 'B 'B
                                                  'X 'O 'X
                                                  'B 'B 'B)
                                      'O)
                           'O)
              #true)


;; Sample expressions for node-can-win?
(define WIN-NODE2-VAL (or (and (not (has-win? (node-board WIN-NODE2) (flip 'X)))
                               (has-win? (node-board WIN-NODE2) 'X))
                          (lost-can-win?  (node-children WIN-NODE2) 'X)))

(define WIN-NODE3-VAL (or (and (not (has-win? (node-board WIN-NODE3) (flip 'O)))
                               (has-win? (node-board WIN-NODE3) 'O))
                          (lost-can-win?  (node-children WIN-NODE3) 'O)))

;; Tests using sample computations node-can-win?
(check-expect (node-can-win? WIN-NODE2 'X) WIN-NODE2-VAL)
(check-expect (node-can-win? WIN-NODE3 'O) WIN-NODE3-VAL)

;; Tests using sample values node-can-win?
(check-expect (node-can-win?
               (create-st (make-board 'B 'B 'B 'B 'X 'B 'B 'B 'B)
                          'O)
               'O)
              #true)

(check-expect (node-can-win?
               (create-st (make-board 'O 'O 'O 'X 'X 'B 'X 'B 'B)
                          'X)
               'X)
              #false)



;; Sample expressions for lost-can-win?
(define WIN-LOST1-VAL (and (not (empty? WIN-LOST1))
                           (or (st-can-win? (first WIN-LOST1) 'X)
                               (lost-can-win? (rest WIN-LOST1) 'X))))
(define WIN-LOST2-VAL (and (not (empty? WIN-LOST2))
                           (or (st-can-win? (first WIN-LOST2) 'X)
                               (lost-can-win? (rest WIN-LOST2) 'X))))
(define WIN-LOST3-VAL (and (not (empty? WIN-LOST3))
                           (or (st-can-win? (first WIN-LOST3) 'O)
                               (lost-can-win? (rest WIN-LOST3) 'O))))

;; Tests using sample computations lost-can-win?
(check-expect (lost-can-win? WIN-LOST1 'X) WIN-LOST1-VAL)
(check-expect (lost-can-win? WIN-LOST2 'O) WIN-LOST2-VAL)
(check-expect (lost-can-win? WIN-LOST3 'O) WIN-LOST3-VAL)

;; Tests using sample values lost-can-win?
(check-expect (lost-can-win?
               (node-children (create-st (make-board 'X 'B 'O
                                                     'O 'X 'O
                                                     'B 'X 'X)
                                         'O))
               'O)
              #false)

(check-expect (lost-can-win?
               (node-children (create-st (make-board 'B 'B 'O
                                                     'O 'X 'O
                                                     'B 'X 'X)
                                         'X))
               'X)
              #true)