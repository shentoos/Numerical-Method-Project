function root = fixed_point(f, root)
	global f_cached;
	global g_cached;
	
	if f == f_cached
		g = g_cached;
	else
		x = symvar(f);
		g = x - f / diff(f);
	end
	
	root = subs(g, root);
end
