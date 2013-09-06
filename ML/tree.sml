datatype ''a tree = Node of ''a * ''a tree list;


(* A mutual recursive solution. Base case when list is nil we return 0 or 1 depending on condition, otherwise we call 
* the helper function on the head and tail. All the helper function does is it calls count on the head, and recalls tail
* on itself to keep parsing elements out. *)

fun     count(target, Node(data, nil)) = if target=data then 1 else 0
|       count(target, Node(data, (h::t))) = if target=data then 1 + helper_count(target, t) else helper_count(target, t)
and	helper_count(target, nil) = 0
|	helper_count(target, h::t) = count(target, h) + helper_count(target, t);

(* Cases are very similar to the above cases, we recursively find the maximum depth and 1 with each iteration. We've been
* doing this algorithm since first year, so there's really no need for me to comment more :P *) 
fun 	depth (Node (h, nil) ) = 0
|  	depth (Node (label, h::nil )) =   1 + depth(h)
|  	depth (Node (label, [h,t])) =  1 + Int.max(depth(h), depth(t));

(* A helper function for countHOP where we need a flattened list in order to perform the algorithm *)
fun 	un_nest (Node (h, nil) ) = [h]
|  	un_nest (Node (label, [h])) = [label] @ un_nest(h)
|  	un_nest (Node (label, [h,t])) = [label] @ un_nest(h) @ un_nest(t);

(* So basically we're just keeping the Nodes where the labels are equal to the target and taking everything else
* out *)
fun 	count_helper (target, label) = List.filter (fn x => x = target) label;

(* After we keep the nodes that are equal to the target by calling the helper function, we can find the count
* by returning the length of that list. *)
fun 	countHOP (h, t) = List.length (count_helper(h,un_nest(t)));

(* Given a head and a tail, return the one with the max length. (Similar algorithm to the regular recursive algo) *)
fun	find_max nil = 0
| 	find_max (h::t) = foldl Int.max h t;

(* Given a node, we return 0 on our base case, other wise, we call the helper on the depth of the list. Then we return the 
* max for each given head and tail. *)
fun 	depthHOP (Node(label ,nil)) = 0
| 	depthHOP (Node(label, list)) = 1 + find_max(List.map depth list);

