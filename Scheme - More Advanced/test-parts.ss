#lang scheme

;; A starter tester for parts. It is NOT a sufficient
;; tester in its current version -- only a sanity check.

(require test-engine/scheme-tests)

(require "parts.ss")

;;;;; Test procedures in parts ;;;;;
(check-expect (COST 'p1) 200)
(check-expect (COST 'p4) 2)
(check-expect (COST 'p100) 0) 

(check-expect (SUBPARTS 'p6) '(p4 p5))
(check-expect (SUBPARTS 'p5) '())
(check-expect (SUBPARTS 'p100) '())

(check-expect (IS-PRIM? 'p10) false)
(check-expect (IS-PRIM? 'p9) true)
(check-expect (IS-PRIM? 'p100) false)

(check-expect (NOT-SUBPART? 'p1) true)
(check-expect (NOT-SUBPART? 'p2) false)
(check-expect (NOT-SUBPART? 'p100) true)

(check-expect (AFFORDLIST 70) '(p2 p3 p4 p5 p6 p7 p9))
(check-expect (AFFORDLIST 1) '())

(check-expect (PRIM-PARTS 'p1) '(p4 p5 p9))
(check-expect (PRIM-PARTS 'p2) '(p4))
(check-expect (PRIM-PARTS 'p4) '())
(check-expect (PRIM-PARTS 'p100) '())

(check-expect (CAN-BUILD? 'p1 '(p2 p3 p2 p3 p3)) true)
(check-expect (CAN-BUILD? 'p4 '()) true)
(check-expect (CAN-BUILD? 'p3 '(p5 p6 p6)) false)
(check-expect (CAN-BUILD? 'p2 '(p3 p4 p4 p4 p5)) true)
(check-expect (CAN-BUILD? 'p10 '(p4 p9 p7)) false)
(check-expect (CAN-BUILD? 'p1 '(p4 p4 p4 p4 p5 p5 p5 p6 p6 p6 p6 p6 p7 p7 p7 p7 p7)) false)

(check-expect (BUILD-LIST '(p2 p3 p3 p2 p4 p3 p4)) '(p1 p2))
(check-expect (BUILD-LIST '(p5 p5 p9)) '())
(check-expect (BUILD-LIST '(p3 p5 p6 p6 p9)) '(p8))
(check-expect (BUILD-LIST '()) '())
(check-expect (BUILD-LIST '(p3 p5 p6 p6 p7 p7 p7)) '(p3 p8))

(check-expect (ALL-COST '(p2 p4 p6)) 16)
(check-expect (ALL-COST '(p10 p100)) 90)
(check-expect (ALL-COST '(p100)) 0)
(check-expect (ALL-COST '()) 0)

(check-expect (ALL-PARTS '(p1 p2)) '(p2 p3 p4))
(check-expect (ALL-PARTS '(p1 p8)) '(p2 p6 p3))
(check-expect (ALL-PARTS '(p6 p100)) '(p4 p5))
(check-expect (ALL-PARTS '(p100)) '())
(check-expect (ALL-PARTS '()) '())

(check-expect (COST-OF-PARTS 'p1) 196)
(check-expect (COST-OF-PARTS 'p6) 6)
(check-expect (COST-OF-PARTS 'p4) 0)
(check-expect (COST-OF-PARTS 'p100) 0)

(test)
