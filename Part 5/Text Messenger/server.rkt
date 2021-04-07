;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname server) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; A universe is a (listof iworld)

;; Universe function template
;; universe ... --> ...
;; Purpose:
;; (define (f-on-universe a-universe)
;;   (if (empty? a-universe)
;;       ...
;;       (... (first a-universe) ...
;;        ... (f-on-universe (rest a-universe)) ...)))
;; Sample universes
;; (define UNIV-0 '())
;; (define UNIV-1 ...)
;;
;; Sample expressions for f-on-universe
;; (define UNIV-0-VAL ...UNIV-0 ...)
;; (define UNIV-1-VAL ...UNIV-1 ...)
;;
;; Tests using sample computations for f-on-universe
;; (check-expect (f-on-universe UNIV-0 ...) UNIV-0-VAL)
;; (check-expect (f-on-universe UNIV-1 ...) UNIV-1-VAL)...
;;
;;  Tests using sample values for f-on-universe
;;  (check-expect (f-on-universe ... ...) ...) ...


(define INIT-UNIV '())
(define A-UNIV (list iworld1 iworld2))

;; A to-server message is a tm

;; A to-client message is a tm

;; universe iworld --> bundle
;; Purpose: Add the given world to the universe
;; ASSUMPTION: The name of the new iworld is a string
(define (add-new-world a-universe an-iworld)
  (if (member? (iworld-name an-iworld)
               (map iworld-name a-universe))
      a-universe
      (local
        [(define new-univ (cons an-iworld a-universe))
         (define new-mails (map (λ (iw)
                                  (make-mail iw
                                             (string-append (iworld-name an-iworld) " has joined")))
                                a-universe))]
        (make-bundle new-univ new-mails '()))))

;; Sample expressions for add-new-world
(define ADD-INITU (make-bundle (list iworld1)
                               (map
                                (λ (iw) (make-mail iw (string-append (iworld-name iworld3) " has joined")))
                                INIT-UNIV)
                               '()))
(define ADD-AUNIV (make-bundle (list iworld3 iworld1 iworld2)
                               (map
                                (λ (iw) (make-mail iw (string-append (iworld-name iworld3) " has joined")))
                                A-UNIV)
                               '()))

(define ADD-REPEAT A-UNIV)

;; Tests using sample computations for add-new-world
(check-expect (add-new-world INIT-UNIV iworld1) ADD-INITU)
(check-expect (add-new-world A-UNIV iworld3)    ADD-AUNIV)
(check-expect (add-new-world A-UNIV iworld1)    ADD-REPEAT)

;; Tests using sample values for add-new-world
(check-expect (add-new-world (list iworld1) iworld2)
              (make-bundle (list iworld2 iworld1)
                           (list (make-mail iworld1 "iworld2 has joined"))
                           '()))

;; universe iworld message --> bundle
;; Purpose: To process the given message from the given world
(define (process-message a-univ an-iw a-mess)
  (local [(define new-mails (map (λ (iw) (make-mail iw a-mess))
                                 (filter (λ (iw) (not (equal? (iworld-name an-iw)
                                                              (iworld-name iw))))
                                         a-univ)))]
    (make-bundle a-univ new-mails '())))

;; Sample Expressions for process-message
(define AUNIV-MESS
  (local [(define new-mails
            (map (λ (iw) (make-mail iw "Hi!"))
                 (filter (λ (iw) (not (equal? (iworld-name iworld2)
                                              (iworld-name iw))))
                         A-UNIV)))]
    (make-bundle A-UNIV new-mails '())))

(define IUNIV-MESS
  (local [(define new-mails
            (map (λ (iw) (make-mail iw "Hi!"))
                 (filter (λ (iw) (not (equal? (iworld-name iworld2)
                                              (iworld-name iw))))
                         INIT-UNIV)))]
    (make-bundle INIT-UNIV new-mails '())))

;; Tests using sample computations for process-message
(check-expect (process-message A-UNIV iworld2 "Hi!") AUNIV-MESS)
(check-expect (process-message INIT-UNIV iworld2 "Hi!") IUNIV-MESS)

;; Tests using sample values for process-message
(check-expect (process-message (list iworld2 iworld3) iworld3 "OK")
              (make-bundle (list iworld2 iworld3)
                           (list (make-mail iworld2 "OK"))
                           '()))
              

;; Z --> universe
;; Purpose: Run the chat server
(define (run-server a-z)
  (universe INIT-UNIV
            (on-new add-new-world)
            (on-msg process-message)))