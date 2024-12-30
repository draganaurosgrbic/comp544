;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname comp544_hw1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; COMP 544 HW #01
;; Dragana Grbic <dg76@rice.edu>


;; A list-of-symbols is either
;;    empty, or
;;    (cons n los)
;; where n is a number, and los is a list-of-symbols
;;
;; Examples:
;; empty
;; (cons 'a empty)
;; (cons 'a (cons 'd empty))
;;
;; Template for list-of-symbols
#|
;; <los-f> : list-of-symbols -> ...
(define (<los-f> ... a-los ...)
  (cond
    [(empty? a-los) ...]
    [(cons? a-los) ... (first a-los) ...
                   ... (<los-f> ... (rest a-los) ...) ... ]))
|#

;; A list-of-numbers is either
;;    empty, or
;;    (cons n lon)
;; where n is a number, and lon is a list-of-numbers
;;
;; Examples:
;; empty
;; (cons 1 empty)
;; (cons 1 (cons 4 empty))
;;
;; Template for list-of-numbers
#|
;; <lon-f> : list-of-numbers -> ...
(define (<lon-f> ... a-lon ...)
  (cond
    [(empty? a-lon) ...]
    [(cons? a-lon) ... (first a-lon) ...
                   ... (<lon-f> ... (rest a-lon) ...) ... ]))
|#


;; Function contains?

;; Signature and Purpose:
;; contains?: symbol list-of-symbols -> boolean
;; Purpose: (contains? symbol list-of-symbols) determines whether or not the symbol occurs in a list of symbols

;; Examples
;; (contains? 'a (list )) = #false
;; (contains? 'a (list 'a)) = #true
;; (contains? 'a (list 'a 'b)) = #true
;; (contains? 'a (list 'b 'a)) = #true
;; (contains? 'a (list 'a 'b 'c))) = #true
;; (contains? 'a (list 'b 'a 'c))) = #true
;; (contains? 'a (list 'b 'c' 'a))) = #true
;; (contains? 'a (list 'b 'c 'd))) = #false

#| Template Instantiation for the contains? function:
(define (contains? symbol list-of-symbols)
  (cond
   [(empty? list-of-symbols) ...]
   [(equal? symbol (first list-of-symbols)) ...]
   [else (... contains? symbol (rest list-of-symbols))] ...))
|#

;; Code:
(define (contains? symbol list-of-symbols)
  (cond
   [(empty? list-of-symbols) false]
   [(equal? symbol (first list-of-symbols)) true]
   [else (contains? symbol (rest list-of-symbols))]))

;; Tests:
(check-expect (contains? 'a (list )) #false)
(check-expect (contains? 'a (list 'a)) #true)
(check-expect (contains? 'a (list 'a 'b)) #true)
(check-expect (contains? 'a (list 'b 'a)) #true)
(check-expect (contains? 'a (list 'a 'b 'c)) #true)
(check-expect (contains? 'a (list 'b 'a 'c)) #true)
(check-expect (contains? 'a (list 'b 'c 'a)) #true)
(check-expect (contains? 'a (list 'b 'c 'd)) #false)


;; Function count-symbols

;; Signature and Purpose:
;; count-symbols: list-of-symbols -> number
;; Purpose: (count-symbols list-of-symbols) counts how many symbols are in a list of symbols

;; Examples:
;; (count-symbols (list )) = 0
;; (count-symbols (list 'a)) = 1
;; (count-symbols (list 'a 'b)) = 2
;; (count-symbols (list 'b 'a)) = 2
;; (count-symbols (list 'a 'b 'c)) = 3
;; (count-symbols (list 'b 'a 'c)) = 3
;; (count-symbols (list 'b 'c 'a)) = 3
;; (count-symbols (list 'a 'b 'c 'd)) = 4

#| Template Instantiation for the count-symbols function:
(define (count-symbols list-of-symbols)
  (cond
    [(empty? list-of-symbols) ...]
    [else (... (count-symbols (rest list-of-symbols)))] ...))
|#

;; Code:
(define (count-symbols list-of-symbols)
  (cond
    [(empty? list-of-symbols) 0]
    [else (+ 1 (count-symbols (rest list-of-symbols)))]))

; Tests:
(check-expect (count-symbols (list )) 0)
(check-expect (count-symbols (list 'a)) 1)
(check-expect (count-symbols (list 'a 'b)) 2)
(check-expect (count-symbols (list 'b 'a)) 2)
(check-expect (count-symbols (list 'a 'b 'c)) 3)
(check-expect (count-symbols (list 'b 'a 'c)) 3)
(check-expect (count-symbols (list 'b 'c 'a)) 3)
(check-expect (count-symbols (list 'a 'b 'c 'd)) 4)


;; Function count-numbers

;; Signature and Purpose:
;; count-numbers: list-of-numbers -> number
;; Purpose: (count-numbers list-of-numbers) counts how many numbers are in a list of numbers

;; Examples:
;; (count-numbers (list )) = 0
;; (count-numbers (list 1)) = 1
;; (count-numbers (list 1 2)) = 2
;; (count-numbers (list 2 1)) = 2
;; (count-numbers (list 1 2 3)) = 3
;; (count-numbers (list 2 1 3)) = 3
;; (count-numbers (list 2 3 1)) = 3
;; (count-numbers (list 1 2 3 4)) = 4

#| Template Instantiation for the count-numbers function:
(define (count-numbers list-of-numbers)
  (cond
    [(empty? list-of-numbers) ...]
    [else (... (count-numbers (rest list-of-numbers)))] ...))
|#

;; Code:
(define (count-numbers list-of-numbers)
  (cond
    [(empty? list-of-numbers) 0]
    [else (+ 1 (count-numbers (rest list-of-numbers)))]))

; Tests:
(check-expect (count-numbers (list )) 0)
(check-expect (count-numbers (list 1)) 1)
(check-expect (count-numbers (list 1 2)) 2)
(check-expect (count-numbers (list 2 1)) 2)
(check-expect (count-numbers (list 1 2 3)) 3)
(check-expect (count-numbers (list 2 1 3)) 3)
(check-expect (count-numbers (list 2 3 1)) 3)
(check-expect (count-numbers (list 1 2 3 4)) 4)


;; Function sum-numbers

;; Signature and Purpose:
;; sum-numbers: list-of-numbers -> number
;; Purpose: (sum-numbers list-of-numbers) computes the sum of numbers in a list of numbers

;; Examples:
;; (sum-numbers (list )) = 0
;; (sum-numbers (list 1)) = 1
;; (sum-numbers (list 1 2)) = 3
;; (sum-numbers (list 2 1)) = 3
;; (sum-numbers (list 1 2 3)) = 6
;; (sum-numbers (list 2 1 3)) = 6
;; (sum-numbers (list 2 3 1)) = 6
;; (sum-numbers (list 1 2 3 4)) = 10

#| Template Instantiation for the sum-numbers function:
(define (sum-numbers list-of-numbers)
  (cond
    [(empty? list-of-numbers) 0]
    [else (... (first list-of-numbers) (sum-numbers (rest list-of-numbers)))] ...))
|#

;; Code:
(define (sum-numbers list-of-numbers)
  (cond
    [(empty? list-of-numbers) 0]
    [else (+ (first list-of-numbers) (sum-numbers (rest list-of-numbers)))]))

; Tests:
(check-expect (sum-numbers (list )) 0)
(check-expect (sum-numbers (list 1)) 1)
(check-expect (sum-numbers (list 1 2)) 3)
(check-expect (sum-numbers (list 2 1)) 3)
(check-expect (sum-numbers (list 1 2 3)) 6)
(check-expect (sum-numbers (list 2 1 3)) 6)
(check-expect (sum-numbers (list 2 3 1)) 6)
(check-expect (sum-numbers (list 1 2 3 4)) 10)


;; Function avg-price

;; Signature and Purpose:
;; avg-price list-of-toy-prices -> number
;; Purpose: (avg-price list-of-toy-prices) computes the average price of a toy in a list of toy prices, throws an error if list empty

;; Examples:
;; (avg-price (list )) = error
;; (avg-price (list 1)) = 1
;; (avg-price (list 1 2)) = 1.5
;; (avg-price (list 2 1)) = 1.5
;; (avg-price (list 1 2 3)) = 2
;; (avg-price (list 2 1 3)) = 2
;; (avg-price (list 2 3 1)) = 2
;; (avg-price (list 1 2 3 4)) = 2.5

#| Template Instantiation for the avg-price function:
(define (avg-price list-of-toy-prices)
  (cond
    [(empty? list-of-toy-prices) ...]
    [else (... (sum-numbers list-of-toy-prices) (count-numbers list-of-toy-prices))] ...))

|#

;; Code:
(define (avg-price list-of-toy-prices)
  (cond
    [(empty? list-of-toy-prices) (error "CAN'T COMPUTE AVERAGE OF EMPTY LIST")]
    [else (/ (sum-numbers list-of-toy-prices) (count-numbers list-of-toy-prices))]))

; Tests:
(check-error (avg-price (list )))
(check-expect (avg-price (list 1)) 1)
(check-expect (avg-price (list 1 2)) 1.5)
(check-expect (avg-price (list 2 1)) 1.5)
(check-expect (avg-price (list 1 2 3)) 2)
(check-expect (avg-price (list 2 1 3)) 2)
(check-expect (avg-price (list 2 3 1)) 2)
(check-expect (avg-price (list 1 2 3 4)) 2.5)


;; Function elim-exp

;; Signature and Purpose:
;; elim-exp mp lotp -> list-of-numbers
;; Purpose: (elim-exp mp lotp) produces a list of all prices in lotp that are below or equal to mp

;; Examples:
;; (elim-exp 2 (list )) = (list )
;; (elim-exp 2 (list 1)) = (list 1)
;; (elim-exp 2 (list 1 2)) = (list 1 2)
;; (elim-exp 2 (list 2 1)) = (list 2 1)
;; (elim-exp 2 (list 1 2 3)) = (list 1 2)
;; (elim-exp 2 (list 2 1 3)) = (list 2 1)
;; (elim-exp 2 (list 2 3 1)) = (list 2 1)
;; (elim-exp 2 (list 1 2 3 4)) = (list 1 2)
;; (elim-exp 1.0 (list 2.95 .95 1.0 5)) = (list .95 1.0)
;; (elim-exp 1.0 (list 3.9 0.5 1.2 0.45)) = (list 0.5 0.45)

#| Template Instantiation for the elim-exp function:
(define (elim-exp mp lotp)
  (cond
    [(empty? lotp) ...]
    [(> (first lotp) mp) (... elim-exp mp (rest lotp) ...)]
    [else (... (first lotp) (elim-exp mp (rest lotp)) ...)]))
|#

;; Code:
(define (elim-exp mp lotp)
  (cond
    [(empty? lotp) lotp]
    [(> (first lotp) mp) (elim-exp mp (rest lotp))]
    [else (append (list (first lotp)) (elim-exp mp (rest lotp)))]))

; Tests:
(check-expect (elim-exp 2 (list )) (list ))
(check-expect (elim-exp 2 (list 1)) (list 1))
(check-expect (elim-exp 2 (list 1 2)) (list 1 2))
(check-expect (elim-exp 2 (list 2 1)) (list 2 1))
(check-expect (elim-exp 2 (list 1 2 3)) (list 1 2))
(check-expect (elim-exp 2 (list 2 1 3)) (list 2 1))
(check-expect (elim-exp 2 (list 2 3 1)) (list 2 1))
(check-expect (elim-exp 2 (list 1 2 3 4)) (list 1 2))
(check-expect (elim-exp 1.0 (list 2.95 .95 1.0 5)) (list .95 1.0))
(check-expect (elim-exp 1.0 (list 3.9 0.5 1.2 0.45)) (list 0.5 0.45))


;; Function delete

;; Signature and Purpose:
;; delete ty lon -> list-of-symbols
;; Purpose: (delete ty lon) produces a list of names that contains all components of lon with the exception of ty

;; Examples:
;; (delete 'b (list )) = (list )
;; (delete 'b (list 'a)) = (list 'a)
;; (delete 'b (list 'a 'b)) = (list 'a)
;; (delete 'b (list 'b 'a)) = (list 'a)
;; (delete 'b (list 'a 'b 'c)) = (list 'a 'c)
;; (delete 'b (list 'b 'a 'c)) = (list 'a 'c)
;; (delete 'b (list 'b 'c 'a)) = (list 'c 'a)
;; (delete 'b (list 'a 'b 'c 'd)) = (list 'a 'c 'd)
;; (delete 'robot (list 'robot 'doll 'dress)) = (list 'doll 'dress)
;; (delete 'robot (list 'robot2 'doll 'dress)) = (list 'robot2 'doll 'dress)
;; (delete 'robot2 (list 'robot 'doll 'dress)) = (list 'robot 'doll 'dress)


#| Template Instantiation for the delete function:
(define (delete ty lon)
  (cond
    [(empty? lon) ...]
    [(equal? (first lon) ty) (... delete ty (rest lon) ...)]
    [else (... (first lon) (delete ty (rest lon)) ...)]))
|#

;; Code:
(define (delete ty lon)
  (cond
    [(empty? lon) lon]
    [(equal? (first lon) ty) (delete ty (rest lon))]
    [else (append (list (first lon)) (delete ty (rest lon)))]))

; Tests:
(check-expect (delete 'b (list )) (list ))
(check-expect (delete 'b (list 'a)) (list 'a))
(check-expect (delete 'b (list 'a 'b)) (list 'a))
(check-expect (delete 'b (list 'b 'a)) (list 'a))
(check-expect (delete 'b (list 'a 'b 'c)) (list 'a 'c))
(check-expect (delete 'b (list 'b 'a 'c)) (list 'a 'c))
(check-expect (delete 'b (list 'b 'c 'a)) (list 'c 'a))
(check-expect (delete 'b (list 'a 'b 'c 'd)) (list 'a 'c 'd))
(check-expect (delete 'robot (list 'robot 'doll 'dress)) (list 'doll 'dress))
(check-expect (delete 'robot (list 'robot2 'doll 'dress)) (list 'robot2 'doll 'dress))
(check-expect (delete 'robot2 (list 'robot 'doll 'dress)) (list 'robot 'doll 'dress))


;; Function cons-all

;; Signature and Purpose:
;; cons-all sym lolos -> list-of-list-of-symbols
;; Purpose: (cons-all sym lolos) inserts symbol sym at the front of each list in lolos

;; Examples:
;; (cons-all 'b (list )) = (list )
;; (cons-all 'b (list (list 'a))) = (list (list 'b 'a))
;; (cons-all 'b (list (list 'a) (list 'b))) = (list (list 'b 'a) (list 'b 'b))
;; (cons-all 'b (list (list 'b) (list 'a))) = (list (list 'b 'b) (list 'b 'a))
;; (cons-all 'b (list (list 'a) (list 'b) (list 'c))) = (list (list 'b 'a) (list 'b 'b) (list 'b 'c))
;; (cons-all 'b (list (list 'b) (list 'a) (list 'c))) = (list (list 'b 'b) (list 'b 'a) (list 'b 'c))
;; (cons-all 'b (list (list 'b) (list 'c) (list 'a))) = (list (list 'b 'b) (list 'b 'c) (list 'b 'a))
;; (cons-all 'b (list (list 'a) (list 'b) (list 'c) (list 'd))) = (list (list 'b 'a) (list 'b 'b) (list 'b 'c) (list 'b 'd))
;; (cons-all 'robot (list (list 'robot) (list 'doll) (list 'dress))) = (list (list 'robot 'robot) (list 'robot 'doll) (list 'robot 'dress))
;; (cons-all 'robot (list (list 'robot2) (list 'doll) (list 'dress))) = (list (list 'robot 'robot2) (list 'robot 'doll) (list 'robot 'dress))
;; (cons-all 'robot2 (list (list 'robot) (list 'doll) (list 'dress))) = (list (list 'robot2 'robot) (list 'robot2 'doll) (list 'robot2 'dress)) 

#| Template Instantiation for the cons-all function:
(define (cons-all sym lolos)
  (cond
    [(empty? lolos) ...]
    [else (... sym (first lolos) (cons-all sym (rest lolos)) ...)]))
|#

;; Code:
(define (cons-all sym lolos)
  (cond
    [(empty? lolos) lolos]
    [else (append (list (append (list sym) (first lolos))) (cons-all sym (rest lolos)))]))

; Tests:
(check-expect (cons-all 'b (list )) (list ))
(check-expect (cons-all 'b (list (list ))) (list (list 'b)))
(check-expect (cons-all 'b (list (list 'a))) (list (list 'b 'a)))
(check-expect (cons-all 'b (list (list 'a) (list 'b))) (list (list 'b 'a) (list 'b 'b)))
(check-expect (cons-all 'b (list (list 'b) (list 'a))) (list (list 'b 'b) (list 'b 'a)))
(check-expect (cons-all 'b (list (list 'a) (list 'b) (list 'c))) (list (list 'b 'a) (list 'b 'b) (list 'b 'c)))
(check-expect (cons-all 'b (list (list 'b) (list 'a) (list 'c))) (list (list 'b 'b) (list 'b 'a) (list 'b 'c)))
(check-expect (cons-all 'b (list (list 'b) (list 'c) (list 'a))) (list (list 'b 'b) (list 'b 'c) (list 'b 'a)))
(check-expect (cons-all 'b (list (list 'a) (list 'b) (list 'c) (list 'd))) (list (list 'b 'a) (list 'b 'b) (list 'b 'c) (list 'b 'd)))
(check-expect (cons-all 'robot (list (list 'robot) (list 'doll) (list 'dress))) (list (list 'robot 'robot) (list 'robot 'doll) (list 'robot 'dress)))
(check-expect (cons-all 'robot (list (list 'robot2) (list 'doll) (list 'dress))) (list (list 'robot 'robot2) (list 'robot 'doll) (list 'robot 'dress)))
(check-expect (cons-all 'robot2 (list (list 'robot) (list 'doll) (list 'dress))) (list (list 'robot2 'robot) (list 'robot2 'doll) (list 'robot2 'dress)))
(check-expect (cons-all 'a (list (list 'c) (list 'o) (list 'm) (list 'p))) (list (list 'a 'c) (list 'a 'o) (list 'a 'm) (list 'a 'p)))


;; Function power

;; Signature and Purpose:
;; power los -> list-of-list-of-symbols
;; Purpose: (power los) produces a list of list of symbols representing the power set (set of all subsets) of los

;; Examples:
;; (power (list )) = (list (list ))
;; (power (list 'a)) = (list (list 'a) (list ))
;; (power (list 'a 'b)) = (list (list 'a 'b) (list 'a) (list 'b) (list ))
;; (power (list 'b 'a)) = (list (list 'b 'a) (list 'b) (list 'a) (list ))
;; (power (list 'a 'b 'c)) = (list (list 'a 'b 'c) (list 'a 'b) (list 'a 'c) (list 'a) (list 'b 'c) (list 'b) (list 'c) (list ))
;; (power (list 'b 'a 'c)) = (list (list 'b 'a 'c) (list 'b 'a) (list 'b 'c) (list 'b) (list 'a 'c) (list 'a) (list 'c) (list ))
;; (power (list 'b 'c 'a)) = (list (list 'b 'c 'a) (list 'b 'c) (list 'b 'a) (list 'b) (list 'c 'a) (list 'c) (list 'a) (list ))

#| Template Instantiation for the power function:
(define (power los)
  (cond
    [(empty? los) ...]
    [else (... (cons-all (first los) (power (rest  los))) (power (rest  los)) ...)]))
|#

;; Code:
(define (power los)
  (cond
    [(empty? los) (list los)]
    [else (append (cons-all (first los) (power (rest  los))) (power (rest  los)))]))

; Tests:
(check-expect (power (list )) (list (list )))
(check-expect (power (list 'a)) (list (list 'a) (list )))
(check-expect (power (list 'a 'b)) (list (list 'a 'b) (list 'a) (list 'b) (list )))
(check-expect (power (list 'b 'a)) (list (list 'b 'a) (list 'b) (list 'a) (list )))
(check-expect (power (list 'a 'b 'c)) (list (list 'a 'b 'c) (list 'a 'b) (list 'a 'c) (list 'a) (list 'b 'c) (list 'b) (list 'c) (list )))
(check-expect (power (list 'b 'a 'c)) (list (list 'b 'a 'c) (list 'b 'a) (list 'b 'c) (list 'b) (list 'a 'c) (list 'a) (list 'c) (list )))
(check-expect (power (list 'b 'c 'a)) (list (list 'b 'c 'a) (list 'b 'c) (list 'b 'a) (list 'b) (list 'c 'a) (list 'c) (list 'a) (list )))
