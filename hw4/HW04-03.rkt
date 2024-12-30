;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HW04-03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct sum (left right))
(define-struct prod (left right))
(define-struct diff (left right))
(define-struct quot (left right))




;; A (ArithExpr alpha) is either:
;; a symbol s,
;; a number n,
;; a sum (make-sum ae1 ae2) where ae1 and ae2 are ArithExpr,
;; a product (make-prod ae1 ae2) where ae1 and ae2 are ArithExpr,
;; a difference (make-diff ae1 ae2) where ae1 and ae2 are ArithExpr, or
;; a quotient (make-quot ae1 ae2) where ae1 and ae2 are ArithExpr.

;; Generic Template for any function f with primary argument alpha of type ArithExpr

#|
(define (f alpha)
  (cond
    [(symbol? alpha) ...]
    [(number? alpha) ...]
    [(sum? alpha) (... (f ... (sum-left exp) ... (sum-right exp) ...))]
    [(prod? alpha) (... (f ... (prod-left exp) ... (prod-right exp) ...))]
    [(diff? alpha) (... (f ... (diff-left exp) ... (diff-right exp) ...))]
    [(quot? alpha) (... (f ... (quot-left exp) ... (quot-right exp) ...))]
    [else alpha]
    )
  )
|#



(define-struct binding (var val))


;; environment: symbol -> option-binding, which is binding or empty
;; Contract (enviornment s) receives a symbol and returns a binding that has var component equal to s or empty if no such binding is found
(define empty-env (lambda (x) empty))


;; extend: environment symbol number -> environment
;; Contract: (extend env s n) receives environment env, a symbol s, and a number n, and returns an extended environment identical to env except that it adds the additional binding of s to n

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
(define (extend env s n)
(lambda (x) (cond
              [(equal? s x) ...(make-binding s n)...]
              [else ...(env x)...]
    ))
  )
|#


;; Code:
(define (extend env s n)
(lambda (x) (cond
              [(equal? s x) (make-binding s n)]
              [else (env x)]
    ))
  )

;; Tests are bellow definition of lookup function!



;; lookup symbol environment -> option-binding, which is binding or empty
;; Contract: (lookup s env) receives a symbol s and environment env and returns the first binding in env with a var component that equals s


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
  (env s)
)
|#

;; Code:
(define (lookup s env)
  (env s)
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


;; Tests for extend:
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



;; to-list: ArithExpr -> RacketExpr, which is a list of number, symbol '+, symbol '-, symbol '*, symbol '/, variable symbol (such as 'a, 'b), or list of RacketExpr
;; Contract: (to-list exp) maps exp to the corresponding list representation in Racket. Numbers stay unchanged, other expression are convert properly.
;; Examples:
;; (check-expect (to-list 'a) 'a)
;; (check-expect (to-list 'b) 'b)
;; (check-expect (to-list 0) 0)
;; (check-expect (to-list 1) 1)
;; (check-expect (to-list 12) 12)
;; (check-expect (to-list (make-sum 3 8)) (list '+ 3 8))
;; (check-expect (to-list (make-prod 3 8)) (list '* 3 8))
;; (check-expect (to-list (make-diff 3 8)) (list '- 3 8))
;; (check-expect (to-list (make-quot 3 8)) (list '/ 3 8))
;; (check-expect (to-list (make-sum (make-prod 4 7) 25)) (list '+ (list '* 4 7) 25))
;; (check-expect (to-list (make-quot (make-diff 4 7) 25)) (list '/ (list '- 4 7) 25))
;; (check-expect (to-list (make-sum (make-prod (make-quot 3 8) 8) (make-diff 3 8))) (list '+ (list '* (list '/ 3 8) 8) (list '- 3 8)))

;; Template instantiation:
#|
(define (to-list exp)
  (cond
    [(number? exp) ...]
    [(symbol? exp) ...]
    [(sum? exp) (... '+ (... (sum-left exp) ...) (... (sum-right exp) ...) ...)]
    [(prod? exp) (... '* (... (prod-left exp) ...) (... (prod-right exp) ...) ...)]
    [(diff? exp) (... '- (... (diff-left exp) ...) (... (diff-right exp) ...) ...)]
    [(quot? exp) (... '/ (... (quot-left exp) ...) (... (quot-right exp) ...) ...)]
    [else exp]
    )
  )
|#


;; Code:
(define (to-list exp)
  (cond
    [(number? exp) exp]
    [(symbol? exp) exp]
    [(sum? exp) (list '+ (to-list (sum-left exp)) (to-list (sum-right exp)))]
    [(prod? exp) (list '* (to-list (prod-left exp)) (to-list (prod-right exp)))]
    [(diff? exp) (list '- (to-list (diff-left exp)) (to-list (diff-right exp)))]
    [(quot? exp) (list '/ (to-list (quot-left exp)) (to-list (quot-right exp)))]
    [else exp]
    )
  )


;; Tests:
(check-expect (to-list 'a) 'a)
(check-expect (to-list 'b) 'b)
(check-expect (to-list 0) 0)
(check-expect (to-list 1) 1)
(check-expect (to-list 12) 12)
(check-expect (to-list (make-sum 3 8)) (list '+ 3 8))
(check-expect (to-list (make-prod 3 8)) (list '* 3 8))
(check-expect (to-list (make-diff 3 8)) (list '- 3 8))
(check-expect (to-list (make-quot 3 8)) (list '/ 3 8))
(check-expect (to-list (make-sum (make-prod 4 7) 25)) (list '+ (list '* 4 7) 25))
(check-expect (to-list (make-quot (make-diff 4 7) 25)) (list '/ (list '- 4 7) 25))
(check-expect (to-list (make-sum (make-prod (make-quot 3 8) 8) (make-diff 3 8))) (list '+ (list '* (list '/ 3 8) 8) (list '- 3 8)))



;; eval: ArithExpr environment -> number
;; Contract: (eval E env) evaluates an ArithExpr. It internally utilizes the to-list function to convert the ArithExpr to the appropriate and and uses the list to evaluate the expression.
;; If E contains symbols, eval will evaluate their values from the env argument.


;; Examples:
;; (check-error (eval (list ) empty-env))


;; (check-expect (eval 0 empty-env) 0)
;; (check-expect (eval 1 empty-env) 1)
;; (check-expect (eval 12 empty-env) 12)
;; (check-expect (eval (make-sum 3 8) empty-env) 11)
;; (check-expect (eval (make-prod 3 8) empty-env) 24)
;; (check-expect (eval (make-diff 3 8) empty-env) -5)
;; (check-expect (eval (make-quot 8 4) empty-env) 2)
;; (check-expect (eval (make-sum (make-prod 4 7) 25) empty-env) 53)
;; (check-expect (eval (make-quot (make-diff 4 7) 3) empty-env) -1)
;; (check-expect (eval (make-sum (make-prod (make-quot 3 3) 8) (make-diff 3 8)) empty-env) 3)

;; (check-expect (eval 'x (extend empty-env 'x 17)) 17)
;; (check-expect (eval (make-prod 4 7) (extend empty-env 'x 17)) 28)
;; (check-error (eval 'y (extend empty-env 'x 17)))


;; (check-expect (eval (make-sum 'a 8) (extend empty-env 'a 3)) 11)
;; (check-expect (eval (make-prod 3 'b) (extend empty-env 'b 8)) 24)
;; (check-expect (eval (make-diff 'a 8) (extend empty-env 'a 3)) -5)
;; (check-expect (eval (make-quot 8 'b) (extend empty-env 'b 4)) 2)
;; (check-expect (eval (make-sum (make-prod 'a 7) 25) (extend empty-env 'a 4)) 53)
;; (check-expect (eval (make-quot (make-diff 4 7) 'b) (extend empty-env 'b 3)) -1)
;; (check-expect (eval (make-sum (make-prod (make-quot 'a 3) 8) (make-diff 3 8)) (extend empty-env 'a 3)) 3)



;; Template instantiation:
#|
(define (eval ar-exp)
  
  (local ((define exp (to-list ar-exp)))
  
  (cond
    [(number? exp) ...]
    [(symbol? exp) (... (lookup exp env) ...)]
    [(equal? (first exp) '+) (+ ... (second exp) ... (third exp) ...)]
    [(equal? (first exp) '-) (- ... (second exp) ... (third exp) ...)]
    [(equal? (first exp) '*) (* ... (second exp) ... (third exp) ...)]
    [(equal? (first exp) '/) (/ ... (second exp) ... (third exp) ...)]
    [else (error ...)]
    )
  )
  )
|#

;; Code:
(define (eval E env)
  
  (local ((define exp (to-list E)))
  
  (cond
    [(number? exp) exp]
    [(symbol? exp) (binding-val (lookup exp env))]
    [(equal? (first exp) '+) (+ (eval (second exp) env) (eval (third exp) env))]
    [(equal? (first exp) '-) (- (eval (second exp) env) (eval (third exp) env))]
    [(equal? (first exp) '*) (* (eval (second exp) env) (eval (third exp) env))]
    [(equal? (first exp) '/) (/ (eval (second exp) env) (eval (third exp) env))]
    [else (error "unsupported expression")]
    )
  )
  )

;; Tests:
(check-error (eval (list ) empty-env))


(check-expect (eval 0 empty-env) 0)
(check-expect (eval 1 empty-env) 1)
(check-expect (eval 12 empty-env) 12)
(check-expect (eval (make-sum 3 8) empty-env) 11)
(check-expect (eval (make-prod 3 8) empty-env) 24)
(check-expect (eval (make-diff 3 8) empty-env) -5)
(check-expect (eval (make-quot 8 4) empty-env) 2)
(check-expect (eval (make-sum (make-prod 4 7) 25) empty-env) 53)
(check-expect (eval (make-quot (make-diff 4 7) 3) empty-env) -1)
(check-expect (eval (make-sum (make-prod (make-quot 3 3) 8) (make-diff 3 8)) empty-env) 3)

(check-expect (eval 'x (extend empty-env 'x 17)) 17)
(check-expect (eval (make-prod 4 7) (extend empty-env 'x 17)) 28)
(check-error (eval 'y (extend empty-env 'x 17)))


(check-expect (eval (make-sum 'a 8) (extend empty-env 'a 3)) 11)
(check-expect (eval (make-prod 3 'b) (extend empty-env 'b 8)) 24)
(check-expect (eval (make-diff 'a 8) (extend empty-env 'a 3)) -5)
(check-expect (eval (make-quot 8 'b) (extend empty-env 'b 4)) 2)
(check-expect (eval (make-sum (make-prod 'a 7) 25) (extend empty-env 'a 4)) 53)
(check-expect (eval (make-quot (make-diff 4 7) 'b) (extend empty-env 'b 3)) -1)
(check-expect (eval (make-sum (make-prod (make-quot 'a 3) 8) (make-diff 3 8)) (extend empty-env 'a 3)) 3)

