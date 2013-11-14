function out = newton_forward_central_differences(X, Y)	
%NEWTON_FORWARD_CENTRAL_DIFFERENCES(X, Y, x) Evaluates the interpolation
%polynomial in x
%	Evaluates the interpolation in x, using Newton forward central differences
%	method.

%% Evaluation
	import ch3.interpolation.newton_differences_table
	syms x;
	
	TABLE = newton_differences_table(Y);
	n = length(Y);
	A = zeros(1, n);
	for i = 1:n
		A(i) = TABLE(ceil((n+i)/2), i);
	end
	
	h = X(2) - X(1);
	r = (x - X(floor(n/2) +	 1)) / h;
	out = 0;
	x_n = 1;
	j = 0;
	for i = 1:n
		out = out + A(i) * x_n;
		if mod(n, 2) == 0
			x_n = x_n * (r - j) / i;
		else
			x_n = x_n * (r + j) / i;
		end
		if j >= 0
			j = -(j + 1);
		else
			j = -j;
		end
	end
end
