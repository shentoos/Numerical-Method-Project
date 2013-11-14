function tokens = tokenize(expr)
%TOKENIZE Tokenizes the input expression
%	EXPR: Input expression
%	output is a cell array consisting of structs with a value and type field.
%	value is copied exactly from the expression, but the type is a key 
%	described here:
%		n:	numeric token
%		v:	variable name
%		f:	function name
%		o:	operator

	% state:
	%	n:	numeric
	%	e:	numeric containing 'e' or 'E'
	%	E:	numeric containing 'e' or 'E', whose exponent has a sign operator.
	%	w:	word
	%	o:	operator
	
	vars = symvar(sym(expr));
	
	tokens = cell(0);
	tk = '';		% current token
	state = 'S';	% start state
	for i = 1:length(expr)
		switch expr(i)
			case ' '
			case {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'}
				switch state
					case {'e', 'E', 'n', 'w'}
						tk = [tk expr(i)];
					otherwise
						add_token(tk, state);
						state = 'n';
						tk = expr(i);
				end
			case {'e', 'E'}
				switch state
					case 'n'
						state = 'e';
						tk = [tk expr(i)];
					case 'w'
						tk = [tk expr(i)];
					otherwise
						add_token(tk, state);
						state = 'w';
						tk = expr(i);
				end
			case {'+', '-'}
				switch state
					case 'e'
						state = 'E';
						tk = [tk expr(i)];
					otherwise
						add_token(tk, state);
						state = 'o';
						tk = expr(i);
				end
			case {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', ...
					'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', ...
					'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', ...
					'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', ...
					'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '_'}
				switch state
					case 'w'
						tk = [tk expr(i)];
					otherwise
						add_token(tk, state);
						state = 'w';
						tk = expr(i);
				end
			otherwise
				add_token(tk, state);
				state = 'o';
				tk = expr(i);
		end
	end
	add_token(tk, state);
	tokens = tokens(2:end);
	
	function add_token(tk, state)
		switch state
			case {'n', 'e', 'E'}
				type = 'n';
			case 'w'
				if ismember(tk, vars)
					type = 'v';
				else
					type = 'f';
				end
			case 'o'
				type = 'o';
			otherwise
				type = 'S';
		end
		if type == 'o'
			if strcmp(tk, '+') || strcmp(tk, '-')
				ary = -1;		% the operator is ambigious, ethr ary=1 or ary=2
			elseif strcmp(tk, '(')
				ary = 0;
			elseif strcmp(tk, ')')
				ary = 1;
			else
				ary = 2;
			end
			tokens{length(tokens) + 1} = struct('value', tk, 'type', type, ...
				'index', length(tokens) + 1, 'ary', ary);
		elseif type == 'f'
			tokens{length(tokens) + 1} = struct('value', tk, 'type', type, ...
				'index', length(tokens) + 1, 'ary', 1);
		else
			tokens{length(tokens) + 1} = struct('value', tk, 'type', type, ...
				'index', length(tokens) + 1);
		end
	end
end
