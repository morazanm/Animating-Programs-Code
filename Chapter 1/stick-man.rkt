;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname stick-man) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Head
(define OUTER-HEAD (ellipse 50 100 'solid 'blue))
(define INNER-HEAD (ellipse 40 80 'solid 'yellow))
(define HEAD (overlay INNER-HEAD OUTER-HEAD))

;; Arms
(define ARMS (rotate -30 (rectangle 70 12 'solid 'yellow)))

;; Feet
(define LEFT-FOOT (rotate 45 (rectangle 30 10 'solid 'brown)))
(define RIGHT-FOOT (rotate -45 (rectangle 30 10 'solid 'brown)))
(define FEET (beside LEFT-FOOT
                     (rectangle 10 5 'solid 'transparent)
                     RIGHT-FOOT))

;; BODY
(define MAIN-BODY (rectangle 10 150 'solid 'yellow))
(define HEAD&BODY (above HEAD MAIN-BODY FEET))



(overlay/xy ARMS
            (/ (image-width ARMS) 15)
            (* -0.8 (image-height MAIN-BODY))
            HEAD&BODY)

  

