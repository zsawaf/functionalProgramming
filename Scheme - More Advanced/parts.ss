(module parts scheme

  ;;NOTE TO TA
  ;; I like to break down my problem to tiny small sub-problems. Hence I used a lot of helper procedures.
  ;; Personally I don't think your decision of seperating helper procedures and main procedures into two parts is a good idea
  ;; because you're going to get annoyed going up and down trying to follow up with all the helper procedures. 
  ;; So I tried to organize them sequentially with a line in between so you can have an easier time following :)

  ;; define any helper procedures here
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Recursively go over the database, if the first element in the list is a, then we return the second 
  ;; item in the list which is the cost. Base case is when we go over the list whole list, and the item is not found
  ;; then we return 0. 
  (define COST-HELPER
    (lambda (a db)
      (cond
        ((null? db) 0)
        ((equal? (first (first db)) a)
         (second (first db)))
        (else
         (COST-HELPER a (rest db))
         )
        )
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;Given the list of part 'a', we check if the first item in the list is also a list, if it 
  ;; then that means that a subpart was found, and we append the second item of the sublist to 
  ;; our result list. We keep going till we hit the base case, which is when the given list is empty 
  ;; we return the result list. 
  (define SUBPARTS-APPEND
    (lambda (res lst)
      (cond
        ((null? lst) res)
        ((list? (first lst))
         (SUBPARTS-APPEND (append res (list (second (first lst)))) (append (first lst) (rest lst)))
         )
        (else
         (SUBPARTS-APPEND res (rest lst))
         )
        )
      )
    )
  
  ;; If part 'a' was found, then we send it over to a helper function that appends all the subparts to 
  ;; a new list. Otherwise if part 'a' was not found, then an empty list is returned. 
  (define SUBPARTS-HELPER
    (lambda (a db)
      (cond
        ((null? db) '())
        ((equal? (first (first db)) a)
         (SUBPARTS-APPEND '() (first db))
         )
        (else
         (SUBPARTS-HELPER a (rest db))
         )
        )
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; If we iterate over the database and find nothing, then that means part 'a' is not a subpart
  ;; of any other part, and we return true. Otherwise we recursively call the helper function
  ;; on the part list. 
  (define NOT-SUBPART-MAINLIST
    (lambda (part-name db)
      (cond
        ((null? db) #t)
        (else
         (NOT-SUBPART-PARTLIST part-name (SUBPARTS (first (first db))) db)
         )
        )
      )
    )
  
  ;;Go over the part list, if we find part 'a' in one of the subparts, then we return false.
  ;;Otherwise when we iterate over all of the part-list, then we go back to the first helper
  ;;funcion. 
  (define NOT-SUBPART-PARTLIST
    (lambda (part-name lst db)
      (cond
        ((null? lst)
         (NOT-SUBPART-MAINLIST part-name (rest db))
         )
        ((equal? (first lst) part-name) #f)
        (else
         (NOT-SUBPART-PARTLIST part-name (rest lst) db)
         )
        )
      )
    )
    
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Recursively go through the database, if we find a part with cost 
  ;; less than or equal to cost, then we add it to our result list. If
  ;; no items were found, then we return an empty list. 
  (define AFFORD-LIST-HELPER
    (lambda (cost db res)
      (cond
        ((null? db) res)
        (( <= (second (first db)) cost)
         (AFFORD-LIST-HELPER cost (rest db) (append (list (first (first db))) res))
         )
        (else
         (AFFORD-LIST-HELPER cost (rest db) res)
         )
        )
      )
    )
    
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; USED FROM A1
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
  
  ;; Recursively go through the list and check if the first sub-part is primitive, if it's not then
  ;; then recursively replace it with its subparts. To avoid duplicates, we call mem? from A1.
  (define PRIM-PARTS-HELPER
    (lambda (sub-part-list res)
      (cond
        ((null? sub-part-list) res)
        ((and (IS-PRIM? (first sub-part-list)) (not (mem? (first sub-part-list) res)))
         (PRIM-PARTS-HELPER (rest sub-part-list) (append res (list (first sub-part-list))))
         )
        (else
         (PRIM-PARTS-HELPER (append (rest sub-part-list) (SUBPARTS (first sub-part-list))) res)
         )
        )
      )
    )
  
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Find the partname in the database and call SUBPARTS-AUGMENTED-BUILD on it.
  ;; return empty list if part-name was not found (base case)
  (define SUBPARTS-AUGMENTED-HELPER
    (lambda (part-name db)
      (cond
        ((null? db) '())
        ((equal? (first (first db)) part-name)
         (SUBPARTS-AUGMENTED-BUILD '() (first db))
         )
        (else
         (SUBPARTS-AUGMENTED-HELPER part-name (rest db))
         )
        )
      )
    )
  
  ;; Once we find the subpart we want to add, we call the build helper function to append that subpart n times.
  ;; Once done going over list, return the result list.
  (define SUBPARTS-AUGMENTED-BUILD
    (lambda (res lst)
      (cond
        ((null? lst) res)
        ((list? (first lst))
         (SUBPARTS-AUGMENTED-BUILD-HELPER res (append (first lst) (rest lst)) (second (first lst)) (first (first lst)))
         )
        (else
         (SUBPARTS-AUGMENTED-BUILD res (rest lst))
         )
        )
      )
    )
  
  ;; Add subpart 'times' times to the resulting list. Once done appending, call the main build function on
  ;; the next subpart to add.
  (define SUBPARTS-AUGMENTED-BUILD-HELPER
    (lambda (res lst to-append times)
      (cond
        ((zero? times) (SUBPARTS-AUGMENTED-BUILD res (rest (rest lst))))
        (else
         (SUBPARTS-AUGMENTED-BUILD-HELPER (append res (list to-append)) lst to-append (- times 1))
         )
        )
      )
    )
  
  ;; Given a part name, return a list of its subparts duplicated n times for each subpart
  ;; where n corresponds to the number of subparts needed to build this part.
  (define SUBPARTS-AUGMENTED
    (lambda (part-name)
      (SUBPARTS-AUGMENTED-HELPER part-name PART-DB)
      )
    )
  
  ;; Basically we just call build-list on each part in the database. We also have to check if the part
  ;; is primitive or not, if it is not then we move on to the next part. 
  (define BUILD-LIST-HELPER
    (lambda (res build-list db)
      (cond
        ((null? db) res)
        ((and (CAN-BUILD? (first (first db)) build-list) (not (IS-PRIM? (first (first db)))))
         (BUILD-LIST-HELPER (append res (list (first (first db)))) build-list (rest db))
         )
        (else
         (BUILD-LIST-HELPER res build-list (rest db))
         )
        )
      )
    )
    
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; This algorithm simply compares the first item in the given build list, and the first item of the list
  ;; we built. If the items don't match, then we place the first item in the build list at the end of that list. 
  ;; So now on the next iteration, the firt item of the build list is now what used to be the second item of the build list. 
  ;; We have a counter 'i' to keep track of the number of times we swap values. We have two base cases:
  ;; The first base case is accomplished when the required list is empty, then we know that every item in the build list
  ;; is in the required list, and we return true. 
  ;; The second base case is reached when i equals to length, then that means we swapped enough times to determine whether 
  ;; we can build the list from required list or not. If it's not null, then we can't build it, and we return false. 
  (define CAN-BUILD-HELPER
    (lambda (build-list required-list length i)
      (cond
        ;; went over all iterations. 
        ((equal? i length) #f)
        ;; required list is empty means that build-list is contained in required list.
        ((null? required-list) #t)
        ;; If required lit is not empty, and build list is, then we can't build the part. 
        ((null? build-list) #f)
        ((equal? (first required-list) (first build-list))
         (CAN-BUILD-HELPER (rest build-list) (rest required-list) length i)
         )
        (else
         (CAN-BUILD-HELPER (append (rest build-list) (list (first build-list))) required-list length (+ i 1))
         )
        )
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Use fold to add the items recursively. 
  (define (ALL-COST-HELPER op id lst)
    (cond 
      ((null? lst) id)
      (else 
       (op (COST (first lst))
           (ALL-COST-HELPER op id (rest lst))))
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Wasn't sure if I could use the remove-duplicates built-in function, so I made my own. 
  ;; It says on the discussion board I'm allowed to use filter. 
  (define remove-dupes
    (lambda (lst)
      (cond 
        ((null? lst) '())
        (else
         (cons (first lst) (remove-dupes (filter (lambda (element) (not (equal? element (first lst)))) 
                                                 (rest lst))))))
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; We are appending over an empty list by calling the SUBPARTS procedure we wrote earlier. 
  ;; Used fold for this procedure.
  ;; Note that this will return the list of subparts with duplicates. 
  (define ALL-PARTS-HELPER
    (lambda (op res part-list)
      (cond
        ((null? part-list) res)
        (else
         (op (SUBPARTS (first part-list))
             (ALL-PARTS-HELPER op res (rest part-list))))
        )
      )
    )
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:::::::: MAIN IMPLEMENTATION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (COST partname)
  ;; Return the cost of item a in the database if it exists. If it doesn't, return 0.
  (define COST
    (lambda (a)
      (COST-HELPER a PART-DB)
      )
    )

  ;; (SUBPARTS partname) 
  ;; Return a list of the subparts of part 'a'. If part is not found, then
  ;; return the empty list. 
  (define SUBPARTS
    (lambda (a)
      (SUBPARTS-HELPER a PART-DB)
      )
  )

  ;; (IS-PRIM? partname)
  ;; Return true if given part 'a' is a primitive item or false if it isn't.  
  (define IS-PRIM?
    (lambda (a)
      (let* ((res (SUBPARTS a)))
        (cond
          ;; this just means that the item is not in the database.
          ((zero? (COST a)) #f)
          ((null? res) #t)
          (else #f ))
        )
      )
    )
  
  ;; (NOT-SUBPART? partname)
  ;; Return true if part 'a' is not a subpart of any other parts in the database. False otherwise. 
  (define NOT-SUBPART?
    (lambda (part-name)
      (NOT-SUBPART-MAINLIST part-name PART-DB)
      )
    )

  ;; (AFFORDLIST val)
  ;; Given a cost, return a list of all the items that cost less than
  ;; that cost. If no item was found less than that cost, return an 
  ;; empty list. 
  (define AFFORDLIST
    (lambda (cost) 
      (AFFORD-LIST-HELPER cost PART-DB '())
      )
    )

  ;; (PRIM-PARTS partname)
  ;; Given a part-name, return all the primitive parts that build 
  (define PRIM-PARTS
    (lambda (part-name)
      (let* ((sub-part-list (SUBPARTS part-name)))
        (PRIM-PARTS-HELPER sub-part-list '())
        )
      )
    )

  ;; (CAN-BUILD? partname partlist)
  ;; Given a build list and a part-name, return true if part-name can be built off build-list and false otherwise. 
  (define CAN-BUILD?
    (lambda (part-name build-list)
      (cond
        ;;base case when the list is empty and the partname is primitive.  
        ((and (zero? (length build-list)) (IS-PRIM? part-name)) #t)
        ((equal? (CAN-BUILD-HELPER build-list (SUBPARTS-AUGMENTED part-name) (length build-list) 0) #t)
         #t
         )
        (else
         #f
         )
        )
      )
    )

  ;; (BUILD-LIST partlist)
  ;; Given a build list, returns a list of all (non-primitive) parts whose immediate 
  ;; subparts are included in the input argument list, in
  ;; sufficient quantities to compose the part.
  (define BUILD-LIST
    (lambda (build-list)
      (BUILD-LIST-HELPER '() build-list PART-DB)
      )
    )

  ;; (ALL-COST partlist)
  ;; Given a list of part names, find the total cost of all the items. 
  (define ALL-COST
    (lambda (part-list)
      (ALL-COST-HELPER + 0 part-list)
      )
    )

  ;; (ALL-PARTS partlist)
  ;; Given a list of parts, return a list of all the immediate subparts. 
  (define ALL-PARTS
    (lambda (part-list)
      (remove-dupes (ALL-PARTS-HELPER append '() part-list))
      )
    )

  ;; (COST-OF-PARTS partname)
  ;; Given a part-name, return the cost of all of its sub parts.
  ;; Simply just call the ALL-COST-HELPER function on the augmented subparts
  ;; procedude we defined in CAN-BUILD?
  (define COST-OF-PARTS
    (lambda (part-name)
      (ALL-COST-HELPER + 0 (SUBPARTS-AUGMENTED part-name))
      )
    )

  (provide COST SUBPARTS IS-PRIM? NOT-SUBPART? AFFORDLIST PRIM-PARTS CAN-BUILD? BUILD-LIST ALL-COST ALL-PARTS COST-OF-PARTS)
)

