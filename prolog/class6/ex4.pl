% b) tree_map(+Pred, +Tree, ?NewTree), where Tree and NewTree are trees of the same shape, and Pred(X, Y) is true for every X in Tree and corresponding Y in NewTree

tree_map(_, null, null).
tree_map(Pred, node(Val, Left, Right), node(Val1, Left1, Right1)) :-
	NewPred =.. [Pred, Val, Val1],
	call(NewPred),
	tree_map(Pred, Left, Left1),
	tree_map(Pred, Right, Right1).