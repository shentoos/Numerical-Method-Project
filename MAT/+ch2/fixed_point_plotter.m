function g = fixed_point_plotter(f, XLim)
	global f_cached;
	global g_cached;
	
	if f == f_cached
		g = g_cached;
	else
		x = symvar(f);
		g = x - f / diff(f);
	end
	
	h = ezplot(sym('x'), XLim);
	set(h, 'Color', 'green', 'LineStyle', '--');
	h = ezplot(g, XLim);
	set(h, 'Color', 'green', 'LineStyle', '--');
end
