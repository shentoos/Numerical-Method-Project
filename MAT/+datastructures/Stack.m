classdef Stack < handle
	properties (Access = private)
		data           % Data buffer
		count          % Number of items currently stored
		capacity       % Current capacity
	end
	
	methods (Access = public)
		function this = Stack(in)
			if nargin == 1 && iscell(in)
				this.data = in(:);
				this.count = length(in);
			elseif nargin == 1 && length(in) == 1 && ~mod(in, 1)
				this.data = cell(in, 1);
				this.count = 0;
			elseif nargin == 0
				this.data = cell(100, 1);
				this.count = 0;
			else
				error('Invalid argument');
			end
			this.capacity = length(this.data);
		end
		
		function size = size(this)
			size = this.count;
		end
		
		function push(this, el)
			if this.count == this.capacity
				this.data((this.capacity + 1):(2 * this.capacity)) = ...
					cell(this.capacity);
				this.capacity = 2 * this.capacity;
			end
			this.count = this.count + 1;
			this.data{this.count} = el;
		end
		
		function pop = pop(this)
			if this.size == 0
				error('Popping from empty stack');
			end
			pop = this.data{this.size};
			this.count = this.size - 1;
		end
		
		function top = top(this)
			top = this.top_nth(1);
		end
		
		function top_nth = top_nth(this, n)
			if this.size < n
				error('Topping from empty stack');
			end
			top_nth = this.data{this.size - n + 1};
		end
		
		function isempty = isempty(this)
			isempty = (this.size == 0);
		end
		
		function empty(this)
			this.count = 0;
		end
		
		function display(this)
			for i = 1:this.size
				disp(this.data{i});
			end
        end
	end
end
