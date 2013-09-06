datatype numbers= I of int
|		  R of real;

fun	sumInts [] = 0
|	sumInts((I x)::rest) = x + sumInts(rest)
|	sumInts((R x)::rest) = sumInts(rest);

datatype llist = Nil | Node of int * llist;

fun	len Nil = 0
|	len(Node (_, rest)) = 1 + len rest;


fun	append2all(Expr, [[]]) = [Expr]
|	append2all(Expr, (h::t)) = Expr::h @ append2all(Expr, t);

datatype btree = Empty | Node of int * btree * btree;
fun	lookup(X, Empty) = false
|	lookup(X, Node(Y, L, R)) = if (X==Y) then true
|	lookup(X, Node(Y, L, R))= if (X>Y) then lookup(X, L) else lookup(X, R);
