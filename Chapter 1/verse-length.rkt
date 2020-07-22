;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname verse-length) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; A verse is either:
;;  1. A string of length greater than 35
;;  2. A string of length 15 to 35
;;  3. A string of length less than 15

#|
Funtion template for verses

;; verse ... --> ...
;; Purpose: ...
(define (f-on-verse a-verse ...)
  (cond [(> (string-length a-verse) 35) ...]
        [(<= 15 (string-length a-verse) 35)  ...]
        [else ...])

;; Expressions for sample computations
(define VARIETY1-CONSTANT ...)
(define VARIETY2-CONSTANT ...)
(define VARIETY3-CONSTANT ...)

;; Tests using sample computations
(check-expect (f-on-verse ...) VARIETY1-CONSTANT)
(check-expect (f-on-verse ...) VARIETY2-CONSTANT)
(check-expect (f-on-verse ...) VARIETY3-CONSTANT)

;; Test using sample values
(check-expect (f-on-verse ...) ...)
(check-expect (f-on-verse ...) ...)
(check-expect (f-on-verse ...) ...)
|#

;; Tests using sample values
(check-expect (verse-type "Here is a sigh to those who love me,") "Too Long")
(check-expect (verse-type "And a smile to those who hate") "Fine")
(check-expect (verse-type "Sorry for fate") "Too Short")
(check-expect (verse-type "The Battle of Culloden started now,") "Fine")
(check-expect (verse-type    "Flaming heavens")  "Fine")

;; verse --> string
;; Purpose: Determine if the given verse is too long, fine, or too short
(define (verse-type a-verse)
  (cond [(> (string-length a-verse) 35) "Too Long"] 
        [(<= 15 (string-length a-verse) 35)  "Fine"]
        [else "Too Short"]))
