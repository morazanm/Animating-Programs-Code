;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname aliens-attack-server) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

(define MAX-CHARS-HORIZONTAL 20)
(define AN-IMG-X (/ MAX-CHARS-HORIZONTAL 2))
(define INIT-ROCKET  AN-IMG-X)
(define INIT-DIR  'right)
(define NO-SHOT 'no-shot)
(define INIT-SHOT NO-SHOT)
(define NUM-ALIENS 18)
(define NUM-ALIEN-LINES 3)
(define ALIENS-PER-LINE (/ NUM-ALIENS NUM-ALIEN-LINES))
(define STARTING-X-LINE (add1 (/ (- MAX-CHARS-HORIZONTAL ALIENS-PER-LINE) 2)))
(define INIT-LOA (build-list NUM-ALIENS
                             (λ (n) (make-posn (+ STARTING-X-LINE
                                                  (remainder n ALIENS-PER-LINE))
                                               (quotient n ALIENS-PER-LINE)))))

(define MAX-CHARS-VERTICAL 15)
(define MAX-IMG-Y (sub1 MAX-CHARS-VERTICAL))
(define INIT-ALIEN2 (make-posn 3 MAX-IMG-Y))

;; A world is either
;;  1. 'uninitialized
;;  2. a structure: (make-world lor loa dir los)
(define-struct world (allies aliens dir shots))
(define INIT-WORLD (make-world '() INIT-LOA 'right '()))


;; A universe is a (listof iworld), where each iworld has a unique name

;; Sample instances of universe
(define INIT-UNIV '())
(define A-UNIV    (list iworld1 iworld2))


;; MESSAGE DATA DEFINITIONS
;; A marshaled moved ally  (am) is (list image-x string)
;; A marshaled list of allies (mlor) is a (listof am)
;; A marshaled alien (ma) is (list image-x image-y)
;; A marshaled list of aliens (mloa) is a (listof ma)
;; A marshaled shot  (ms) is either:
;;  1. 'NO-SHOT
;;  2. (list image-x image-y)
;; A marshaled list of shots (mlos) is a (listof ms)
;; A marshaled world (mw) is
;;   (list   (listof mr)
;;           (listof ma)
;;           direction
;;           (listof ms)
(define MR1  '(10 "iworld1"))
(define MR2  '(8  "iworld3"))
(define MA   '(14  3))
(define MLOA '((14 3)))
(define MS1  'NO-SHOT)
(define MS2  '(2   2))
(define MLOS '((2 2)))
(define MW   '(((7 "iworld1") (3 "iworld2"))
               ((15 2))
               left
               ((8 5) (7 2))))

(define ST-MSG (cons 'start MLOA))
(define RM-MSG (list 'rckt-move MR2))
(define NS-MSG (list 'new-shot  MS1))
(define NA-MSG (list 'new-ally  MR2))
(define RA-MSG (list 'rm-ally   "world1"))
(define SW-MSG (list 'send-world "world2"))

;; A to-server message (tsm) is either
;;  1. (list 'rckt-move ma)
;;  2. (list 'new-shot  ms)
;;  3. (cons 'world-back (cons string mw))
;;
  #| TEMPLATE FOR FUNCTIONS ON A tsm
     ;; Sample instances of tsm
     (define TSM1 ...)
     (define TSM2 ...)
     (define TSM3 ...) ...
     ;; Sample expressions for f-on-tsm
     (define TSM1-VAL ...)
     (define TSM2-VAL ...)
     (define TSM3-VAL ...) ...
     ;; tsm ... --> ...
     ;; Purpose:
     (define (f-on-tsm a-tsm ...)
       (local [(define tag (first a-tsm))]
         (cond [(eq? tag 'rckt-move)  ...]
               [(eq? tag 'new-shot)    ...]
               [(eq? tag 'world-back) ...]
                [else (error (format "Unknown to-server message type: ~s"
                             tag))])))
     ;; Sample expressions for f-on-tsm
     (define TSM1-VAL ...)
     (define TSM2-VAL ...)
     (define TSM3-VAL ...) ...
     ;; Tests using sample computations for f-on-tsm
     (check-expect (f-on-tsm TSM1 ...) TSM1-VAL)
     (check-expect (f-on-tsm TSM2 ...) TSM2-VAL)
     (check-expect (f-on-tsm TSM3 ...) TSM3-VAL) ...
     ;; Tests using sample values for f-on-tsm
     (check-expect (f-on-tsm ... ...) ...) ...
  |#

;; Sample instances of tsm
(define SRM-MSG RM-MSG)
(define SNS-MSG NS-MSG)
(define SWB-MSG (cons 'world-back (cons "iworld2" MW)))

;; ally --> ally
;; Purpose: Marshal the given ally
(define (marshal-ally an-ally)
  (list (ally-rocket an-ally) (ally-name an-ally)))

;; shot --> mshot
;; Purpose: Marshal the given shot
(define (marshal-shot a-shot)
  (if (eq? a-shot NO-SHOT)
      NO-SHOT
      (list (posn-x a-shot) (posn-y a-shot))))

;; alien --> malien
;; Purpose: Marshal the given alien
(define (marshal-alien an-alien)
  (list (posn-x an-alien) (posn-y an-alien)))

;; Sample expressions for marshal-alien
(define MINIT-ALIEN2 (list (posn-x INIT-ALIEN2) (posn-y INIT-ALIEN2)))

;; Tests using sample computations for marshal-alien 
(check-expect (marshal-alien INIT-ALIEN2) MINIT-ALIEN2)

;; Tests using sample values for unmarshal-alien 
(check-expect (marshal-alien (make-posn 5 5)) (list 5 5))



;; An ally is a structure: (make-ally rocket string)
;; with this player's rocket and name
(define-struct ally (rocket name))
;; Sample instances of ally
;(define INIT-ALLY  (make-ally INIT-ROCKET  MY-NAME))
;(define INIT-ALLY2 (make-ally INIT-ROCKET2 MY-NAME))

;; world --> mworld
;; Purpose: Marshal the given world
(define (marshal-world a-world)
  (list (map marshal-ally  (world-allies a-world))
        (map marshal-alien (world-aliens a-world))
        (world-dir a-world)
        (map marshal-shot (world-shots a-world))))

;; Sample expressions for marshal-world
(define MWORLD3 (list (map marshal-ally  (world-allies INIT-WORLD))
                      (map marshal-alien (world-aliens INIT-WORLD))
                      (world-dir INIT-WORLD)
                      (map marshal-shot (world-shots INIT-WORLD))))

;; Tests using sample computations for marshal-world
(check-expect (marshal-world INIT-WORLD)  MWORLD3)

;; Tests using sample values for marshal-world
(check-expect (marshal-world (make-world (list (make-ally 5 "Luis")
                                               (make-ally 8 "Cova"))
                                         (list (make-posn  2 17))
                                         "left"
                                         '()))
              (list (list (list 5 "Luis")
                          (list 8 "Cova"))
                    (list (list  2 17))
                    "left"
                    '()))


;; universe iworld tsm --> bundle
;; Purpose: To process the given message from the given world
(define (process-message a-univ an-iw a-tsm)
  (local
    [(define tag (first a-tsm))
     (define send-list (if (eq? tag 'world-back)
                           (filter (λ (iw) (string=? (iworld-name iw)
                                                     (second a-tsm)))
                                   a-univ)
                           (filter
                            (λ (iw) (not (string=? (iworld-name iw)
                                                   (iworld-name an-iw))))
                            a-univ)))]
    (cond [(eq? tag 'rckt-move)
           (make-bundle a-univ
                        (map (λ (iw) (make-mail iw a-tsm)) send-list)
                        '())]
          [(eq? tag 'new-shot)
           (make-bundle a-univ
                        (map (λ (iw) (make-mail iw a-tsm)) send-list)
                        '())]
          [(eq? tag 'world-back)
           (make-bundle a-univ
                        (list (make-mail (first send-list)
                                         (cons 'start (rest (rest a-tsm)))))
                        '())]
          [else
           (error (format "Unknown message received by server: ~s." a-tsm))])))

;; Sample Expressions for process-message
(define PM-RM (local
                [(define tag (first SRM-MSG))
                 (define send-list (if (eq? tag 'world-back)
                                       (filter (λ (iw) (string=? (iworld-name iw)
                                                                 (second SRM-MSG)))
                                               A-UNIV)
                                       (filter
                                        (λ (iw) (not (string=? (iworld-name iw)
                                                               (iworld-name iworld1))))
                                        A-UNIV)))]
                (make-bundle A-UNIV
                             (map
                              (λ (iw)
                                (make-mail iw SRM-MSG))
                              send-list)
                             '())))

(define PM-NS (local
                [(define tag (first SNS-MSG))
                 (define send-list (if (eq? tag 'world-back)
                                       (filter (λ (iw) (string=? (iworld-name iw)
                                                                 (second SNS-MSG)))
                                               A-UNIV)
                                       (filter
                                        (λ (iw) (not (string=? (iworld-name iw)
                                                               (iworld-name iworld1))))
                                        A-UNIV)))]
                (make-bundle A-UNIV
                             (map
                              (λ (iw)
                                (make-mail iw SNS-MSG))
                              send-list)
                             '())))

(define PM-WB (local
                [(define tag (first SWB-MSG))
                 (define send-list (if (eq? tag 'world-back)
                                       (filter (λ (iw) (string=? (iworld-name iw)
                                                                 (second SWB-MSG)))
                                               A-UNIV)
                                       (filter
                                        (λ (iw) (not (string=? (iworld-name iw)
                                                               (iworld-name iworld1))))
                                        A-UNIV)))]
                (make-bundle A-UNIV
                             (map
                              (λ (iw)
                                (make-mail (first send-list)
                                           (cons 'start (rest (rest SWB-MSG)))))
                              send-list)
                             '())))


;; Tests using sample computations for process-message
(check-expect (process-message A-UNIV iworld1 SRM-MSG) PM-RM)
(check-expect (process-message A-UNIV iworld1 SNS-MSG) PM-NS)
(check-expect (process-message A-UNIV iworld2 SWB-MSG) PM-WB)

;; Tests using sample values for process-message
(check-error (process-message A-UNIV iworld2 '(rocket-move ((5 "iworld2"))))
             (format "Unknown message received by server: ~s."
                     '(rocket-move ((5 "iworld2")))))
  

;; universe iworld --> universe or bundle
;; Purpose: Add new world to the universe
(define (add-player a-univ an-iw)
  (cond
    [(member? (iworld-name an-iw) (map iworld-name a-univ))
     (make-bundle a-univ '() (list an-iw))]
    [(empty? a-univ)
     (make-bundle
      (cons an-iw a-univ)
      (list (make-mail an-iw (cons 'start (marshal-world INIT-WORLD))))
      '())]
    [else
     (make-bundle
      (cons an-iw a-univ)
      (cons (make-mail (first a-univ) (list 'send-world (iworld-name an-iw)))
            (map
             (λ (iw)
               (make-mail iw
                          (list 'new-ally (list INIT-ROCKET (iworld-name an-iw)))))
             a-univ))
      '())]))

;; Sample expressions for add-player
(define RPT-ADD (make-bundle A-UNIV '() (list iworld1)))
(define EMP-ADD (make-bundle
                 (cons iworld1 INIT-UNIV)
                 (list (make-mail iworld1
                                  (cons 'start (marshal-world INIT-WORLD))))
                 '()))
(define NEW-ADD (make-bundle
                 (cons iworld3 A-UNIV)
                 (cons (make-mail
                        (first A-UNIV)
                        (list 'send-world (iworld-name iworld3)))
                       (map
                        (λ (iw)
                          (make-mail
                           iw
                           (list 'new-ally
                                 (list INIT-ROCKET (iworld-name iworld3)))))
                        A-UNIV))
                 '()))

;; Tests using sample computations for add-player
(check-expect (add-player A-UNIV    iworld1) RPT-ADD)
(check-expect (add-player INIT-UNIV iworld1) EMP-ADD)
(check-expect (add-player A-UNIV    iworld3) NEW-ADD)

;; Tests using sample values for add-player
(check-expect (add-player (list iworld2 iworld3) iworld1)
              (make-bundle   (list iworld1 iworld2 iworld3)
                             (cons (make-mail
                                    (first (list iworld2 iworld3))
                                    (list 'send-world "iworld1"))
                                   (map
                                    (λ (iw)
                                      (make-mail
                                       iw
                                       (list 'new-ally
                                             (list INIT-ROCKET "iworld1"))))
                                    (list iworld2 iworld3)))
                             '()))


;; universe iworld --> universe or bundle
;; Purpose: Add new world to the universe
(define (rm-player a-univ an-iw)
  (local
    [(define new-univ (filter (λ (iw)
                                (not (string=? (iworld-name iw)
                                               (iworld-name an-iw))))
                              a-univ))]
    (make-bundle
     new-univ
     (map (λ (iw) 
            (make-mail iw
                       (list 'rm-ally (iworld-name an-iw))))
          new-univ)
     '())))

;; Sample expressions for rm-player
(define IW1-RM (local
                 [(define new-univ (filter (λ (iw)
                                             (not (string=? (iworld-name iw)
                                                            (iworld-name iworld1))))
                                           A-UNIV))]
                 (make-bundle
                  new-univ
                  (map (λ (iw) 
                         (make-mail iw
                                    (list 'rm-ally (iworld-name iworld1))))
                       new-univ)
                  '())))


;; Tests using sample computations for rm-player
(check-expect (rm-player A-UNIV iworld1) IW1-RM)

;; Tests using sample values for rm-player
(check-expect (rm-player (list iworld1 iworld2 iworld3) iworld2)
              (make-bundle   (list iworld1 iworld3)
                             (map
                              (λ (iw)
                                (make-mail
                                 iw
                                 (list 'rm-ally "iworld2")))
                              (list iworld1 iworld3))
                             '()))

;; Z --> universe
;; Purpose: Run the chat server
(define (run-server a-z)
  (universe INIT-UNIV
            (on-new add-player)
            (on-msg process-message)
            (on-disconnect rm-player)))

