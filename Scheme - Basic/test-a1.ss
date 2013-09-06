#lang scheme

;; A starter tester for a1. It is NOT a sufficient
;; tester in its current version -- only a sanity check.

(require test-engine/scheme-tests)

(require "a1.ss")

;;;;; Test procedures in a1 ;;;;;

;;;;; Test swap13 ;;;;;

;;;;; Test empty list swap ;;;;;;
(check-expect (swap13 '()) '())

;;;;; Test swap with less than 3 items ;;;;;
(check-expect (swap13 '(3)) '(3))
(check-expect (swap13 '(1 3)) '(1 3))

;;;;; Test swap with exactly 3 items
(check-expect (swap13 '(1 2 3)) '(3 2 1))

;;;;; Test swap with more than 3 items
(check-expect (swap13 '(1 2 3 4)) '(3 2 1 4))

;;;;; Test swap with nested lists
(check-expect (swap13 '(1 2 (3 4))) '((3 4) 2 1))
(check-expect (swap13 '(d b (a e f) c)) '((a e f) b d c))

;;;;; Test deep-swap13 ;;;;;

(check-expect (deep-swap13 '()) '())
(check-expect (deep-swap13 '(1)) '(1))
(check-expect (deep-swap13 '(1 2)) '(1 2))

;;;;; 3 items or more ;;;;;;
(check-expect (deep-swap13 '(1 2 3)) '(3 2 1))
(check-expect (deep-swap13 '(1 2 3 4)) '(3 2 1 4))

;;;;; Check for nested swaps
(check-expect (deep-swap13 '(d b (a e f) (1 5 c))) '((f e a) b d (c 5 1)))
(check-expect (deep-swap13 '(d b (a (e h k) f) (1 5 c))) '((f (k h e) a) b d (c 5 1)))
(check-expect (deep-swap13 '(d b (a e f) (((8 9 10) 2 1) 5 c))) '((f e a) b d (c 5 (1 2 (10 9 8)))))

;;;;; Test mem? ;;;;;

;;;;; not a member ;;;;;
(check-expect (mem? 'a '()) false)
(check-expect (mem? 'a '(b c)) false)
(check-expect (mem? 'a '(d b c (a e f))) false)

;;;;; when a member ;;;;;
(check-expect (mem? 'a '(a)) true)
(check-expect (mem? 'a '(a b c)) true)
(check-expect (mem? 1 '(1 2 3 (4 5 6))) true)

;;;;; Test deep-mem? ;;;;;

;;;;; not a member ;;;;;
(check-expect (deep-mem? 'a '()) false)
(check-expect (deep-mem? 'a '(b c)) false)
;;;;; nested ;;;;;
(check-expect (deep-mem? 1 '(2 3 (4 5 6))) false)

;;;;; is a member ;;;;;;
(check-expect (deep-mem? 'a '(a)) true)
(check-expect (deep-mem? 'a '(a b c)) true)
;;;;; nested on one level or more ;;;;;
(check-expect (deep-mem? 'a '(d b c (a e f))) true)
(check-expect (deep-mem? 'a '(d b c ((h i a) e f))) true)
(check-expect (deep-mem? 'a '(d b c ((l m n (i a)) e f))) true)
;;;;; a occurs after embedded list ;;;;;
(check-expect (deep-mem? 'a '(d b c (j e f) a)) true)
(check-expect (deep-mem? 'a '(() a)) true)

;;;;; Test prime-factors ;;;;;

;;;;; Test "base case" ;;;;;
(check-expect (prime-factors 1) '())

;;;;; Test with prime numbers ;;;;;
(check-expect (prime-factors 3) '(3))
(check-expect (prime-factors 7) '(7))
(check-expect (prime-factors 37) '(37))

;;;;; Test with composite numbers ;;;;;
(check-expect (prime-factors 9) '(3 3))
(check-expect (prime-factors 15) '(3 5))
(check-expect (prime-factors 210) '(2 3 5 7))
(check-expect (prime-factors 60) '(2 2 3 5))
(check-expect (prime-factors 64) '(2 2 2 2 2 2))
(check-expect (prime-factors 144) '(2 2 2 2 3 3))

;;;;; Same factors ;;;;;;
(check-expect (prime-factors 8) '(2 2 2))

;;;;; Test  count-distinct-factors ;;;;;

;;;;; Test "base case" ;;;;;
(check-expect (count-distinct-factors 1) 0)

;;;;; Test prime ;;;;;
(check-expect (count-distinct-factors 37) 1)

;;;;; Test composites with only 1 distinct factor ;;;;;
(check-expect (count-distinct-factors 9) 1)
(check-expect (count-distinct-factors 8) 1)

;;;;; Test composites with all distinct factors ;;;;;
(check-expect (count-distinct-factors 15) 2)
(check-expect (count-distinct-factors 210) 4)

;;;;; Test composites with factors that appear more than once ;;;;;
(check-expect (count-distinct-factors 60) 3)
(check-expect (count-distinct-factors 12) 2)

(test)

