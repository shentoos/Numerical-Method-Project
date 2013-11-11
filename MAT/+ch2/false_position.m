function [a b x] = false_position(f, a, b)
% Finds root of a function in a given interval. The given interval should
% satisfy Bolzano's condition.
	f_a = subs(f, a);
	f_b = subs(f, b);
	x = (abs(f_a) * b + abs(f_b) * a) / (abs(f_a) + abs(f_b));
	f_x = subs(f, x);
	if f_a * f_x < 0
		b = x;
	else
		a = x;
	end
	f_a = subs(f, a);
	f_b = subs(f, b);
	x = (abs(f_a) * b + abs(f_b) * a) / (abs(f_a) + abs(f_b));
end
