;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname HW02) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;; COMP 544 HW #2
;; Dragana Grbic <dg76@rice.edu>

;; **Problem 1**

;; Data Definitions

;; Given
(define-struct BTM-node (key value left right))   ;; abbreviated name for BinaryTreeMap-node

;; A (BTM-of alpha) ;; abbreviated name for (BinaryTreeMap-of alpha) is either:
;; * empty, or
;; * (make-BTM-node key value left right) where
;;   * key is a number;
;;   * value has type alpha;
;;   * left and right are of type (BTM-of alpha)

;; A (BSTM-of alpha) (abbreviated name for (BinarySearchTreeMap-of alpha) is a (BTM-of alpha) that is either:
;; * empty, or
;; * a BTM-node (make-BTM-node k v l r) where every key in l < k and every key in r > k (implying key values are unique)

;; Examples 
;; <##your sample BSTMs go here##>
(define binary-tree-1 (make-BTM-node 3 'A
                                     (make-BTM-node 2 'B
                                                    (make-BTM-node 1 'C
                                                                   empty
                                                                   empty)
                                                    empty)
                                     (make-BTM-node 4 'D
                                                    empty
                                                    (make-BTM-node 5 'E
                                                                   empty
                                                                   empty))))

(define binary-tree-2 (make-BTM-node 5 '5
             (make-BTM-node 4 '4
                          (make-BTM-node 3 '3
                                         (make-BTM-node 2 '2
                                                        empty
                                                        empty)
                                         empty)
                          empty)
             (make-BTM-node 6 '6
                          empty
                          (make-BTM-node 7 '7
                                         empty
                                         (make-BTM-node 8 '8
                                                        empty
                                                        empty)))))

(define binary-tree-3 empty)

;; Generic Template for any function f with primary argument abtm of type BTM

#|
 (define (f ... abstm ...)
   (cond [(empty? abstm) ...]
         [(BTM-node? bstm)
               ... (BTM-node-key abstm)
               ... (BTM-node-value abstm)
               ... (f ... (BTM-node-left abstm) ...) 
               ... (f ... (BTM-node-right abstm) ...) 
               ... ]))
|#

;; getBSTM: number (BSTM-of alpha) -> symbol
;; Contract: (getBSTM n abstm) returns the symbol s in the BTM-node matching key value n within abstm if such a BTM-node exists and empty otherwise

;; Examples 
;; <##your tests of getBSTM go here##>

;; NOTE: definitions of binary-tree-1 and binary-tree-2 are above
;; (check-expect (getBSTM 1 binary-tree-1) 'C)
;; (check-expect (getBSTM 2 binary-tree-1) 'B)
;; (check-expect (getBSTM 3 binary-tree-1) 'A)
;; (check-expect (getBSTM 4 binary-tree-1) 'D)
;; (check-expect (getBSTM 5 binary-tree-1) 'E)
;; (check-expect (getBSTM 6 binary-tree-1) empty)

;; (check-expect (getBSTM 1 binary-tree-2) empty)
;; (check-expect (getBSTM 2 binary-tree-2) '2)
;; (check-expect (getBSTM 3 binary-tree-2) '3)
;; (check-expect (getBSTM 4 binary-tree-2) '4)
;; (check-expect (getBSTM 5 binary-tree-2) '5)
;; (check-expect (getBSTM 6 binary-tree-2) '6)
;; (check-expect (getBSTM 7 binary-tree-2) '7)
;; (check-expect (getBSTM 8 binary-tree-2) '8)
;; (check-expect (getBSTM 9 binary-tree-2) empty)

;; (check-expect (getBSTM 1 binary-tree-3) empty)

;; Template Instantiation
#|
<##your template instantiation for getBSTM goes here##>
(define (getBSTM key tree)
  (
   cond
    [(empty? tree) ...]
    [(= (BTM-node-key tree) key) (...)]
    [(< (BTM-node-key tree) key) (... (BTM-node-right tree) ...)]
    [(> (BTM-node-key tree) key) (... (BTM-node-left tree) ...)]
   )
  )

|#

;; Code
;; <##your code for getBSTM goes here##> (approximately 5 lines)
(define (getBSTM key tree)
  (
   cond
    [(empty? tree) empty]
    [(= (BTM-node-key tree) key) (BTM-node-value tree)]
    [(< (BTM-node-key tree) key) (getBSTM key (BTM-node-right tree))]
    [(> (BTM-node-key tree) key) (getBSTM key (BTM-node-left tree))]
   )
  )

;; Tests
(check-expect (getBSTM 1 binary-tree-1) 'C)
(check-expect (getBSTM 2 binary-tree-1) 'B)
(check-expect (getBSTM 3 binary-tree-1) 'A)
(check-expect (getBSTM 4 binary-tree-1) 'D)
(check-expect (getBSTM 5 binary-tree-1) 'E)
(check-expect (getBSTM 6 binary-tree-1) empty)

(check-expect (getBSTM 1 binary-tree-2) empty)
(check-expect (getBSTM 2 binary-tree-2) '2)
(check-expect (getBSTM 3 binary-tree-2) '3)
(check-expect (getBSTM 4 binary-tree-2) '4)
(check-expect (getBSTM 5 binary-tree-2) '5)
(check-expect (getBSTM 6 binary-tree-2) '6)
(check-expect (getBSTM 7 binary-tree-2) '7)
(check-expect (getBSTM 8 binary-tree-2) '8)
(check-expect (getBSTM 9 binary-tree-2) empty)

(check-expect (getBSTM 1 binary-tree-3) empty)

;; Complexity analysis: searching trees vs. searching lists
;;<##your brief (a few lines) discussion of running time for getBSTM vs the corresponding search if the map is represented as a linear list goes here##>
;; when we are searching an element in a binary tree, the worst case when searching an element with a key <KEY> is O(logN), where N is the total number of elements/nodes in the tree
;; that is because the worst case happens if the element/node we are searching is at the bottom of the tree (leaf node): we have to search through the entire depth of the tree, and the depth is O(logN)
;; when we are searching an element in a list, the worst case when searching an element with a key <KEY> is O(N), where N is the total number of elements in the list
;; that is because the worst case happens if the element we are searching is at the end of the list: we have to search through the entire length of the list, and the length is O(N)


;; **Problem 2**
;; In this problem, we assume the programmer and the reader are very familiar with the inductive type (list-of alpha), so those associated data definition, examples, and
;; corresponding natural recursion template are omitted here.

;; For the sake of simplicity, we will represent an ordered pair (a,b) of type (alpha,beta) as two element list (list a b).  We will call such a pair, a (pair-of alpha beta).

;; cross: (list-of alpha) (list-of beta) -> (list-of (pair-of alpha beta))
;; Contract: given a (list-of alpha) nl and a (list-of beta) sl, (cross nl sl) returns a list of all possible pairs (n, s) where n is a member of nl and s is a member of sl.
;; Examples:
;; (check-expect (cross '(1 2) '(a b c)) '((1 a) (1 b) (1 c) (2 a) (2 b) (2 c)))
;; (check-expect (cross '(1 1) '(a b c)) '((1 a) (1 b) (1 c) (1 a) (1 b) (1 c)))
;; <##you need to include more examples, sufficient to cover your code including base cases and the simple inductive constructions.##>
;; (check-expect (cross (list ) (list )) (list ))
;; (check-expect (cross (list ) (list 'a)) (list ))
;; (check-expect (cross (list 1) (list )) (list ))
;; (check-expect (cross (list 1) (list 'a)) (list (list 1 'a)))
;; (check-expect (cross (list 1) (list 'a 'b)) (list (list 1 'a) (list 1 'b)))
;; (check-expect (cross (list 1) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c)))
;; (check-expect (cross (list 1 2) (list 'a)) (list (list 1 'a) (list 2 'a)))
;; (check-expect (cross (list 1 2) (list 'a 'b)) (list (list 1 'a) (list 1 'b) (list 2 'a) (list 2 'b)))
;; (check-expect (cross (list 1 2) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c) (list 2 'a) (list 2 'b) (list 2 'c)))
;; (check-expect (cross (list 1 2 3) (list 'a)) (list (list 1 'a) (list 2 'a) (list 3 'a)))
;; (check-expect (cross (list 1 2 3) (list 'a 'b)) (list (list 1 'a) (list 1 'b) (list 2 'a) (list 2 'b) (list 3 'a) (list 3 'b)))
;; (check-expect (cross (list 1 2 3) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c) (list 2 'a) (list 2 'b) (list 2 'c) (list 3 'a) (list 3 'b) (list 3 'c)))
;; (check-expect (cross '(1 2) '(a b c)) '((1 a) (1 b) (1 c) (2 a) (2 b) (2 c)))
;; (check-expect (cross '(1 1) '(a b c)) '((1 a) (1 b) (1 c) (1 a) (1 b) (1 c)))

;; Template Instantiations for cross
;; Hints:
;; 1. The visible function cross performs natural recursion on one argument (say nl).  Introduce a cross-help function that performs natural recursion on the other argument (say sl).
;; 2. In developing your code, you may want to write and test cross-help first because it can be tested by itself while cross cannot.
;; 3. After giving the template instantiation for cross, show your development of cross-help including type [declaration], contract, and template instantiation.  You may
;;    omit examples since they will be generated by your top level tests if your top-level coverage is good.

;; Template instantiation for cross 
#|
<##your template instantiation for cross which invokes cross-help goes here##>
(define (cross list-a list-b)
  (cond
    [(empty? list-a) ...]
    [else (... (cross-help (first list-a) list-b)... ...(cross (rest list-a) list-b))... ]
    )
  )
|#             

;; <##your signature [declaration], contract, and template instantiation for cross-help all go here; examples for cross-help are optional##>
;; cross-help: (alpha) (list-of beta) -> (list-of (pair-of alpha beta))
;; Contract: given a alpha nl and a (list-of beta) sl, (cross-help nl sl) returns a list of all pairs (nl, s) where s is a member of sl.

#|
(define (cross-help item list-of-items)
  (cond
    [(empty? list-of-items) ...]
    [else ( ...item... ...(first list-of-items)... ...(cross-help item (rest list-of-items))... )]
    )
  )
|#

;; Code for cross and cross-help
;; Hint: Aim for simplicity; do not worry about using append to concatenate lists.
;;<##Your code for cross and any help functions goes here.##>
(define (cross-help item list-of-items)
  (cond
    [(empty? list-of-items) empty]
    [else (append (list (append (list item) (list (first list-of-items)))) (cross-help item (rest list-of-items)))]
    )
  )

(define (cross list-a list-b)
  (cond
    [(empty? list-a) empty]
    [else (append (cross-help (first list-a) list-b) (cross (rest list-a) list-b))]
    )
  )

;; Tests
(check-expect (cross (list ) (list )) (list ))
(check-expect (cross (list ) (list 'a)) (list ))
(check-expect (cross (list 1) (list )) (list ))
(check-expect (cross (list 1) (list 'a)) (list (list 1 'a)))
(check-expect (cross (list 1) (list 'a 'b)) (list (list 1 'a) (list 1 'b)))
(check-expect (cross (list 1) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c)))
(check-expect (cross (list 1 2) (list 'a)) (list (list 1 'a) (list 2 'a)))
(check-expect (cross (list 1 2) (list 'a 'b)) (list (list 1 'a) (list 1 'b) (list 2 'a) (list 2 'b)))
(check-expect (cross (list 1 2) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c) (list 2 'a) (list 2 'b) (list 2 'c)))
(check-expect (cross (list 1 2 3) (list 'a)) (list (list 1 'a) (list 2 'a) (list 3 'a)))
(check-expect (cross (list 1 2 3) (list 'a 'b)) (list (list 1 'a) (list 1 'b) (list 2 'a) (list 2 'b) (list 3 'a) (list 3 'b)))
(check-expect (cross (list 1 2 3) (list 'a 'b 'c)) (list (list 1 'a) (list 1 'b) (list 1 'c) (list 2 'a) (list 2 'b) (list 2 'c) (list 3 'a) (list 3 'b) (list 3 'c)))
(check-expect (cross '(1 2) '(a b c)) '((1 a) (1 b) (1 c) (2 a) (2 b) (2 c)))
(check-expect (cross '(1 1) '(a b c)) '((1 a) (1 b) (1 c) (1 a) (1 b) (1 c)))


;; Problem 3
;; As in Problem 2, we assume the programmer and the reader are very familiar with the inductive type (list-of alpha).  Hence, the associated data definition, examples, and
;; corresponding natural recursion template are omitted here.  The function that you must write below is discussed in detail in Section 17.6 of the book.  But we expect you to develop
;; a slightly better solution given the following guidance.

;; In your definition of the merge function, use simple structural case-splitting on both list arguments WITHOUT ANY RECURSION
;; in the body of merge. The second case split is nested inside one arm of the first case split; the ordering of the argument queries does not matter.  For the case where the result
;; cannot be immediately constructed without help (both arguments are non-empty), your program should delegate the remainder of the computation to a help function merge-help.  In contrast
;; to the code for the merge function, the code for merge-help function is recursive but its argument types are not identical.

;; One argument is a non-empty ascending (list-of number) and the other is simply an
;; ascending (list-of number).  The template for merge-help case splits on whether the possibly empty list is empty or non-empty and performs quasi-structural recursion (it may
;; swap arguments (technically deviating from the structural recursion template), but the sum of the length of the two arguments strictly decreases in every call, implying termination).

;; We will use the prefix "ascending" in front a (list-of number) parameter in a type to indicate that the parameter must be bound to an ascending [technically
;; non-descending] (list-of number). We will similarly use the prefix "non-empty" in front of a (list-of number) parameter to indicate that the parameter must be bound
;; to a non-empty (list-of number).

;; merge; [ascending] (list-of number)  [ascending] (list-of number) -> [ascending] (list-of number)
;; Contract: given two ascending (list-of number)s nl1 and nl2, (merge nl1 nl2) returns the list containing all elements in both lists in ascending order
;; Examples
;; <##your examples for merge go here##>
;; (check-expect (merge (list ) (list )) (list ))
;; (check-expect (merge (list 1) (list )) (list 1))
;; (check-expect (merge (list ) (list 1)) (list 1))
;; (check-expect (merge (list 1) (list 1)) (list 1 1))
;; (check-expect (merge (list 1) (list 2)) (list 1 2))
;; (check-expect (merge (list 2) (list 1)) (list 1 2))
;; (check-expect (merge (list 1 3 5 7 9) (list 2 4 6 8)) (list 1 2 3 4 5 6 7 8 9))
;; (check-expect (merge (list 1 5 9 9) (list 2 3 4 6 6 7 7 8 8)) (list 1 2 3 4 5 6 6 7 7 8 8 9 9))

;; Template Instantiation for merge
;; <##your template instantiation for merge invoking merge-help goes here##>

#|
(define (merge list-a list-b)

  (cond
    [(empty? list-a) ...]
    [(empty? list-b) ...]
    [else (merge-help list-a list-b)]
    )
  )
|#

;; <##your signature [declaration], contract, and template instantiation, and examples for merge-help go here ##> 
;; merge-help: (list-of number) (list-of number) -> (list-of number)
;; Contract: given a sorted (list-of number) list-a and a sorted non-empty (list-of number) list-b, (merge-help list-a list-b) returns a sorted (list-of number) list-c that contains all elements from list-a and list-b.

#|
(define (merge-help list-a list-b-non-empty)

  (cond
    [(empty? list-a) ...]
    [(< (first list-a) (first list-b-non-empty)) (... (first list-a) ... ...(merge-help (rest list-a) list-b-non-empty)... )]
    [else (... (first list-b-non-empty)... ...(merge-help (rest list-b-non-empty) list-a)... )]
    )

  )
|#

;; (check-expect (merge-help (list ) (list 1)) (list 1))
;; (check-expect (merge-help (list 1) (list 1)) (list 1 1))
;; (check-expect (merge-help (list 1) (list 2)) (list 1 2))
;; (check-expect (merge-help (list 2) (list 1)) (list 1 2))
;; (check-expect (merge-help (list 1 3 5 7 9) (list 2 4 6 8)) (list 1 2 3 4 5 6 7 8 9))
;; (check-expect (merge-help (list 1 5 9 9) (list 2 3 4 6 6 7 7 8 8)) (list 1 2 3 4 5 6 6 7 7 8 8 9 9))

;; Code
;;<## your code for merge-help and merge goes here; merge-help first ##>
(define (merge-help list-a list-b-non-empty)

  (cond
    [(empty? list-a) list-b-non-empty]
    [(< (first list-a) (first list-b-non-empty)) (append (list (first list-a)) (merge-help (rest list-a) list-b-non-empty))]
    [else (append (list (first list-b-non-empty)) (merge-help (rest list-b-non-empty) list-a))]
    )

  )

(define (merge list-a list-b)

  (cond
    [(empty? list-a) list-b]
    [(empty? list-b) list-a]
    [else (merge-help list-a list-b)]
    )
  )

;; Tests
(check-expect (merge-help (list ) (list 1)) (list 1))
(check-expect (merge-help (list 1) (list 1)) (list 1 1))
(check-expect (merge-help (list 1) (list 2)) (list 1 2))
(check-expect (merge-help (list 2) (list 1)) (list 1 2))
(check-expect (merge-help (list 1 3 5 7 9) (list 2 4 6 8)) (list 1 2 3 4 5 6 7 8 9))
(check-expect (merge-help (list 1 5 9 9) (list 2 3 4 6 6 7 7 8 8)) (list 1 2 3 4 5 6 6 7 7 8 8 9 9))

(check-expect (merge (list ) (list )) (list ))
(check-expect (merge (list 1) (list )) (list 1))
(check-expect (merge (list ) (list 1)) (list 1))
(check-expect (merge (list 1) (list 1)) (list 1 1))
(check-expect (merge (list 1) (list 2)) (list 1 2))
(check-expect (merge (list 2) (list 1)) (list 1 2))
(check-expect (merge (list 1 3 5 7 9) (list 2 4 6 8)) (list 1 2 3 4 5 6 7 8 9))
(check-expect (merge (list 1 5 9 9) (list 2 3 4 6 6 7 7 8 8)) (list 1 2 3 4 5 6 6 7 7 8 8 9 9))


;; Problem 4
;; The Fibonacci function fib is defined by the recursion equation:
;;   fib(n) = fib(n-1) + fib(n-2) for n > 1
;; where fib(0) = fib(1) = 1.
;; The following Racket program computes fib(n) using this definition:

(define (fib n) (if (< n 2) 1 (+ (fib (- n 1)) (fib (- n 2)))))

;; <##Your signature declaration, contract, examples, and template instantation for fastFib go here.##>
;; fastFib nat -> nat
;; Contract: (fastFib n) returns (fib n) using accumulative recursion

#|
(define (fastFib n)
  (cond
    [(= n 0) ...]
    [(= n 1) ...]
    [else (fibHelp (- n 2) ...)]
    )
  )
|#

;; (check-expect (fastFib 0) 1)
;; (check-expect (fastFib 1) 1)
;; (check-expect (fastFib 2) 2)
;; (check-expect (fastFib 3) 3)
;; (check-expect (fastFib 4) 5)
;; (check-expect (fastFib 5) 8)
;; (check-expect (fastFib 6) 13)
;; (check-expect (fastFib 7) 21)
;; (check-expect (fastFib 8) 34)
;; (check-expect (fastFib 9) 55)

;; Hints;
;; 0. The fibHelp function essentially takes two accumulators that are consecutive descending Fibonacci numbers and returns the Fibonacci number k+1 positions beyond the index
;;    of the first number. You could write essentially the same code in an imperative language as a loop. 
;; 1. Your template instantiation for fastFib will be trivial because it will delegate essentially all of the computation to the help function fibHelp with the
;;    following description:

;; fibHelp: nat nat nat -> nat
;; Contract: (fibHelp k fn-k-1 fn-k-2) returns (fib n) provided that fn-k-1 = (fib (- n k 1)), fn-k-2 = (fib (- n k 2))
;; Note: in Racket (- n k i) returns (n-k)-i
;; Examples (included here to show you how fastFib works)
;; (check-expect (fibHelp 0 1 1) 2)
;; (check-expect (fibHelp 0 2 1) 3)
;; (check-expect (fibHelp 1 (fib 9) (fib 8)) (fib 11))


;;<## you obviously need to add more examples ##>
;; (check-expect (fibHelp 0 (fib 1) (fib 0)) (fib 2))
;; (check-expect (fibHelp 1 (fib 1) (fib 0)) (fib 3))
;; (check-expect (fibHelp 2 (fib 1) (fib 0)) (fib 4))
;; (check-expect (fibHelp 3 (fib 1) (fib 0)) (fib 5))
;; (check-expect (fibHelp 4 (fib 1) (fib 0)) (fib 6))
;; (check-expect (fibHelp 5 (fib 1) (fib 0)) (fib 7))
;; (check-expect (fibHelp 6 (fib 1) (fib 0)) (fib 8))
;; (check-expect (fibHelp 7 (fib 1) (fib 0)) (fib 9))
;; 2. You need to fully develop fibHelp as a Racket function; some of what you need appears above in the description of fibHelp including template instantiation.

#|
Template Instantiation
(define (fibHelp k fn-k-1 fn-k-2)
  (cond
    [(= k 0) ...]
    [else (fibHelp ...k... (... fn-k-1 fn-k-2 ...) ...fn-k-1... )]
    )
  )
|#

;; Code
;; <## your code for fastFib and fibHelp goes here, fibHelp first ##>
(define (fibHelp k fn-k-1 fn-k-2)
  (cond
    [(= k 0) (+ fn-k-1 fn-k-2)]
    [else (fibHelp (- k 1) (+ fn-k-1 fn-k-2) fn-k-1)]
    )
  )


(define (fastFib n)
  (cond
    [(= n 0) 1]
    [(= n 1) 1]
    [else (fibHelp (- n 2) 1 1)]
    )
  )

;; Tests
(check-expect (fibHelp 0 (fib 1) (fib 0)) (fib 2))
(check-expect (fibHelp 1 (fib 1) (fib 0)) (fib 3))
(check-expect (fibHelp 2 (fib 1) (fib 0)) (fib 4))
(check-expect (fibHelp 3 (fib 1) (fib 0)) (fib 5))
(check-expect (fibHelp 4 (fib 1) (fib 0)) (fib 6))
(check-expect (fibHelp 5 (fib 1) (fib 0)) (fib 7))
(check-expect (fibHelp 6 (fib 1) (fib 0)) (fib 8))
(check-expect (fibHelp 7 (fib 1) (fib 0)) (fib 9))

(check-expect (fib 0) (fastFib 0))
(check-expect (fib 1) (fastFib 1))
(check-expect (fib 2) (fastFib 2))
(check-expect (fib 3) (fastFib 3))
(check-expect (fib 4) (fastFib 4))
(check-expect (fib 5) (fastFib 5))
(check-expect (fib 6) (fastFib 6))
(check-expect (fib 7) (fastFib 7))
(check-expect (fib 8) (fastFib 8))
(check-expect (fib 9) (fastFib 9))

(check-expect (fastFib 0) 1)
(check-expect (fastFib 1) 1)
(check-expect (fastFib 2) 2)
(check-expect (fastFib 3) 3)
(check-expect (fastFib 4) 5)
(check-expect (fastFib 5) 8)
(check-expect (fastFib 6) 13)
(check-expect (fastFib 7) 21)
(check-expect (fastFib 8) 34)
(check-expect (fastFib 9) 55)


;; Problem 5 (Extra Credit 30 pts)
;; This problem is reasonably hard and time-consuming so if you are interested, don't tackle it until you have done the regular problem very thoroughly.  
