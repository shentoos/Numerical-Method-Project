function x = halley(f, x)
% Finds root of a given function using Halley method.
	global f_cached;
	global delta_cached;

	if f == f_cached
		delta = delta_cached;
	else
		f_prime = diff(f);
		f_double_prime = diff(f_prime);
		delta = 2 * f * f_prime / (2 * f_prime * f_prime - f * f_double_prime);
		f_cached = f;
		delta_cached = delta;
	end

	x = x - subs(delta, x);
end
