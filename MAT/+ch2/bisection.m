function [a b x] = bisection(f, a, b)
% Finds root of a function in a given interval. The given interval should
% satisfy Bolzano's condition.
	x = (a + b) / 2;
	if subs(f, a) * subs(f, x) < 0
		b = x;
	else
		a = x;
	end
	x = (a + b) / 2;
end
