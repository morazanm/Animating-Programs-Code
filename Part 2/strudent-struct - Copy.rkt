;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname strudent-struct) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

#|
A GPA is a real number in [0..4].

A middle name (mn) is either:
  1. ""
  2. not ""

A student is a structure, (make-student string mn string GPA),
that contains a first name, a middle name, a last name, and a
grade point average.
|#

(define-struct student (fn mn ln gpa))

#| FUNCTION TEMPLATE
     ;; GPA ... --> ...
     ;; Purpose: ...
     (define (f-on-GPA a-gpa ...) ...)

     ;; Sample instances for GPA
     (define GPA1 ...)
          ...

     ;; Sample expressions for f-on-GPA
     (define GPA1-VAL ...)
          ...

     ;; Tests using sample computations for f-on-GPA
     (check-expect (f-on-GPA GPA1 ...) GPA1-VAL)
          ...

     ;; Tests using sample values for f-on-GPA
     (check-expect (f-on-student ...) ...)


;; Sample instances for mn
(define MN1 "")
(define MN2 ...)
     ...

;; mn ... --> ...
;; Purpose: ...
(define (f-on-nm an-nm ...)
  (if (string=? an-nm "")
      ...
      ...))
      

;; Sample expressions for f-on-mn
(define MN1-VAL ...)
(define MN2-VAL ...)
     ...

;; Tests using sample computations for f-on-mn
(check-expect (f-on-mn MN1 ...) MN1-VAL)
(check-expect (f-on-mn MN2 ...) MN2-VAL)
     ...

;; Tests using sample values for f-on-mn
(check-expect (f-on-mn ...) ...)


;; student ... --> ...
;; Purpose: ...
(define (f-on-student a-student ...)
  ...(f-on-string (student-fn  a-student))...
  ...(f-on-mn (student-mn  a-student))...
  ...(f-on-string (student-ln  a-student))...
  ...(f-on-GPA (student-gpa a-student))...)

;; Sample instances for student
(define STUD1 ...)
     ...

;; Sample expressions for f-on-student
(define STUD1-VAL ...)
     ...

;; Tests using sample computations for f-on-student
(check-expect (f-on-student STUD1 ...) STUD1-VAL)
     ...

;; Tests using sample values for f-on-student
(check-expect (f-on-student (make-student ... ... ... ...)) ...)
|#
(define OLDGPA1 3.8)
(define OLDGPA2 3.7)
(define OLDGPA3 3.58)
(define NEWGPA1 3.93)
(define NEWGPA2 3.9)
(define NEWGPA3 3.8)

(define STUD1 (make-student "Barbara" "" "Mucha" OLDGPA1))
(define STUD2 (make-student "Joan" "Elizabeth" "Feeney" OLDGPA2))
(define STUD3 (make-student "Christopher" "Michael" "Dutra" OLDGPA3))

;; student real --> student
;; Purpose: Update the given student's gpa
(define (update-student-gpa a-student a-gpa)
  (make-student (student-fn a-student)
                (student-mn a-student)
                (student-ln a-student)
                a-gpa))


;; Sample expressions for update-student-gpa
(define STUD1-VAL (make-student (student-fn STUD1)
                                (student-mn STUD1)
                                (student-ln STUD1)
                                NEWGPA1))

(define STUD2-VAL (make-student (student-fn STUD2)
                                (student-mn STUD2)
                                (student-ln STUD2)
                                NEWGPA2))

(define STUD3-VAL (make-student (student-fn STUD3)
                                (student-mn STUD3)
                                (student-ln STUD3)
                                NEWGPA3))

;; Tests using sample computations for update-student-gpa
(check-expect (update-student-gpa STUD1 NEWGPA1) STUD1-VAL)
(check-expect (update-student-gpa STUD2 NEWGPA2) STUD2-VAL)
(check-expect (update-student-gpa STUD3 NEWGPA3) STUD3-VAL)

;; Tests using sample values for update-student-gpa
(check-expect (update-student-gpa (make-student "Sandy" "" "Marinakys" 3.1) 3.4)
              (make-student "Sandy" "" "Marinakys" 3.4))
(check-expect (update-student-gpa (make-student "Lidia" "Carolina" "Vazquez" 3.5) 3.5)
              (make-student "Lidia" "Carolina" "Vazquez" 3.5))
(check-expect (update-student-gpa (make-student "Luis" "Manuel" "Diaz" 3.7) 3.6)
              (make-student "Luis" "Manuel" "Diaz" 3.6))



;; GPA --> string
;; Purpose: Transform the given GPA to a string
(define (gpa->string a-gpa)
  (number->string (exact->inexact a-gpa)))

;; Sample expressions for gpa->string
(define GPA1-VAL "3.8")
(define GPA2-VAL "3.7")

;; Tests using sample computations for gpa->string
(check-expect (gpa->string OLDGPA1) GPA1-VAL)
(check-expect (gpa->string OLDGPA2) GPA2-VAL)

;; Tests using sample values for gpa->string
(check-expect (gpa->string 4.0) "4.0")
(check-expect (gpa->string 2.3) "2.3")

     


(define MN1 "")
(define MN2 "Jose")
(define MN3 "Francisco")

;; nm --> string
;; Purpose: To abbreviated the given middle name
(define (middle-name-abbrev a-mn)
  (if (string=? a-mn "")
      " "
      (string-append " " (substring a-mn 0 1) ". ")))

;; Sample expressions for middle-name-abbrev
(define MN1-VAL " ")
(define MN2-VAL (string-append " " (substring MN2 0 1) ". "))
(define MN3-VAL (string-append " " (substring MN3 0 1) ". "))

;; Tests using sample computations for middle-name-abbrev
(check-expect (middle-name-abbrev MN1) MN1-VAL)
(check-expect (middle-name-abbrev MN2) MN2-VAL)
(check-expect (middle-name-abbrev MN3) MN3-VAL)

;; Tests using sample values for middle-name-abbrev
(check-expect (middle-name-abbrev "Kaliman") " K. ")

;; student --> string
;; Purpose: Transform the given student to a string
(define (student2string a-student)
  (string-append (student-fn  a-student)
                 (middle-name-abbrev (student-mn  a-student))
                 (student-ln  a-student)
                 " has a "
                 (gpa->string (student-gpa a-student))
                 " grade point average."))

;; Sample expressions for student2string
(define STUD1-STR (string-append (student-fn  STUD1)
                                 (middle-name-abbrev (student-mn  STUD1))
                                 (student-ln  STUD1)
                                 " has a "
                                 (gpa->string (student-gpa STUD1))
                                 " grade point average."))

(define STUD2-STR (string-append (student-fn  STUD2)
                                 (middle-name-abbrev (student-mn  STUD2))
                                 (student-ln  STUD2)
                                 " has a "
                                 (gpa->string (student-gpa STUD2))
                                 " grade point average."))


;; Tests using sample computations for student2string
(check-expect (student2string STUD1) STUD1-STR)
(check-expect (student2string STUD2) STUD2-STR)

;; Tests using sample values for student2string
(check-expect (student2string (make-student "Mercedes" "G." "Merayo" 3.97))
              "Mercedes G. Merayo has a 3.97 grade point average.")
(check-expect (student2string (make-student "Manuel" "" "Núñez" 3.89))
              "Manuel Núñez has a 3.89 grade point average.")