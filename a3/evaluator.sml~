type Name = string;

datatype Expr = Const of int
| Var of Name
| Neg of Expr
| Plus of Expr * Expr
| Mult of Expr * Expr
| App of Fun * Expr
and Fun = Def of Name * Expr;

exception EvalException;

(* Base case is either a var or a const. We actually do the switching in the var case checking if the name is equal to 
* the second expression then we perofrm a switch. The trick is how to enter the expressions inside the datatypes. We basically
* have a case for each data type. For binary operators we need to call substitute recursively on both expressions, for unary operators
* we call substitute recursively on the expression. On the next iteration, the expression is now parsed, and it will keep getting
* broken down to smaller components until it hits our base case, and we get our solution. *)

fun 	substitute(n, e1, (Const e2)) = (Const e2)
| 	substitute(n, e1, (Var e2)) = if (Var n) = (Var e2) then e1 else (Var e2)
| 	substitute(n, e1, (Neg e2)) = Neg(substitute(n, e1, e2))
| 	substitute(n, e1, (Plus (e2, e3))) = Plus(substitute(n, e1, e2), substitute(n, e1, e3))
| 	substitute(n, e1, (Mult (e2, e3))) = Mult(substitute(n, e1, e2), substitute(n, e1, e3))
| 	substitute(n, e1, (App(Def(n1, e2), e3))) = App(Def(n1, substitute(n, e1, e2)), substitute(n, e1, e3));

(* Similar to the above function, we recursively parse the expression until we reach our base case of constants, in which the 
* function performs all the operations when it reaches the base case of a constant integer. If non of the cases pass then this
* means that the input was incorrect and the expression was not of a closed form. Therefore it raises an EvalException *)
fun 	eval(Const a) = a
| 	eval(Plus (e1, e2)) = eval(e1) + eval(e2)
| 	eval(Mult (e1, e2)) = eval(e1) * eval(e2)
| 	eval(Neg (e1)) = eval(e1) * ~1
| 	eval(App(Def(n1, e1), e2)) = eval(substitute(n1, e2, e1))
|	eval(e1) = raise EvalException;
