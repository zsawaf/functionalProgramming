
(* Recursively call x as the input of the function f until it hits the base case of which
* the input is equal to the output. In other words, given a function f and an x, we need to
* recursively call f(x) until (fx) = x then we return x*)
fun A_helper (f,x) = if (f(x) = x) then x else (A_helper (f, f(x)));

fun fixA f = fn x => (A_helper (f, x));

(* Identical to A_helper*)
fun fixB f = fn x => if (f(x) = x) then x else f(fixB f x);

(* This is identical to the helper function in fixA except we're using currying to take in
* f and x *)
fun fixC f x = if (f(x) = x) then x else (fixC f (f x));
