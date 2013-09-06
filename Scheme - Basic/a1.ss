(module a1 scheme
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Swap the first and third element in list lst if it has a size of 3 or more, otherwise just return the list. 
  (define swap13 
    (lambda (lst) 
      ;; Check that length of list is greater than 3, then construct a new list with the 3rd elem of list first, followed by 
      ;; 2nd, followed by 1st, and then append everything else after. 
      (cond 
        ((not (list? lst))
         (list lst)
         )
        ((> (length lst) 3) 
             (cons (third lst) (cons (second lst) (cons (first lst) (cdddr lst))))
        )
        ((= (length lst) 3) 
             (list (third lst) (second lst) (first lst))
        )
        (else 
         lst
         )
        )
      )
    )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; helper procedure for deep-swap13
  ;; base case when list is null, if the first element of the list is a list, then call deep-swap on it
  ;; otherwise append it to the recursive call. 
  (define deep-swap-helper
    (lambda (lst)
      (cond ((null? lst) lst)
        (else
          (cond
            ((list? (first lst))
              (append (list (deep-swap13 (first lst))) (deep-swap-helper (rest lst)))
             )
             (else
               (append (list (first lst)) (deep-swap-helper (rest lst)))
              )
             )
          )
        )
      )
    )
  
  ;; Given a list lst, recursively swap the first and third element in each of its layers. 
  (define deep-swap13
    (lambda (lst)
      (deep-swap-helper (swap13 lst))
      )
    )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Check if 'a' is a member of the first layer of the list, return true if it is, false otherwise
  (define mem?
    (lambda (a lst)
      (cond 
      ;; Base condition if list is empty, return true if 'a is found, 
      ;; otherwise recursively call function on a sublist. 
      ((null? lst) #f)
      ((equal? (first lst) a) #t)
      (else 
       (mem? a (rest lst))
       )
      )
    )
   )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Given member a, return true if it is a member of the list, return false otherwise.
  (define deep-mem?
    (lambda (a lst)
      ;; Very similar to mem? procedure, however if a sublist is found, 
      ;; a recursive call is called on this list. 
      (cond
        ((null? lst) #f)
        ((equal? (first lst) a) #t)
        ((list? (first lst))
         ;;handle the case where we need to keep track of the list after the recursive call.
         (deep-mem? a (append (first lst) (rest lst)))
         )
        (else
         (deep-mem? a (rest lst))
        )
       )
      )
     )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;              
  ;; Helper function for is-prime? which recursively checks if an input is a prime number or not 
  ;; using the brute force algorithm.
  (define is-prime-helper
    (lambda (n i)
      ;;Keep dividing n by i and check if it divides by anything. If i hits 1, then n is prime. 
      (cond
        ;;prime
        ((equal? i 1) #t)
        (else
         (cond
           ;;not prime
           ((zero? (modulo n i)) #f)
           (else (is-prime-helper n (- i 1)))
           )
         )
        )
      )
    )
  
    ;; Helper function for prime-factors that returns a list of all the prime factors of n
  ;; given a divisor. 
  (define prime-factors-helper
    (lambda (lst n divisor)
      (cond
        ;;we're done when n = 1
        ((equal? n 1) lst)
        ;;if divisor isn't prime, then we'll increment it by 1 and check if it's prime
        ;;on the next iteration.
        ((equal? (is-prime? divisor) #f)
         (prime-factors-helper lst n (+ divisor 1))
         )
        ;; if divisor divides n, then that means it's a prime factor
        ;; and we have to add it to the list, then recursively call the function
        ;; on n/divisor
        ((zero? (modulo n divisor))
         (prime-factors-helper (append lst (list divisor)) (/ n divisor) divisor)
         )
        ;;otherwise we'll call it incrementing divisor by 1. 
        (else
         (prime-factors-helper lst n (+ divisor 1))
         )
        )
      )
    )
  
  ;; Given a number n, return true if it is prime, false otherwise.
  (define is-prime?
    (lambda (n)
      (is-prime-helper n (ceiling (/ n 2)))
     )
   )
  
  
  ;; Given an integer n, return a list of the prime factors of that number
  (define prime-factors
    (lambda (n)
      (prime-factors-helper '() n 2)
      )
    )
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Helper for count-distinct-factors
  ;; Keep track of the value we just checked using the temp variable, on the next recursive call, if the 
  ;; first element of the list is equal to temp, then we skip that number and move on to the rest, otherwise
  ;; we increment count and update temp. 
  ;; Return count on the base case when the length of the list is 1. 
  (define count-distinct-factors-helper
    (lambda (a temp count lst)
      (cond
        ;;base case if list has one element
        ((equal? (length lst) 1)
         (cond
           ((equal? temp (first lst))
            count
            )
         (else
          (+ count 1)
          )
         )
        )
        ;;check if we already counted that number
        ((equal? a temp)
         (count-distinct-factors-helper (second lst) temp count (rest lst)))
        ;;check if the first element is in the list
        ((mem? a lst)
         ;;store temp value
         (define temp (first lst))
         (count-distinct-factors-helper (second lst) temp (+ count 1) (rest lst)))
        )
      )
    )
  
  ;; Given a number n, return the count of the distinct prime numbers in the list.
  (define count-distinct-factors
    (lambda (n)
      (define prime (prime-factors n))
      (cond 
        ;; base case 1
        ((null? prime) 0)
        (else
          (count-distinct-factors-helper (first prime) 0 0 prime)
          )
        )
      )
    )
        

  (provide swap13 deep-swap13 mem? deep-mem? prime-factors count-distinct-factors)
  )

