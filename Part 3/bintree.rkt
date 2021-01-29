;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname bintree) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

     ;; A node is a structure, (make-node X (btof X) (btof X)), with an X value and two 
     ;; subtrees of X values.
     (define-struct node (val ltree rtree))

  #| ;; Sample instances of node
     (define NODE0 (make-node ... ... ...))
          ...

     ;; node -->
     ;; Purpose:
     (define (f-on-node a-node)
       ...(f-on-X (node-val a-node))
       ...(f-on-btx (node-ltree a-node))
       ...(f-on-btx (node-rtree a-node)))

     ;; Sample expressions for f-on-node
     (define NODE0-VAL ...)
          ...

     ;; Tests using sample computations for f-on-node
     (check-expect (f-on-node NODE0 ...) NODE0-VAL)
          ...

     ;; Tests using sample values for f-on-node
     (check-expect (f-on-node (make-node ... ... ...) ...) ...)
          ...
   |#  

     
  #| ;; A binary tree of X, (btof X), is either:
     ;;   1. '()
     ;;   2. node

     ;; Sample instances of (btof X)
     (define BTX0 '())
     (define BTX1 (make-node ...))
          ...

     ;; btx ... -->
     ;; Purpose:
     (define (f-on-btx a-btx ...)
       (if (empty? a-btx)
           ...
           (f-on-node a-btx ...)))

     ;; Sample expressions for f-on-btx
     (define BTX0-VAL (f-on-btx  BTX0 ...))
     (define BTX1-VAL (f-on-node BTX1 ...))
          ...

     ;; Tests using sample computations for f-on-btx
     (check-expect (f-on-btx BTX0 ...) BTX0-VAL)
     (check-expect (f-on-btx BTX1 ...) BTX1-VAL)
          ...

     ;; Tests using sample values for f-on-btx
     (check-expect (f-on-btx ...) ...)
          ...
   |#

     ;; Sample instances of (btof int) and of node
     (define BTI0 '())

     (define NODE177 (make-node 177 BTI0 BTI0))
     (define NODE231 (make-node 231 BTI0 BTI0))
     (define NODE970 (make-node 970 BTI0 BTI0))
     (define NODE487 (make-node 487 BTI0 BTI0))
     (define NODE200 (make-node 200 BTI0 (make-node 311 BTI0 BTI0)))
     (define NODE650 (make-node 650 (make-node 912 BTI0 BTI0) BTI0))

     (define BTI177 NODE177)
     (define BTI231 NODE231)
     (define BTI970 NODE970)
     (define BTI487 NODE487)

     
     (define NODE456 (make-node 456 BTI177 BTI231))
     (define NODE564 (make-node 564 BTI970 BTI487))

     (define BTI456 NODE456)
     (define BTI564 NODE564)

     (define NODE100 (make-node 100 BTI456 BTI564))

     (define BTI100 NODE100)
          

     ;; node --> int
     ;; Purpose: Return the max int in the given node
     (define (max-node a-node)
       (cond [(and (empty? (node-ltree a-node))
                   (empty? (node-rtree a-node)))
              (node-val a-node)]
             [(empty? (node-ltree a-node))
              (max (node-val a-node) (max-btint (node-rtree a-node)))]
             [(empty? (node-rtree a-node))
              (max (node-val a-node) (max-btint (node-ltree a-node)))]
             [else (max (node-val a-node)
                        (max-btint (node-ltree a-node))
                        (max-btint (node-rtree a-node)))]))

     ;; Sample expressions for max-node
     (define NODE487-VAL (node-val NODE487))
     (define NODE200-VAL (max (node-val NODE200) (max-node (node-rtree NODE200))))
     (define NODE650-VAL (max (node-val NODE650) (max-node (node-ltree NODE650))))
     (define NODE456-VAL (max (node-val NODE456)
                              (max-node (node-ltree NODE456))
                              (max-node (node-rtree NODE456))))

     ;; Tests using sample computations for max-node
     (check-expect (max-node NODE487) NODE487-VAL)
     (check-expect (max-node NODE200) NODE200-VAL)
     (check-expect (max-node NODE650) NODE650-VAL)
     (check-expect (max-node NODE456) NODE456-VAL)

     ;; Tests using sample values for max-node
     (check-expect (max-node (make-node 789
                                        (make-node -1000 BTI0 BTI0)
                                        (make-node 3000 BTI0 BTI0)))
                   3000)
    

     ;; (btof int) --> int throws error
     ;; Purpose: Return the maximum of the given (btof int)
     (define (max-btint a-btint)
       (if (empty? a-btint)
           (error "An empty (btof int) has no maximum value.")
           (max-node a-btint)))

     ;; Sample expressions for max-btint
     (define BTI100-VAL (max-node BTI100))
     (define BTI456-VAL (max-node BTI456))

     ;; Tests using sample computations for max-btint
     (check-expect (max-btint BTI100) BTI100-VAL)
     (check-expect (max-btint BTI456) BTI456-VAL)

     ;; Tests using sample values for f-on-btx
     (check-error (max-btint BTI0) "An empty (btof int) has no maximum value.")
     (check-expect (max-btint (make-node -97
                                         (make-node -89 BTI0 BTI0)
                                         (make-node -99 BTI0 BTI0)))
                              -89)
     
