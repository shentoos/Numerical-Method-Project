function root = newton_raphson(f, root)
	global f_cached;
	global delta_cached;
	
	if f == f_cached
		delta = delta_cached;
	else
		delta = f / diff(f);
		f_cached = f;
		delta_cached = delta;
	end
	
	root = root - subs(delta, root);
end
