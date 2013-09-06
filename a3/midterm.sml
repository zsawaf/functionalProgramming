(* Sum map *)
fun	sumMap(_, []) = 0
|	sumMap(proc, (head::tail)) = (proc head) + sumMap(proc, tail);

fun	listLabel Null = []
|	listLabel(x, left, mid, right) = x::listLabel(left)::listLabel(mid)::listLabel(right); 
