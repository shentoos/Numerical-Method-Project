function X = generalized_newton_raphson(F, V, X)
	global F_cached;
	global DELTA_cached;
	
	if isequal(F, F_cached)
		DELTA = DELTA_cached;
	else
		J = jacobian(F);
		D = det(J);
		D_i = sym(zeros(length(X), 1));
		for i = 1:length(X)
			TEMP = J;
			TEMP(:, i) = F;
			D_i(i) = det(TEMP);
		end
		DELTA = D_i./D;
		DELTA_cached = DELTA;
	end
	
	X = X - subs(DELTA, V, X);
end
