;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname symbols) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(define NAME 'Joshua)
(define NAME2 'Sachin)

(define STR-NAME (symbol->string NAME))
(define STR-NAME2 (symbol->string NAME2))

(check-expect STR-NAME "Joshua")
(check-expect STR-NAME2 "Sachin")

(define JOSH (string->symbol STR-NAME))
(define SACH (string->symbol STR-NAME2))

(check-expect JOSH NAME)
(check-expect SACH NAME2)
