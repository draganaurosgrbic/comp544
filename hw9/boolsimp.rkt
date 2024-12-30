;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HW05Sol-best) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Given
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

;; Template for BoolExp
#|
(define (beFun ... be ...)
  (cond [(equal? be true] ...]
        [(equal? be false] ...]
        [(symbol? be) ...]
        [(Not? be) ... (beFun ... (Not-arg be) ...) ...]
        [(And? be) ... (beFun ... (And-left be) ...)
                  ... (beFun ... (And-right be) ...) ...]
        [(Or? be)  ... (beFun ... (Or-left be) ...)
                  ... (beFun ... (Or-right be) ...) ...]
        [(Implies? be) ... (beFun ... (Implies-left be) ...)
                      ... (beFun ... (Implies-right be) ...) ...]
        [else ;; (must be (make-If be1 be2 be3))
         ... (beFun ... (If-test be) ...)
         ... (beFun ... (If-conseq be) ...) 
         ... (beFun ... (If-alt be) ...) ...]))
|# 

;; An IfExp is either:
;; * a variable S, or
;; * an ifForm (make-If I1 I2 I3)
;; where S is a symbol and I1, I2, and I3 are IfExps.

;; Template for IfExp
#|
(define (ieFun ... ie ...)
  (cond [(equal? ie true) ...]
        [(equal? ie false) ...]
        [(symbol? ie) ...]
        [else ;; (must be (make-If? ie1 ie2 ie3))
         ... (ieFun ... (If-test ie) ...)
         ... (ieFun ... (If-conseq ie) ...) 
         ... (ieFun ... (If-alt ie) ...) ...]))

|# 

;; convertToIf: BoolExp -> IfExp
;; Purpose: (convertToIf b) converts b to a logically equivalent IfExp.
;; Examples
(check-expect (convertToIf true) true)
(check-expect (convertToIf false) false)
(check-expect (convertToIf 'x) 'x)
(check-expect (convertToIf (make-Not 'x)) (make-If 'x false true))
(check-expect (convertToIf (make-And 'x 'y)) (make-If 'x 'y false))
(check-expect (convertToIf (make-Or 'x 'y)) (make-If 'x true 'y))
(check-expect (convertToIf (make-Implies 'x 'y)) (make-If 'x 'y true))
(check-expect (convertToIf (make-If 'x 'y 'z)) (make-If 'x 'y 'z))
(check-expect (convertToIf (make-Not (make-Implies 'x 'y))) (make-If (make-If 'x 'y true) false true))
(check-expect (convertToIf (make-And (make-Not 'x) (make-Or 'x 'y))) (make-If (make-If 'x false true) (make-If 'x true 'y) false))
(check-expect (convertToIf (make-Or (make-Or 'x 'y) (make-Not 'y))) (make-If (make-If 'x true 'y) true (make-If 'y false true)))
(check-expect (convertToIf (make-If (make-Not 'x) (make-Or 'x 'y) (make-And 'x 'y))) (make-If (make-If 'x false true) (make-If 'x true 'y) (make-If 'x 'y false)))
(check-expect (convertToIf (make-Implies (make-Not 'x) (make-Or 'x 'y))) (make-If (make-If 'x false true) (make-If 'x true 'y) true))

;; Template instantiation for convertToIf
#|
(define (convertToIf b)
  (cond [(boolean? b) ...] 
        [(symbol? b) ...]
        [(Not? b) ... (convertToIf (Not-arg b)) ... ]
        [(And? b) ... (convertToIf (And-left b)) ... (convertToIf (And-right b)) ...]
        [(Or? b)  ... (convertToIf (Or-left b))  ... (convertToIf (Or-right b)) ...]
        [(Implies? b) ... (convertToIf (Implies-left b)) ... (convertToIf (Implies-right b)) ...]
        [else ;; must be an If
                 ... (convertToIf (If-test b)) ... (convertToIf (If-conseq b)) ... (convertToIf (If-alt b)) ... ]))
|#
;; Code
(define (convertToIf b)
  (cond [(boolean? b) b] 
        [(symbol? b) b]
        [(Not? b) (make-If (convertToIf (Not-arg b)) false true)]
        [(And? b) (make-If (convertToIf (And-left b)) (convertToIf (And-right b)) false)]
        [(Or? b)  (make-If (convertToIf (Or-left b)) true (convertToIf (Or-right b)))]
        [(Implies? b) (make-If (convertToIf (Implies-left b)) (convertToIf (Implies-right b)) true)]
        [else (make-If (convertToIf (If-test b)) (convertToIf (If-conseq b)) (convertToIf (If-alt b)))]))

;; An IfExp is a NormalizedIfExp iff it is (i) a constant or variable (symbol); or (ii) an ifForm (make-if X Y Z)
;; where X is a constant or variable and Y and Z are NormalizedIfExps.

;; normalize: IfExp -> NormalizedIfExp
;; Purpose: (normalize ie) returns an equivalent IfExp where If forms do not appear in test position. 

;; Examples
(check-expect (normalize true) true)
(check-expect (normalize false) false)
(check-expect (normalize 'x) 'x)
(check-expect (normalize (make-If 'x 'y 'z)) (make-If 'x 'y 'z))
(check-expect (normalize (make-If (make-If 'x 'y 'z) 'u 'v)) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))

;; indirect tests of headNormalize
(check-expect (normalize (make-If true 'y 'z)) (make-If true 'y 'z))
(check-expect (normalize (make-If false 'y 'z)) (make-If false 'y 'z))
(check-expect (normalize (make-If (make-If 'x 'y 'z) 'u 'v)) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))
(check-expect (normalize (make-If (make-If 'x (make-If 'yt 'yc 'ya) (make-If 'zt 'zc 'za)) 'u 'v)) 
              (make-If 'x (make-If 'yt (make-If 'yc 'u 'v) (make-If 'ya 'u 'v)) (make-If 'zt (make-If 'zc 'u 'v) (make-If 'za 'u 'v))))

;; Template Instantiation for normalze
#|
(define (normalize ie)
  (cond [(boolean? ie true) ...]                         ;; in this function the boolean values true and false are treated the same way
        [(symbol? ie) ...]
        [else ;; (must be (make-If? ie1 ie2 ie3))        ;; may need a combining help function
         ... (normalize (If-test ie))
         ... (normalize (If-conseq ie)) 
         ... (normalize (If-alt ie)) ...]))
|#

;; Code
(define (normalize ie)
  (cond [(boolean? ie) ie]
        [(symbol? ie)  ie]
        [else ;; (must be (make-If? ie1 ie2 ie3))
         (headNormalize (If-test ie) (normalize (If-conseq ie)) (normalize (If-alt ie)))]))

;; Observation: when y and z are normalized, (make-If x y z) is not normalized unless x is a constant (boolean) or a variable 

;; headNormalize: IfExp NormalizedIfExp NormalizedIfExp -> NormalizedIfExp
;; Purpose: Assuming IfExps y an z are normalized, (headNormalize x y z) returns a normalized IfExp equivalent to (make-If x y z)

;; Examples
(check-expect (headNormalize 'x 'y 'z) (make-If 'x 'y 'z))
(check-expect (headNormalize true 'y 'z) (make-If true 'y 'z))
(check-expect (headNormalize false 'y 'z) (make-If false 'y 'z))
(check-expect (headNormalize (make-If 'x 'y 'z) 'u 'v) (make-If 'x (make-If 'y 'u 'v) (make-If 'z 'u 'v)))
(check-expect (headNormalize (make-If 'x (make-If 'yt 'yc 'ya) (make-If 'zt 'zc 'za)) 'u 'v) 
              (make-If 'x (make-If 'yt (make-If 'yc 'u 'v) (make-If 'ya 'u 'v)) (make-If 'zt (make-If 'zc 'u 'v) (make-If 'za 'u 'v))))

;; Template Instantiation
#|
(define (headNormalize test alt conseq)
  (cond [(equal? test true) ...]
        [(equal? test false) ...]
        [(symbol? test) ...]
        [else ;; (must be (make-If? ie1 ie2 ie3))
         ... (headNormalize (If-test test) .. ..)
         ... (headNormalize (If-conseq test) .. ..) 
         ... (headNormalize (If-alt test) .. ..) ...]))
|#

;;Code
(define (headNormalize test conseq alt)
  (cond [(boolean? test)  (make-If test conseq alt)]
        [(symbol? test)   (make-If test conseq alt)]
        [else   ;; (test must be (make-If? ie1 ie2 ie3)) 
           (headNormalize (If-test test) (headNormalize (If-conseq test) conseq alt) (headNormalize (If-alt test) conseq alt))]))

;; Given
(define-struct binding (var val))
#|

A (bindingOf T) is a structure (make-binding s v) where s is a symbol and v is value of type T.

An (environmentOf T) is a (listOf (bindingOf T)).

An (option-bindingOf T) is either:
* empty, or
* a (bindingOf T) b.
|#

;; Constant definition
(define empty-env empty)

;; Example bindings and environments for subsequent use
(define b2 (make-binding 'b true))
(define b1 (make-binding 'a false))
(define env2 (list b2))
(define env1 (cons b1 env2))

;; extend: (environmentOf T) symbol T -> (environmentOf T)
(define (extend env var val) (cons (make-binding var val) env))

;; lookup: symbol (environmentOf T) -> (option-bindingOf T)
;; Purpose: (lookup s env) returns the first binding b in env such that (equal? (binding-var b) s).  If no such binding
;;          exists, (lookup s env) returns empty.

;; Examples:
(check-expect (lookup 'x empty) empty)
(check-expect (lookup 'x env2) empty)
(check-expect (lookup 'b env2) b2)
(check-expect (lookup 'b env1) b2)
(check-expect (lookup 'c env1) empty)
(check-expect (lookup 'a env1) b1)

#|
Template instantiation:
(define (lookup s env)
  (cond [(empty env) ...]
        [else ... (first env) ... (lookup s (rest env)) .. .]))
|#

(define (lookup s env)
  (cond [(empty? env) empty]
        [else 
         (let [(b (first env))]
           (if (equal? s (binding-var b)) b (lookup s (rest env))))]))

;; eval: NormalizedIfExp (environmentOf boolean) -> NormalizedIfExp
;; Purpose: (eval ie env) reduces ie to "simplest form" given the bindins in env.

;; Examples
(check-expect (eval true empty-env) true)
(check-expect (eval false empty-env) false)
(check-expect (eval 'x empty-env) 'x)
(check-expect (eval 'x (list (make-binding 'x true))) true)
(check-expect (eval (make-If 'x 'x true) empty-env) true)
(check-expect (eval (make-If 'x (make-If 'z true 'x) (make-If 'z true (make-If 'x false true))) empty-env) true)

;; Indirect tests of lookup
(check-expect (eval 'x empty) 'x)
(check-expect (eval 'x env2) 'x)
(check-expect (eval 'b env2) true)
(check-expect (eval 'b env1) true)
(check-expect (eval 'c env1) 'c)
(check-expect (eval 'a env1) false)
               

;; Template Instantiation
#|
(define (eval ie env)
  (cond [(boolean? ie) ...]  ;; when parameterized by ie, the return is the same for both boolean values
        [(symbol? ie) ...]
        [else ;; (ie must be (make-If? ie1 ie2 ie3))
         ... (eval (If-test test) .. ..)
         ... (eval (If-conseq test) .. ..) 
         ... (eval (If-alt test) .. ..) ...]))
|#

;; Code
(define (eval ie env)
  (cond [(boolean? ie) ie]
        [(symbol? ie) 
         (let [(b (lookup ie env))]
           (if (empty? b) ie (binding-val b)))]
        [else ;; ie has the form (make-If ...)
         (let [(test (eval (If-test ie) env))
               (conseq (If-conseq ie))
               (alt (If-alt ie))]
           (cond 
             [(equal? test true) (eval conseq env)]
             [(equal? test false) (eval alt env)]   
;             [(equal? conseq alt) test]  ;; potentially costly and unnecessary if input is tautology or a contradiction 
             [else  ;; test is a variable
              (let [(new-conseq (eval conseq (extend env test true)))
                    (new-alt (eval alt (extend env test false)))]
                (cond [(equal? new-conseq new-alt) new-conseq] ;; implements the rule commented out above after consequent and alternative have been simplified.
                      [(and (equal? new-conseq true) (equal? new-alt false)) test]
                      [else (make-If test new-conseq new-alt)]))]))]))
         
;; convertToBool: NormalizedIfExp -> BoolExp
;; Purpose: converts a simplified, normalized IfExp back to a conventional boolean expression

;; Examples
(check-expect (convertToBool true) true)
(check-expect (convertToBool false) false)
(check-expect (convertToBool 'x) 'x)
(check-expect (convertToBool (make-If 'x false true)) (make-Not 'x))
(check-expect (convertToBool (make-If 'x 'y false)) (make-And 'x 'y))
(check-expect (convertToBool (make-If 'x true 'y)) (make-Or 'x 'y))
(check-expect (convertToBool (make-If 'x 'y true)) (make-Implies 'x 'y)) 
(check-expect (convertToBool (make-If 'x 'y 'z)) (make-If 'x 'y 'z))
(check-expect (convertToBool (make-If 'x (make-If 'y 'z true) true)) (make-Implies 'x (make-Implies 'y 'z)))
(check-expect (convertToBool (make-If 'x (make-If 'y false true) (make-If 'y 'z false))) (make-If 'x (make-Not 'y) (make-And 'y 'z))) 
(check-expect (convertToBool (make-If 'x (make-If 'y true 'z) (make-If 'y 'z true))) (make-If 'x (make-Or 'y 'z) (make-Implies 'y 'z))) 

;; Template Instantiation
#|
(define (convertToBool ie)
  (cond [(equal? ie true) ...]
        [(equal? ie false) ...]
        [(symbol? ie) ...]
        [else ;; (must be (make-If? ie1 ie2 ie3))
         ... (If-test ie) ... (convertToIf (If-conseq ie) .. ..) ... (convertToIf (If-alt ie) .. ..) ...]))
|#

;; Code
(define (convertToBool ie)
  (cond [(boolean? ie) ie]
        [(symbol? ie) ie]
        [else ;; (must be (make-If? ie1 ie2 ie3)) where ie1, ie2, and ie3 and normalized and simplified
         (let [(test (convertToBool (If-test ie)))
               (conseq (convertToBool (If-conseq ie)))
               (alt (convertToBool (If-alt ie)))]
           (cond [(equal? conseq true) (make-Or test alt)]                    ; (if X true Z)     -> X or Z
                 [(equal? alt false) (make-And test conseq)]                  ; (if X Y false)    -> X and Y
                 [(equal? alt true) (if (equal? conseq false) (make-Not test) ; (if X true false) -> not X
                                        (make-Implies test conseq))]          ; (if X Y true)     -> x implies Y
                 [else (make-If test conseq alt)]))]))

;; rawReduce: BoolExp -> BoolExp
(define (rawReduce be) 
  (convertToBool (eval (normalize (convertToIf be)) empty-env)))

(check-expect 
 (rawReduce (make-Or (make-And 'x 'y) (make-Or (make-And 'x (make-Not 'y)) (make-Or (make-And (make-Not 'x) 'y) (make-And (make-Not 'x) (make-Not 'y)))))) 
 true)

(check-expect 
 (rawReduce (make-Or (make-And 'x (make-Not 'y)) (make-Or (make-And (make-Not 'x) 'y) (make-And (make-Not 'x) (make-Not 'y))))) 
 (make-Implies 'x (make-Not 'y)))
 
;;A BoolRacketExp is either:
;;* a boolean constant true or false;
;;* a symbol;
;;* (list 'not X) where X is a BoolRacketExp;
;;* (list op X Y) where op is 'and 'or 'implies where X and Y are BoolRacketExps;
;;* (list 'if X Y Z) where X, Y, and Z are BoolRacketExps

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
                                      
;; Template instantiation
#|
(define (parse bse)
  (cond [(boolean? bse) ...]
        [(symbol? bse) ...]
        [else 
         (let [(head (first bse))]
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
         (let* [(head (first bse))
                (args (rest bse))
                (val1 (parse (first args)))]
           (cond [(equal? head 'not) (make-Not val1)]
                 [else 
                  (let [(val2 (parse (first (rest args))))]
                    (cond [(equal? head 'and) (make-And val1 val2)]
                          [(equal? head 'or) (make-Or val1 val2)]
                          [(equal? head 'implies) (make-Implies val1 val2)]
                          [(equal? head 'if) (make-If val1 val2 (parse (first (rest (rest args)))))]))]))]))

;;parse: BoolExp -> BoolRacketExp
;;Purpose: (parse bse) returns the BoolExp corresponding to the BoolRacketExp bse

;; Examples
(check-expect (unparse true) true)
(check-expect (unparse false) false)
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

;; reduce: BoolRacketExp -> BoolRacketExp
;; Purpose: (reduce bse) reduces bse to simplest form, so all tautologies reduce to true and all contradictions reduce to false.

; Examples
(check-expect (reduce '(or (and x y) (or (and x (not y)) (or (and (not x) y) (and (not x) (not y)))))) true)
(check-expect (reduce '(or (and x (not y)) (or (and (not x) y) (and (not x) (not y))))) '(implies x (not y)))
(check-expect (reduce '(or x (not x))) true)
(check-expect (reduce '(implies (not x) y)) '(or x y))
(check-expect (reduce '(and x y)) '(and x y))
(check-expect (reduce (list 'if 'x true false)) 'x)
(check-expect (reduce '(if x y y)) 'y)
(check-expect (reduce 
               '(and (or x y)
                     (and (or x (not y))
                          (or (not x) (not y))))) 
              '(and x (not y)))

;; Code
(define (reduce bse) (unparse (rawReduce (parse bse))))

(define smallE '(or (and x y)
                    (or (and x (not y))
                        (or (and (not x) y)
                            (and (not x) (not y))))))

(check-expect (reduce smallE) true)

(define smallE2 '(or 
                  (or (and x (not y))
                      (or (and (not x) y)
                          (and (not x) (not y))))
                  (and x y)))

(check-expect (reduce smallE2) true)

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


(check-expect (reduce midE) true)

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

(check-expect (reduce bigE) true)

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

(check-expect (reduce bigE1) '(implies u (implies v (implies w (implies x (implies y (not z)))))))

(define bigE2
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
(or (and (not u) (and (not v) (and (not w) (and (not x) (and (not y)   z  )))))
   (and (not u) (and (not v) (and (not w) (and (not x) (and (not y) (not z))))))
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(check-expect (reduce bigE2) '(if u (implies v (implies w (implies x (implies y (not z))))) (or v (or w (or x (implies y z))))))

