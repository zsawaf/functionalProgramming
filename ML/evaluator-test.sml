type Name = string;

datatype Expr = Const of int
	| Var of Name
	| Neg of Expr
	| Plus of Expr * Expr
	| Mult of Expr * Expr
	| App of Fun * Expr
and Fun = Def of Name * Expr


fun substitute(n, e1, (Const e2)) = (Const e2)
	| substitute(n, e1, (Var e2)) = if (Var n) = (Var e2) then e1 else (Var e2)
	| substitute(n, e1, (Neg e2)) = Neg(substitute(n, e1, e2))
	| substitute(n, e1, (Plus (exp1, exp2))) = Plus(substitute(n, e1, exp1), substitute(n, e1, exp2))
	| substitute(n, e1, (Mult (exp1, exp2))) = Mult(substitute(n, e1, exp1), substitute(n, e1, exp2))
	| substitute(n, e1, (App(Def(n1, exp1), exp2))) = App(Def(n1, substitute(n, e1, exp1)), substitute(n, e1, exp2));
	
fun eval(Const a) = a
	| eval(Plus ((Const a), (Const b))) = a + b
	| eval(Mult ((Const a), (Const b))) = a * b
	| eval(Neg (Const a)) = a * ~1
	| eval(Plus (exp1, exp2)) = eval(exp1) + eval(exp2)
	| eval(Mult (exp1, exp2)) = eval(exp1) + eval(exp2)
	| eval(Neg (exp)) = eval(exp) * ~1
	| eval(App(Def(n1, exp1), exp2)) = eval(substitute(n1, exp2, exp1));

eval (App (Def ("x", App (Def ("y", Plus(Var "x", Var "y")),Var "x")), Const 3));
eval (App (Def ("x", Plus (Var "x", Const 2)), (Const 3)));
substitute ("z", Neg(Const 1), App(Def("x", Plus(Var "z", Var "x")), Const 3));

