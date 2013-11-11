function latex = double2latex(x, precision)
	if isnan(x)
		latex = 'NaN';
	elseif isinf(x) && x > 0
		latex = '$\infty$';
	elseif isinf(x) && x < 0
		latex = '$-\infty$';
	else
		latex = sprintf(sprintf('$%%.%dg$', precision), x);
	end
end
