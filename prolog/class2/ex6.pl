% Implemnents the Euclid algorithm to get the gcd between two numbers X and Y

gcd(X, 0, X).
gcd(X, Y, G) :- 
	Y > 0,
	X1 is Y,
	Y1 is X mod Y,
	gcd(X1, Y1, G).
