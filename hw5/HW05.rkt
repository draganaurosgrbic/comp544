;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HW05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define smallE '(or (and x y)
                    (or (and x (not y))
                        (or (and (not x) y)
                            (and (not x) (not y))))))

(define smallE2 '(or 
                  (or (and x (not y))
                      (or (and (not x) y)
                          (and (not x) (not y))))
                  (and x y)))

(define midE
  '(or (and   v   (and   w   (and   x   (and   y     z  ))))
       (or (and   v   (and   w   (and   x   (and   y   (not z)))))
           (or (and   v   (and   w   (and   x   (and (not y)   z  ))))
               (or (and   v   (and   w   (and   x   (and (not y) (not z)))))
                   (or (and   v   (and   w   (and (not x) (and   y     z  ))))
                       (or (and   v   (and   w   (and (not x) (and   y   (not z)))))
                           (or (and   v   (and   w   (and (not x) (and (not y)   z  ))))
                               (or (and   v   (and   w   (and (not x) (and (not y) (not z)))))
                                   (or (and   v   (and (not w) (and   x   (and   y     z  ))))
                                       (or (and   v   (and (not w) (and   x   (and   y   (not z)))))
                                           (or (and   v   (and (not w) (and   x   (and (not y)   z  ))))
                                               (or (and   v   (and (not w) (and   x   (and (not y) (not z)))))
                                                   (or (and   v   (and (not w) (and (not x) (and   y     z  ))))
                                                       (or (and   v   (and (not w) (and (not x) (and   y   (not z)))))
                                                           (or (and   v   (and (not w) (and (not x) (and (not y)   z  ))))
                                                               (or (and   v   (and (not w) (and (not x) (and (not y) (not z)))))
                                                                   (or (and (not v) (and   w   (and   x   (and   y     z  ))))
                                                                       (or (and (not v) (and   w   (and   x   (and   y   (not z)))))
                                                                           (or (and (not v) (and   w   (and   x   (and (not y)   z  ))))
                                                                               (or (and (not v) (and   w   (and   x   (and (not y) (not z)))))
                                                                                   (or (and (not v) (and   w   (and (not x) (and   y     z  ))))
                                                                                       (or (and (not v) (and   w   (and (not x) (and   y   (not z)))))
                                                                                           (or (and (not v) (and   w   (and (not x) (and (not y)   z  ))))
                                                                                               (or (and (not v) (and   w   (and (not x) (and (not y) (not z)))))
                                                                                                   (or (and (not v) (and (not w) (and   x   (and   y     z  ))))
                                                                                                       (or (and (not v) (and (not w) (and   x   (and   y   (not z)))))
                                                                                                           (or (and (not v) (and (not w) (and   x   (and (not y)   z  ))))
                                                                                                               (or (and (not v) (and (not w) (and   x   (and (not y) (not z)))))
                                                                                                                   (or (and (not v) (and (not w) (and (not x) (and   y     z  ))))
                                                                                                                       (or (and (not v) (and (not w) (and (not x) (and   y   (not z)))))
                                                                                                                           (or (and (not v) (and (not w) (and (not x) (and (not y)   z  ))))
                                                                                                                               (and (not v) (and (not w) (and (not x) (and (not y) (not z)))))))))))))))))))))))))))))))))))))

(define bigE
'(or (and   u   (and   v   (and   w   (and   x   (and   y     z  )))))
(or (and   u   (and   v   (and   w   (and   x   (and   y   (not z))))))
(or (and   u   (and   v   (and   w   (and   x   (and (not y)   z  )))))
(or (and   u   (and   v   (and   w   (and   x   (and (not y) (not z))))))
(or (and   u   (and   v   (and   w   (and (not x) (and   y     z  )))))
(or (and   u   (and   v   (and   w   (and (not x) (and   y   (not z))))))
(or (and   u   (and   v   (and   w   (and (not x) (and (not y)   z  )))))
(or (and   u   (and   v   (and   w   (and (not x) (and (not y) (not z))))))
(or (and   u   (and   v   (and (not w) (and   x   (and   y     z  )))))
(or (and   u   (and   v   (and (not w) (and   x   (and   y   (not z))))))
(or (and   u   (and   v   (and (not w) (and   x   (and (not y)   z  )))))
(or (and   u   (and   v   (and (not w) (and   x   (and (not y) (not z))))))
(or (and   u   (and   v   (and (not w) (and (not x) (and   y     z  )))))
(or (and   u   (and   v   (and (not w) (and (not x) (and   y   (not z))))))
(or (and   u   (and   v   (and (not w) (and (not x) (and (not y)   z  )))))
(or (and   u   (and   v   (and (not w) (and (not x) (and (not y) (not z))))))
(or (and   u   (and (not v) (and   w   (and   x   (and   y     z  )))))
(or (and   u   (and (not v) (and   w   (and   x   (and   y   (not z))))))
(or (and   u   (and (not v) (and   w   (and   x   (and (not y)   z  )))))
(or (and   u   (and (not v) (and   w   (and   x   (and (not y) (not z))))))
(or (and   u   (and (not v) (and   w   (and (not x) (and   y     z  )))))
(or (and   u   (and (not v) (and   w   (and (not x) (and   y   (not z))))))
(or (and   u   (and (not v) (and   w   (and (not x) (and (not y)   z  )))))
(or (and   u   (and (not v) (and   w   (and (not x) (and (not y) (not z))))))
(or (and   u   (and (not v) (and (not w) (and   x   (and   y     z  )))))
(or (and   u   (and (not v) (and (not w) (and   x   (and   y   (not z))))))
(or (and   u   (and (not v) (and (not w) (and   x   (and (not y)   z  )))))
(or (and   u   (and (not v) (and (not w) (and   x   (and (not y) (not z))))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and   y     z  )))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and   y   (not z))))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and (not y)   z  )))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and (not y) (not z))))))
(or (and (not u) (and   v   (and   w   (and   x   (and   y     z  )))))
(or (and (not u) (and   v   (and   w   (and   x   (and   y   (not z))))))
(or (and (not u) (and   v   (and   w   (and   x   (and (not y)   z  )))))
(or (and (not u) (and   v   (and   w   (and   x   (and (not y) (not z))))))
(or (and (not u) (and   v   (and   w   (and (not x) (and   y     z  )))))
(or (and (not u) (and   v   (and   w   (and (not x) (and   y   (not z))))))
(or (and (not u) (and   v   (and   w   (and (not x) (and (not y)   z  )))))
(or (and (not u) (and   v   (and   w   (and (not x) (and (not y) (not z))))))
(or (and (not u) (and   v   (and (not w) (and   x   (and   y     z  )))))
(or (and (not u) (and   v   (and (not w) (and   x   (and   y   (not z))))))
(or (and (not u) (and   v   (and (not w) (and   x   (and (not y)   z  )))))
(or (and (not u) (and   v   (and (not w) (and   x   (and (not y) (not z))))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and   y     z  )))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and   y   (not z))))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and (not y)   z  )))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and (not y) (not z))))))
(or (and (not u) (and (not v) (and   w   (and   x   (and   y     z  )))))
(or (and (not u) (and (not v) (and   w   (and   x   (and   y   (not z))))))
(or (and (not u) (and (not v) (and   w   (and   x   (and (not y)   z  )))))
(or (and (not u) (and (not v) (and   w   (and   x   (and (not y) (not z))))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and   y     z  )))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and   y   (not z))))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and (not y)   z  )))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and (not y) (not z))))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and   y     z  )))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and   y   (not z))))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and (not y)   z  )))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and (not y) (not z))))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and   y     z  )))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and   y   (not z))))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and (not y)   z  )))))
   (and (not u) (and (not v) (and (not w) (and (not x) (and (not y) (not z))))))
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
)

(define bigE1
'(or (and   u   (and   v   (and   w   (and   x   (and   y   (not z))))))
(or (and   u   (and   v   (and   w   (and   x   (and (not y)   z  )))))
(or (and   u   (and   v   (and   w   (and   x   (and (not y) (not z))))))
(or (and   u   (and   v   (and   w   (and (not x) (and   y     z  )))))
(or (and   u   (and   v   (and   w   (and (not x) (and   y   (not z))))))
(or (and   u   (and   v   (and   w   (and (not x) (and (not y)   z  )))))
(or (and   u   (and   v   (and   w   (and (not x) (and (not y) (not z))))))
(or (and   u   (and   v   (and (not w) (and   x   (and   y     z  )))))
(or (and   u   (and   v   (and (not w) (and   x   (and   y   (not z))))))
(or (and   u   (and   v   (and (not w) (and   x   (and (not y)   z  )))))
(or (and   u   (and   v   (and (not w) (and   x   (and (not y) (not z))))))
(or (and   u   (and   v   (and (not w) (and (not x) (and   y     z  )))))
(or (and   u   (and   v   (and (not w) (and (not x) (and   y   (not z))))))
(or (and   u   (and   v   (and (not w) (and (not x) (and (not y)   z  )))))
(or (and   u   (and   v   (and (not w) (and (not x) (and (not y) (not z))))))
(or (and   u   (and (not v) (and   w   (and   x   (and   y     z  )))))
(or (and   u   (and (not v) (and   w   (and   x   (and   y   (not z))))))
(or (and   u   (and (not v) (and   w   (and   x   (and (not y)   z  )))))
(or (and   u   (and (not v) (and   w   (and   x   (and (not y) (not z))))))
(or (and   u   (and (not v) (and   w   (and (not x) (and   y     z  )))))
(or (and   u   (and (not v) (and   w   (and (not x) (and   y   (not z))))))
(or (and   u   (and (not v) (and   w   (and (not x) (and (not y)   z  )))))
(or (and   u   (and (not v) (and   w   (and (not x) (and (not y) (not z))))))
(or (and   u   (and (not v) (and (not w) (and   x   (and   y     z  )))))
(or (and   u   (and (not v) (and (not w) (and   x   (and   y   (not z))))))
(or (and   u   (and (not v) (and (not w) (and   x   (and (not y)   z  )))))
(or (and   u   (and (not v) (and (not w) (and   x   (and (not y) (not z))))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and   y     z  )))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and   y   (not z))))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and (not y)   z  )))))
(or (and   u   (and (not v) (and (not w) (and (not x) (and (not y) (not z))))))
(or (and (not u) (and   v   (and   w   (and   x   (and   y     z  )))))
(or (and (not u) (and   v   (and   w   (and   x   (and   y   (not z))))))
(or (and (not u) (and   v   (and   w   (and   x   (and (not y)   z  )))))
(or (and (not u) (and   v   (and   w   (and   x   (and (not y) (not z))))))
(or (and (not u) (and   v   (and   w   (and (not x) (and   y     z  )))))
(or (and (not u) (and   v   (and   w   (and (not x) (and   y   (not z))))))
(or (and (not u) (and   v   (and   w   (and (not x) (and (not y)   z  )))))
(or (and (not u) (and   v   (and   w   (and (not x) (and (not y) (not z))))))
(or (and (not u) (and   v   (and (not w) (and   x   (and   y     z  )))))
(or (and (not u) (and   v   (and (not w) (and   x   (and   y   (not z))))))
(or (and (not u) (and   v   (and (not w) (and   x   (and (not y)   z  )))))
(or (and (not u) (and   v   (and (not w) (and   x   (and (not y) (not z))))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and   y     z  )))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and   y   (not z))))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and (not y)   z  )))))
(or (and (not u) (and   v   (and (not w) (and (not x) (and (not y) (not z))))))
(or (and (not u) (and (not v) (and   w   (and   x   (and   y     z  )))))
(or (and (not u) (and (not v) (and   w   (and   x   (and   y   (not z))))))
(or (and (not u) (and (not v) (and   w   (and   x   (and (not y)   z  )))))
(or (and (not u) (and (not v) (and   w   (and   x   (and (not y) (not z))))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and   y     z  )))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and   y   (not z))))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and (not y)   z  )))))
(or (and (not u) (and (not v) (and   w   (and (not x) (and (not y) (not z))))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and   y     z  )))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and   y   (not z))))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and (not y)   z  )))))
(or (and (not u) (and (not v) (and (not w) (and   x   (and (not y) (not z))))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and   y     z  )))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and   y   (not z))))))
(or (and (not u) (and (not v) (and (not w) (and (not x) (and (not y)   z  )))))
   (and (not u) (and (not v) (and (not w) (and (not x) (and (not y) (not z))))))
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))



(define-struct Not (arg))
(define-struct And (left right))
(define-struct Or (left right))
(define-struct Implies (left right))
(define-struct If (test conseq alt))

;; a BoolExp is either
;; * a constant true or false,
;; * a variable S,
;; * a Not form (make-Not X),
;; * an And form (make-And X Y),
;; * an Or form (make-Or X Y),
;; * an Implies form (make-Implies X Y),
;; * an If form (make-If X Y Z),
;; where S is a symbol (other than a keyword) and X, Y, and Z are BoolExps.

;;A BoolRacketExp is either:
;;* a boolean constant true or false;;
;;* a symbol;;
;;* (list 'not X) where X is a BoolRacketExp;;
;;* (list op X Y) where op is 'and 'or 'implies where X and Y are BoolRacketExps;;
;;* (list 'if X Y Z) where X, Y, and Z are BoolRacketExps


;; A (IfExp alpha) is BoolExp in If form (make-If X Y Z)

;; Generic Template for any function f with primary argument alpha of type IfExp

#|
(define (f alpha)
  ... (If-test aplpha) ... (If-conseq alpha) ... (If-alt alpha) ...
  )
|#

;; A (NormIfExp alpha) is BoolExp in If form (make-If X Y Z) where test case (X) contains either a boolean or a symbol, no nested if cases inside test are allowed

;; Generic Template for any function f with primary argument alpha of type NormIfExp

#|
(define (f alpha)
  ... (If-test aplpha) ... (If-conseq alpha) ... (If-alt alpha) ...
  )
|#

;;parse: BoolRacketExp -> BoolExp
;;Purpose: (parse bse) returns the BoolExp corresponding to the BoolRacketExp bse

;;Examples
(check-expect (parse true) true)
(check-expect (parse 'x) 'x)
(check-expect (parse '(and x y)) (make-And 'x 'y))
(check-expect (parse '(or x y)) (make-Or 'x 'y))
(check-expect (parse '(implies x y)) (make-Implies 'x 'y))
(check-expect (parse '(if x y z)) (make-If 'x 'y 'z))
(check-expect (parse '(if x true false)) (make-If 'x true false))
(check-expect (parse '(not true)) (make-Not true))
                                        
;; Template instantiation
#|
(define (parse bse)
  (cond [(boolean? bse) ...]
        [(symbol? bse) ...]
        [else 
         (local [(define head (first bse))]
           (cond [(equal? head not) ...]
                 [(equal? head 'and) ...]
                 [(equal? head 'or) ...]
                 [(equal? head 'implies) ...]
                 [(equal? head 'if) ...]))]))
|#
(define (parse bse)
  (cond [(boolean? bse) bse]
        [(equal? bse 'true) true]
        [(equal? bse 'false) false]
        [(symbol? bse) bse]
        [else 
         (local [(define head (first bse))
                 (define args (rest bse))
                 (define val1 (parse (first args)))]
           (cond [(equal? head 'not) (make-Not val1)]
                 [else 
                  (local [(define val2 (parse (first (rest args))))]
                    (cond [(equal? head 'and) (make-And val1 val2)]
                          [(equal? head 'or) (make-Or val1 val2)]
                          [(equal? head 'implies) (make-Implies val1 val2)]
                          [(equal? head 'if) (make-If val1 val2 (parse (first (rest (rest args)))))]))]))]))

;;unparse: BoolExp -> BoolRacketExp
;;Purpose: (unparse be) returns the BoolRacketExp corresponding to the BoolExp be

;; Examples
(check-expect (unparse true) true)
(check-expect (unparse 'x) 'x)
(check-expect (unparse (make-Not 'x)) '(not x))
(check-expect (unparse (make-And 'x 'y)) '(and x y))
(check-expect (unparse (make-Or 'x 'y)) '(or x y))
(check-expect (unparse (make-Implies 'x 'y)) '(implies x y))
(check-expect (unparse (make-If 'x 'y 'z)) '(if x y z))
           
;; Template Instantiation
#|
(define (unparse be)
  (cond [(equal? be true) ...]
        [(equal? be false) ...]
        [(symbol? be) ...]
        [(Not? be) ... (unparse (Not-arg be)) ...]
        [(And? be) ... (unparse (And-left be))
                  ... (unparse (And-right be)) ...]
        [(Or? be) ... (unparse (Or-left be))
                  ... (unparse (Or-right be)) ...]
        [(Implies? be) ... (unparse (Implies-left be))
                       ... (unparse (Implies-right be)) ...]
        [else ;; (must be (make-If be1 be2 be3))
         ... (unparse (If-test be))
         ... (unparse (If-conseq be)) 
         ... (unparse (If-alt be)) ...]
|#
(define (unparse be)
  (cond [(boolean? be) be]
        [(symbol? be) be]
        [(Not? be) (list 'not (unparse (Not-arg be)))]
        [(And? be) (list 'and (unparse (And-left be)) (unparse (And-right be)))]
        [(Or? be)  (list 'or  (unparse (Or-left be))  (unparse (Or-right be)))]
        [(Implies? be) (list 'implies (unparse (Implies-left be)) (unparse (Implies-right be)))]
        [(If? be) (list 'if (unparse (If-test be)) (unparse (If-conseq be)) (unparse (If-alt be)))]))





;; convertToIf: BoolExp -> BoolExp
;; Contract: (convertToIf exp) receives boolean expression which contains and, or, not, implies, or if operations and converts into expression that contains only if expressions

;; Examples:
;; (check-expect (convertToIf (make-Not 'X)) (make-If 'X false true))
;; (check-expect (convertToIf (make-And 'X 'Y)) (make-If 'X 'Y false))
;; (check-expect (convertToIf (make-Or 'X 'Y)) (make-If 'X true 'Y))
;; (check-expect (convertToIf (make-Implies 'X 'Y)) (make-If 'X 'Y true))
;; (check-expect (convertToIf (make-Or (make-And 'x 'y) 'z)) (make-If (make-If 'x 'y false) true 'z))
;; (check-expect (convertToIf (make-Implies 'x (make-Not 'y))) (make-If 'x (make-If 'y false true) true))

;; Template instantiation:
#|
(define (convertToIf exp)

  (cond
    [(Not? exp) ... (Not-arg exp) ... false ... true ... ]
    [(And? exp) ... (And-left exp) ... (And-right exp) ... false ... ]
    [(Or? exp) ... (Or-left exp) ... true ... (Or-right exp) ... ]
    [(Implies? exp) ... (Implies-left exp) ... (Implies-right exp) ... true ... ]
    [(If? exp) ... (If-test exp) ... (If-conseq exp) ... (If-alt exp) ... ]
    [else exp]
    )

)
|#

;; Code:
(define (convertToIf exp)

  (cond
    [(Not? exp) (make-If (convertToIf (Not-arg exp)) false true)]
    [(And? exp) (make-If (convertToIf (And-left exp)) (convertToIf (And-right exp)) false)]
    [(Or? exp) (make-If (convertToIf (Or-left exp)) true (convertToIf (Or-right exp)))]
    [(Implies? exp) (make-If (convertToIf (Implies-left exp)) (convertToIf (Implies-right exp)) true)]
    [(If? exp) (make-If (convertToIf (If-test exp)) (convertToIf (If-conseq exp)) (convertToIf (If-alt exp)))]
    [else exp]
    )

)

;; Tests:
(check-expect (convertToIf (make-Not 'X)) (make-If 'X false true))
(check-expect (convertToIf (make-And 'X 'Y)) (make-If 'X 'Y false))
(check-expect (convertToIf (make-Or 'X 'Y)) (make-If 'X true 'Y))
(check-expect (convertToIf (make-Implies 'X 'Y)) (make-If 'X 'Y true))
(check-expect (convertToIf (make-Or (make-And 'x 'y) 'z)) (make-If (make-If 'x 'y false) true 'z))
(check-expect (convertToIf (make-Implies 'x (make-Not 'y))) (make-If 'x (make-If 'y false true) true))






;; head-normalize: NormIfExp NormIfExp NormIfExp -> NormIfExp
;; Contract: (head-normalize a b c) receives three NormIfExps a b c and constucts equivalent NormIfExp (make-If a b c)

;; Examples:
;; (check-expect (head-normalize 'x 'y 'z) (make-If 'x 'y 'z))
;; (check-expect (head-normalize true 'y 'z) (make-If true 'y 'z))
;; (check-expect (head-normalize false 'y 'z) (make-If false 'y 'z))
;; (check-expect (head-normalize (make-If 'x 'y 'z) 'u 'v) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))
;; (check-expect (head-normalize (make-If 'x (make-If 'yt 'yc 'ya) (make-If 'zt 'zc 'za)) 'u 'v) (make-If 'x (make-If 'yt (make-If 'yc 'u 'v) (make-If 'ya 'u 'v)) (make-If 'zt (make-If 'zc 'u 'v) (make-If 'za 'u 'v))))

;; Template instantiation:
#|
(define (head-normalize a b c)
  (cond
    [(If? a)
     
     ... (head-normalize (If-test a) ... ) ...
     
     ]
    [else (make-If a b c)]
  )
)
|#

;; Code:
(define (head-normalize a b c)
  (cond
    [(If? a)
     (local ((define temp1 (head-normalize (If-conseq a) b c)) (define temp2  (head-normalize (If-alt a) b c)))

       (head-normalize (If-test a) temp1 temp2)

       )
     ]
    [else (make-If a b c)]
  )
)

;; Tests:
(check-expect (head-normalize 'x 'y 'z) (make-If 'x 'y 'z))
(check-expect (head-normalize true 'y 'z) (make-If true 'y 'z))
(check-expect (head-normalize false 'y 'z) (make-If false 'y 'z))
(check-expect (head-normalize (make-If 'x 'y 'z) 'u 'v) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))
(check-expect (head-normalize (make-If 'x (make-If 'yt 'yc 'ya) (make-If 'zt 'zc 'za)) 'u 'v) (make-If 'x (make-If 'yt (make-If 'yc 'u 'v) (make-If 'ya 'u 'v)) (make-If 'zt (make-If 'zc 'u 'v) (make-If 'za 'u 'v))))


;; normalize: IfExp -> NormIfExp
;; Contract: (normalize exp) receives IfExp exp and eliminates all if constructions that appear in test positions inside if constructions

;; Examples:
;; (check-expect (normalize true) true)
;; (check-expect (normalize false) false)
;; (check-expect (normalize 'x) 'x)
;; (check-expect (normalize (make-If 'x 'y 'z)) (make-If 'x 'y 'z))
;; (check-expect (normalize (make-If (make-If 'x 'y 'z) 'u 'v)) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))

;; Template instantiation:
#|
(define (normalize exp)
  (cond
    [(If? exp)
        
        ... (head-normalize XYZ U V) ...
     
     ]
    [else exp]
  )
)
|#

;; Code:
(define (normalize exp)
  (cond
    [(If? exp)
      (let ([U (normalize (If-conseq exp))] [V (normalize (If-alt exp))] [XYZ (If-test exp)])

        (head-normalize XYZ U V)

        )
     ]
    [else exp]
  )
)

;; Tests:
(check-expect (normalize true) true)
(check-expect (normalize false) false)
(check-expect (normalize 'x) 'x)
(check-expect (normalize (make-If 'x 'y 'z)) (make-If 'x 'y 'z))
(check-expect (normalize (make-If (make-If 'x 'y 'z) 'u 'v)) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))



;; A (environment alpha) is either:
;; a empty or,
;; a (list-of binding).

;; Generic Template for any function f with primary argument alpha of type environment

#|
(define (f alpha)
  (cond
    [(empty? alpha) ...]
    [else (... (binding-v (first alpha)) ... (rest alpha) ...)]
    )
  )
|#

(define-struct binding (s v))

(define empty-env empty)

;; extend: environment symbol number -> environment
;; Contract: (extend env s n) receives environment env, a symbol s, and a number n, and returns an extended environment identical to env except that it adds the additional binding of s to n

;; Examples:
;; (check-expect (extend empty-env 'a 4) (list (make-binding 'a 4)))
;; (check-expect (extend empty-env 'b 12) (list (make-binding 'b 12)))
;; (check-expect (extend (extend empty-env 'a 4) 'b 12) (list (make-binding 'a 4) (make-binding 'b 12)))
;; (check-expect (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20) (list (make-binding 'a 4) (make-binding 'b 12) (make-binding 'c 20)))

;; Template instantiation:
#|
(define (extend env s n)
  (append env (... (make-binding s n) ...))
  )
|#


;; Code:
(define (extend env s n)
  (append env (list (make-binding s n)))
  )

;; Tests:
(check-expect (extend empty-env 'a 4) (list (make-binding 'a 4)))
(check-expect (extend empty-env 'b 12) (list (make-binding 'b 12)))
(check-expect (extend (extend empty-env 'a 4) 'b 12) (list (make-binding 'a 4) (make-binding 'b 12)))
(check-expect (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20) (list (make-binding 'a 4) (make-binding 'b 12) (make-binding 'c 20)))


;; lookup symbol environment -> option-binding, which is either binging or empty
;; Contract: (lookup s env) receives a symbol s and environment env and returns the first binding in env with a s component that equals s


;; Examples:
;; (check-expect (lookup 'a (extend empty-env 'a 4)) (make-binding 'a 4))
;; (check-expect (lookup 'b (extend empty-env 'a 4)) empty)
;; (check-expect (lookup 'b (extend empty-env 'b 12)) (make-binding 'b 12))
;; (check-expect (lookup 'a (extend empty-env 'b 12)) empty)
;; (check-expect (lookup 'a (extend (extend empty-env 'a 4) 'b 12)) (make-binding 'a 4))
;; (check-expect (lookup 'b (extend (extend empty-env 'a 4) 'b 12)) (make-binding 'b 12))
;; (check-expect (lookup 'c (extend (extend empty-env 'a 4) 'b 12)) empty)
;; (check-expect (lookup 'a (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'a 4))
;; (check-expect (lookup 'b (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'b 12))
;; (check-expect (lookup 'c (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'c 20))
;; (check-expect (lookup 'd (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) empty)


;; Template instantiation:
#|
(define (lookup s env)
  (cond
    [(empty? env) ...]
    [(equal? (binding-s (first env)) s) (... (first env) ...)]
    [else (lookup ... (rest env))]
    )
  )
|#

;; Code:
(define (lookup s env)
  (cond
    [(empty? env) empty]
    [(equal? (binding-s (first env)) s) (first env)]
    [else (lookup s (rest env))]
    )
  )

;; Tests:
(check-expect (lookup 'a (extend empty-env 'a 4)) (make-binding 'a 4))
(check-expect (lookup 'b (extend empty-env 'a 4)) empty)
(check-expect (lookup 'b (extend empty-env 'b 12)) (make-binding 'b 12))
(check-expect (lookup 'a (extend empty-env 'b 12)) empty)
(check-expect (lookup 'a (extend (extend empty-env 'a 4) 'b 12)) (make-binding 'a 4))
(check-expect (lookup 'b (extend (extend empty-env 'a 4) 'b 12)) (make-binding 'b 12))
(check-expect (lookup 'c (extend (extend empty-env 'a 4) 'b 12)) empty)
(check-expect (lookup 'a (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'a 4))
(check-expect (lookup 'b (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'b 12))
(check-expect (lookup 'c (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) (make-binding 'c 20))
(check-expect (lookup 'd (extend (extend (extend empty-env 'a 4) 'b 12) 'c 20)) empty)



;; eval: NormIfExp environment -> NormIfExp
;; Contract: (eval exp env) receives a boolean expression and reduces it to simpler form: reduces all tautologies to true and contradictions to false


;; Examples:
;; (check-expect (eval (make-If true 'X 'Y) empty-env) 'X)
;; (check-expect (eval (make-If false 'X 'Y) empty-env) 'Y)
;; (check-expect (eval (make-If 'X true false) empty-env) 'X)
;; (check-expect (eval (make-If 'X 'Y 'Y) empty-env) 'Y)

;; Template instantiation:
#|
(define (eval exp env)
  (cond
    [(If? exp)

     (cond
       [(equal? (If-test exp) true) ... (If-conseq exp) ... ]
       [(equal? (If-test exp) false) ... (If-alt exp) ... ]
       [(and (equal? (If-conseq exp) true) (equal? (If-alt exp) false)) ... (If-test exp) ... ]
       [(equal? (If-conseq exp) (If-alt exp)) ... (If-conseq exp) ... ]

       [(symbol? (If-test exp))

         (cond
           [(binding? ...) ... (binding-v temp) ...]
           [else
            
            ... (extend env (If-test exp) true)) ... (extend env (If-test exp) false)) ...
            
           ]
          )
         )
        ]
        
       ...
       )
     ]

    [else exp]

  )
)
|#

;; Code:
(define (eval exp env)
  (cond
    [(If? exp)

     (cond
       [(equal? (If-test exp) true) (eval (If-conseq exp) env)]
       [(equal? (If-test exp) false) (eval (If-alt exp) env)]
       [(and (equal? (If-conseq exp) true) (equal? (If-alt exp) false)) (eval (If-test exp) env)]
       [(equal? (If-conseq exp) (If-alt exp)) (eval (If-conseq exp) env)]

       [(symbol? (If-test exp))
       (local ((define temp (lookup (If-test exp) env)))

         (cond
           [(binding? temp) (eval (make-If (binding-v temp) (If-conseq  exp) (If-alt exp)) env)]
           [else
            
            (make-If (If-test exp) (eval (If-conseq exp) (extend env (If-test exp) true)) (eval (If-alt exp) (extend env (If-test exp) false)))
            
           ]
          )
         )
        ]
        
       [else (make-If (eval (If-test exp) env) (eval (If-conseq exp) env) (eval (If-alt exp) env))]
       )
     ]

    [else exp]

  )
)

;; Tests:
(check-expect (eval (make-If true 'X 'Y) empty-env) 'X)
(check-expect (eval (make-If false 'X 'Y) empty-env) 'Y)
(check-expect (eval (make-If 'X true false) empty-env) 'X)
(check-expect (eval (make-If 'X 'Y 'Y) empty-env) 'Y)




;; convertToBool: BoolExp -> BoolExp
;; Contract: (convertToBool exp) receives boolean expression which contains only if operations and converts into expression that contains and, or, not, implies, and if expressions


;; Examples:
;; (check-expect (convertToBool (make-If 'X false true)) (make-Not 'X))
;; (check-expect (convertToBool (make-If 'X 'Y false)) (make-And 'X 'Y))
;; (check-expect (convertToBool (make-If 'X true 'Y)) (make-Or 'X 'Y))
;; (check-expect (convertToBool (make-If 'X 'Y true)) (make-Implies 'X 'Y))


;; Template instantiation:
#|
(define (convertToBool exp)

  (cond
    [(If? exp)

     (cond

       [(and (equal? (If-conseq exp) false) (equal? (If-alt exp) true)) (make-Not ... (If-test exp) ...)]
       [(equal? (If-alt exp) false) (make-And ... (If-test exp) ... (If-conseq exp) ...)]
       [(equal? (If-conseq exp) true) (make-Or ... (If-test exp) ... (If-alt exp) ...)]
       [(equal? (If-alt exp) true) (make-Implies ... (If-test exp) ... (If-conseq exp) ...)]
       [else ...]

       )
     ]

    [else exp]
    
  )
)
|#

;; Code:
(define (convertToBool exp)

  (cond
    [(If? exp)

     (cond

       [(and (equal? (If-conseq exp) false) (equal? (If-alt exp) true)) (make-Not (convertToBool (If-test exp)))]
       [(equal? (If-alt exp) false) (make-And (convertToBool (If-test exp)) (convertToBool (If-conseq exp)))]
       [(equal? (If-conseq exp) true) (make-Or (convertToBool (If-test exp)) (convertToBool (If-alt exp)))]
       [(equal? (If-alt exp) true) (make-Implies (convertToBool (If-test exp)) (convertToBool (If-conseq exp)))]
       [else (make-If (convertToBool (If-test exp)) (convertToBool (If-conseq exp)) (convertToBool (If-alt exp)))]

       )
     ]

    [else exp]
    
  )
)

;; Tests:
(check-expect (convertToBool (make-If 'X false true)) (make-Not 'X))
(check-expect (convertToBool (make-If 'X 'Y false)) (make-And 'X 'Y))
(check-expect (convertToBool (make-If 'X true 'Y)) (make-Or 'X 'Y))
(check-expect (convertToBool (make-If 'X 'Y true)) (make-Implies 'X 'Y))


;; reduce-help: BoolExp -> boolean
;; Contract: (reduce-help exp) receives a BoolExp boolean expression and evaluates its boolean value

;; Template instantiation:
#|
(define (reduce-help exp)
  (cond

    [(If? exp)
     (cond

       ...
       )
     ]

    [(Or? exp)
     (cond

       ...
     )     
    ]

    [(And? exp)
     (cond

       ...
     )
    ]

    [(Not? exp)
     (cond

       ...
     )
    ]

    [(Implies? exp)
     (cond

       ...
     )
    ]

    [else exp]

    )
)
|#

;; Code:
(define (reduce-help exp)
  (cond

    [(If? exp)
     (cond

       [(and (equal? (If-conseq exp) true) (equal? (If-alt exp) true)) true]
       [(and (equal? (If-conseq exp) false) (equal? (If-alt exp) false)) false]
       [(equal? (If-test exp) true) (reduce-help (If-conseq exp))]
       [(equal? (If-test exp) false) (reduce-help (If-alt exp))]
       [else (reduce-help (make-If (reduce-help (If-test exp)) (reduce-help (If-conseq exp)) (reduce-help (If-alt exp))))]

       )
     ]

    [(Or? exp)
     (cond

       [(or (equal? (Or-left exp) true) (equal? (Or-right exp) true)) true]
       [(and (equal? (Or-left exp) false) (equal? (Or-right exp) false)) false]
       [else (reduce-help (make-Or (reduce-help (Or-left exp)) (reduce-help (Or-right exp))))]
       
     )     
    ]

    [(And? exp)
     (cond

       [(and (equal? (And-left exp) true) (equal? (And-right exp) true)) true]
       [(or (equal? (And-left exp) false) (equal? (And-right exp) false)) false]
       [else (reduce-help (make-And (reduce-help (And-left exp)) (reduce-help (And-right exp))))]

     )
    ]

    [(Not? exp)
     (cond

       [(equal? (Not-arg exp) true) false]
       [(equal? (Not-arg exp) false) true]
       [else (reduce-help (make-Not (reduce-help (Not-arg exp))))]
       
     )
    ]

    [(Implies? exp)
     (cond

       [(equal? (Implies-right exp) true) true]
       [(and (equal? (Implies-left exp) false) (equal? (Implies-right exp) false)) true]
       [(equal? (Implies-left exp) (Implies-right exp)) true]
       [else (reduce-help (make-Implies (reduce-help (Implies-left exp)) (reduce-help (Implies-right exp))))]
       
     )
    ]

    [else exp]

    )
)


;; reduce: BoolRacketExp -> boolean
;; Contract: (reduce rawExp) receives a BoolRacketExp boolean expression and evaluates its boolean value: it uses reduce-help function to evaluate boolean value
;; it converts rawExp in BoolRacketExp form into BoolExp form using parse, convertToIf, normalize, eval, and convertToBool functions, in that order

;; Examples:
;; (check-expect (reduce smallE) true)
;; (check-expect (reduce smallE2) true)
;; (check-expect (reduce midE) true)
;; (check-expect (reduce bigE) true)

;; Template instantiation:
#|
(define (reduce rawExp)

  (reduce-help (convertToBool (eval (normalize (convertToIf (parse rawExp))) empty-env)))

)
|#

;; Code:
(define (reduce rawExp)

  (reduce-help (convertToBool (eval (normalize (convertToIf (parse rawExp))) empty-env)))

)

;; Tests:
(check-expect (reduce smallE) true)
(check-expect (reduce smallE2) true)
(check-expect (reduce midE) true)
(check-expect (reduce bigE) true)
;; (reduce bigE1) -> can't reduce this one, there is one short subexpression inside that does not always evaluate to single boolean value


