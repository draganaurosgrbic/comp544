;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname HW04-04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct sum (left right))
(define-struct prod (left right))
(define-struct diff (left right))
(define-struct quot (left right))



(define-struct lam (var body))

(define-struct closure (lam binding))

(define-struct app (rator rand))

;; A (ArithExpr alpha) is either:
;; a symbol s,
;; a number n,
;; a app (make-app rator1 ae1) where rator1 is unary operator and ae1 is ArithExpr,
;; a lambda (make-lam var body) where var is a symbol and body is ArithExpr,
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
    [(app? exp) (... (app-rator exp) ... (app-rand exp) ...)]
    [(lam? exp) (... (lam-var exp) ... (lam-body exp) ...)]
    [(sum? alpha) (... (f ... (sum-left exp) ... (sum-right exp) ...))]
    [(prod? alpha) (... (f ... (prod-left exp) ... (prod-right exp) ...))]
    [(diff? alpha) (... (f ... (diff-left exp) ... (diff-right exp) ...))]
    [(quot? alpha) (... (f ... (quot-left exp) ... (quot-right exp) ...))]
    [else alpha]
    )
  )
|#


;; A (environment alpha) is either:
;; a empty or,
;; a (list-of binding).

;; Generic Template for any function f with primary argument alpha of type environment

#|
(define (f alpha)
  (cond
    [(empty? alpha) ...]
    [else (... (binding-val (first alpha)) ... (rest alpha) ...)]
    )
  )
|#

(define-struct binding (var val))

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
  (cond
    [(empty? env) ...]
    [(equal? (binding-var (first env)) s) (... (first env) ...)]
    [else (lookup ... (rest env))]
    )
  )
|#

;; Code:
(define (lookup s env)
  (cond
    [(empty? env) empty]
    [(equal? (binding-var (first env)) s) (first env)]
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



;; to-list: ArithExpr -> RacketExpr, which is a list of number, symbol '+, symbol '-, symbol '*, symbol '/, variable symbol (such as 'a, 'b), 'lambda, or list of RacketExpr
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


;; (check-expect (to-list (make-app '+ 3)) (list '+ 3))
;; (check-expect (to-list (make-app '- 3)) (list '- 3))
;; (check-expect (to-list (make-app '- (make-sum 3 8))) (list '- (list '+ 3 8)))
;; (check-expect (to-list (make-app '- (make-prod 3 8))) (list '- (list '* 3 8)))
;; (check-expect (to-list (make-app '- (make-diff 3 8))) (list '- (list '- 3 8)))
;; (check-expect (to-list (make-app '- (make-quot 8 2))) (list '- (list '/ 8 2)))


;; (check-expect (to-list (make-lam 'x (make-sum 'x 'y))) (list 'lambda (list 'x) (list '+ 'x 'y)))
;; (check-expect (to-list (make-lam 'a (make-sum (make-prod 'b 'c) (make-diff 'd 'e)))) (list 'lambda (list 'a) (list '+ (list '* 'b 'c) (list '- 'd 'e))))


;; Template instantiation:
#|
(define (to-list exp)
  (cond
    [(app? exp) (... (app-rator exp) (app-rand exp) ...)]
    [(lam? exp) (... 'lambda ... (lam-var exp) ... (lam-body exp) ...)]
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
    [(app? exp) (list (app-rator exp) (to-list (app-rand exp)))]
    [(lam? exp) (list 'lambda (list (lam-var exp)) (to-list (lam-body exp)))]
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

;; Tests for unary operations:
(check-expect (to-list (make-app '+ 3)) (list '+ 3))
(check-expect (to-list (make-app '- 3)) (list '- 3))
(check-expect (to-list (make-app '- (make-sum 3 8))) (list '- (list '+ 3 8)))
(check-expect (to-list (make-app '- (make-prod 3 8))) (list '- (list '* 3 8)))
(check-expect (to-list (make-app '- (make-diff 3 8))) (list '- (list '- 3 8)))
(check-expect (to-list (make-app '- (make-quot 8 2))) (list '- (list '/ 8 2)))


;; Tests for lambda functions:
(check-expect (to-list (make-lam 'x (make-sum 'x 'y))) (list 'lambda (list 'x) (list '+ 'x 'y)))
(check-expect (to-list (make-lam 'a (make-sum (make-prod 'b 'c) (make-diff 'd 'e)))) (list 'lambda (list 'a) (list '+ (list '* 'b 'c) (list '- 'd 'e))))



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

;; (check-expect (eval (make-app '+ 3) empty-env) 3)
;; (check-expect (eval (make-app '- 3) empty-env) -3)
;; (check-expect (eval (make-app '- (make-sum 3 8)) empty-env) -11)
;; (check-expect (eval (make-app '- (make-prod 3 8)) empty-env) -24)
;; (check-expect (eval (make-app '- (make-diff 3 8)) empty-env) 5)
;; (check-expect (eval (make-app '- (make-quot 8 2)) empty-env) -4)


;; (check-expect (eval (make-lam 'x (make-sum 'x 'a)) (extend empty-env 'a 4)) (make-closure (list 'lambda (list 'x) (list '+ 'x 'a)) (list (make-binding 'a 4))))
;; (check-expect (eval (make-lam 'a (make-sum (make-prod 'x 'a) (make-diff 'x 'a))) (extend empty-env 'a 4)) (make-closure (list 'lambda (list 'a) (list '+ (list '* 'x 'a) (list '- 'x 'a))) (list (make-binding 'a 4))))


;; Template instantiation:
#|
(define (eval ar-exp)
  
  (local ((define exp (to-list ar-exp)))
  
  (cond
    [(number? exp) ...]
    [(symbol? exp) (... (lookup exp env) ...)]
    [(equal? (first exp) '+) (cond [(= 3 (length exp)) (+ ... (second exp) ... (third exp) ...)] [else (+ ... (second exp) ...)])]
    [(equal? (first exp) '-) (cond [(= 3 (length exp)) (- ... (second exp) ... (third exp) ...)] [else (- ... (second exp) ...)])]  
    [(equal? (first exp) '*) (* ... (second exp) ... (third exp) ...)]
    [(equal? (first exp) '/) (/ ... (second exp) ... (third exp) ...)]
    [(equal? (first exp) 'lambda) (make-closure ...)]
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
    [(equal? (first exp) '+) (cond [(= 3 (length exp)) (+ (eval (second exp) env) (eval (third exp) env))] [else (+ (eval (second exp) env))])]
    [(equal? (first exp) '-) (cond [(= 3 (length exp)) (- (eval (second exp) env) (eval (third exp) env))] [else (- (eval (second exp) env))])]   
    [(equal? (first exp) '*) (* (eval (second exp) env) (eval (third exp) env))]
    [(equal? (first exp) '/) (/ (eval (second exp) env) (eval (third exp) env))]
    [(equal? (first exp) 'lambda) (make-closure exp env)]
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


;; Tests for unary operations:
(check-expect (eval (make-app '+ 3) empty-env) 3)
(check-expect (eval (make-app '- 3) empty-env) -3)
(check-expect (eval (make-app '- (make-sum 3 8)) empty-env) -11)
(check-expect (eval (make-app '- (make-prod 3 8)) empty-env) -24)
(check-expect (eval (make-app '- (make-diff 3 8)) empty-env) 5)
(check-expect (eval (make-app '- (make-quot 8 2)) empty-env) -4)

;; Tests for lambda functions:
(check-expect (eval (make-lam 'x (make-sum 'x 'a)) (extend empty-env 'a 4)) (make-closure (list 'lambda (list 'x) (list '+ 'x 'a)) (list (make-binding 'a 4))))
(check-expect (eval (make-lam 'a (make-sum (make-prod 'x 'a) (make-diff 'x 'a))) (extend empty-env 'a 4)) (make-closure (list 'lambda (list 'a) (list '+ (list '* 'x 'a) (list '- 'x 'a))) (list (make-binding 'a 4))))
