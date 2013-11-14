function TABLE = newton_differences_table(Y)
%NEWTON_DIFFERENCES_TABLE(Y)
%	Builds the table used for newton differences method. Y is the vector of
%	values of the function, evaluated at equally spaced points.

%% Building table
	n = length(Y);
	TABLE = sym(zeros(n));
	for row = 1:n
		TABLE(row, 1) = Y(row);
	end
	for col = 2:n
		for row = col:n
			TABLE(row, col) = TABLE(row, col - 1) - TABLE(row - 1, col - 1);
		end
	end
	
%% Latex
	if false
		indention = '		';
		fprintf('%s\\begin{tabular}{|c||', indention);
		for i = 1:n
			fprintf('c|');
		end
		fprintf('}\n');
		fprintf('%s\t\\hline\n', indention);
		fprintf('%s', indention);
		for i = 1:n
			fprintf('\t&\t$\\bf{%d}$', i);
		end
		fprintf('\n%s\t\\\\\\hline\n', indention);
		for row = 1:n
			fprintf('%s\t\\rule{0pt}{1em} $\\bf{%d}$', indention, row);
			for col = 1:n
				fprintf('\t&\t$%s$', sprint_fraction(TABLE(row, col)));
			end
			fprintf('\n%s\t\\\\\\hline\n', indention);
		end
		fprintf('%s\\end{tabular}\n', indention);
	end
