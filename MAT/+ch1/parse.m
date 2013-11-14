function tree = parse(tokens)
	import datastructures.Stack
	
	operators = Stack();
	operands = Stack();
	
	for i = 1:length(tokens)
		token = tokens{i};
		if token.value == '('
			operators.push(struct('type', 'open_paranthesis', 'value', '('));
		elseif token.value == ')'
			while ~isfield(operators.top(), 'type') || ...
					~strcmp(operators.top().type, 'open_paranthesis')
				execute_one();
			end
			operators.pop();
		else
			switch token.type
				case {'n', 'v'}
					operands.push(struct('token', token, 'children', [], ...
						'ary', 0, 'value', token.value, ...
						'first', token.index, 'last', token.index));
				case {'o', 'f'}
					while ~operators.isempty() && ...
							(precedence(operators.top()) > precedence(token))
						execute_one();
					end
					operators.push(token);
			end
		end
	end
	
	while ~operators.isempty()
		execute_one();
	end
	operands.size()
	tree = operands.pop();
	
	function node = execute_one()
		operator = operators.pop();
		if operator.ary == -1
			if operands.top_nth(2).last == operator.index - 1;
				ary = 2;
			else
				ary = 1;
			end
		else
			ary = operator.ary;
		end
		
		children = cell(ary, 1);
		for j = 1:ary
			children{ary - j + 1} = operands.pop();
		end
		
		if ary == 0
			value = operator.value;
		elseif ary == 1
			value = [operator.value, children{1}.value];
		elseif ary == 2
			children{1}.value
			operator.value
			children{2}.value
			value = [children{1}.value, operator.value, children{2}.value];
		else
			value = [operator.value, '('];
			for j = 1:ary
				value = [value sprintf('%s,', children{j}.value)];
			end
			value(end) = ')';
		end
		
		if ary == 0
			first = operator.index;
			last = operator.index;
		else
			first = min(children{1}.first, operator.index);
			last = children{length(children)}.last;
		end
		
		node = struct('token', operator, 'children', {children}, 'ary', ary, ...
			'value', value, 'first', first, 'last', last);
		operands.push(node);
	end
end

function p = precedence(op)
	if op.type == 'f'
		p = 5;
	else
		switch op.value
			case {'(', ')'}
				p = 0;
			case {'+', '-'}
				p = 1;
			case {'*', '/', '\'}
				p = 2;
			case {'^'}
				p = 3;
		end
	end
end
