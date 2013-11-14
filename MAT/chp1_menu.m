%% dont touchy stuff
function varargout = chp1_menu(varargin)
% CHP1_MENU MATLAB code for chp1_menu.fig
%      CHP1_MENU, by itself, creates a new CHP1_MENU or raises the existing
%      singleton*.
%
%      H = CHP1_MENU returns the handle to a new CHP1_MENU or the handle to
%      the existing singleton*.
%
%      CHP1_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHP1_MENU.M with the given input arguments.
%
%      CHP1_MENU('Property','Value',...) creates a new CHP1_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chp1_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chp1_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help chp1_menu

	% Last Modified by GUIDE v2.5 13-Nov-2013 18:06:58

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @chp1_menu_OpeningFcn, ...
					   'gui_OutputFcn',  @chp1_menu_OutputFcn, ...
					   'gui_LayoutFcn',  [] , ...
					   'gui_Callback',   []);
	if nargin && ischar(varargin{1})
		gui_State.gui_Callback = str2func(varargin{1});
	end

	if nargout
		[varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
	else
		gui_mainfcn(gui_State, varargin{:});
	end
	% End initialization code - DO NOT EDIT
end

% --- Executes during object creation, after setting all properties.
function eq_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eq_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
	if ispc && isequal(get(hObject,'BackgroundColor'), ...
			get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
end

% --- Outputs from this function are returned to the command line.
function varargout = chp1_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

%% initialization
% --- Executes just before chp1_menu is made visible.
function chp1_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chp1_menu (see VARARGIN)

	% Choose default command line output for chp1_menu
	handles.output = hObject;

	% UIWAIT makes chp1_menu wait for user response (see UIRESUME)
	% uiwait(handles.chp1_menu);
	
	handles.var_scrl_pnl = ScrollPanel('Units', 'pixels', ...
		'Position', [12, 40, 276, 200], 'ScrollArea', [0 0 0 0]);
	set(pan, 'Enable', 'off', 'Motion', 'horizontal', 'ActionPostCallback', ...
		@(obj, event_obj)redraw(handles.axes1, obj, event_obj, handles));
	guidata(hObject, handles);
	
	reset_btn_Callback(handles.reset_btn, eventdata, handles);
end

%% callbacks
function eq_input_Callback(hObject, eventdata, handles)
% hObject    handle to eq_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global equation;
	global var_count;
	
	str = get(hObject, 'String');
	try
		if isempty(str)
			throw();
		end
		equation = sym(str);
		clearErronous(hObject, handles);
	catch err
		equation = sym(nan);
		setErronous(hObject, handles);
		return;
	end
	
	delete_all_var_input(handles);
	vars = symvar(sym(get(hObject, 'String')));
	for i = 1:length(vars)
		add_var_input(char(vars(i)), handles);
		value_tag = sprintf('var_value_input%d', var_count);
		err_tag = sprintf('var_err_input%d', var_count);
		handles = guidata(hObject);
		var_value_input_Callback(handles.(value_tag), eventdata, handles);
		var_err_input_Callback(handles.(err_tag), eventdata, handles);
	end
end

function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global error_count;
	global equation;
	error_count = 0;
	equation = sym(nan);

	delete_all_var_input(handles);
	set(handles.var_scrl_pnl, 'ScrollArea', [0 0 0 0]);
	set(handles.eq_input, 'String', '');
	eq_input_Callback(handles.eq_input, eventdata, handles);
end

function var_value_input_Callback(hObject, eventdata, handles)
% hObject    handle to var_value_input_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	str = get(hObject, 'String');
	try
		if isempty(str)
			throw();
		end
		if ~isfinite(double(sym(str)))
			throw();
		end
		
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
		return;
	end
	
	userdata = get(hObject, 'Userdata');		
	get(userdata.pair, 'String')
	get(userdata.pair, 'Tag')
	if isempty(get(userdata.pair, 'String'))
		precision = get_precision(str);
		set(userdata.pair, 'String', sprintf('%g', 10^(-precision)));
		var_err_input_Callback(userdata.pair, eventdata, handles);
	end
end

function var_err_input_Callback(hObject, eventdata, handles)
% hObject    handle to var_err_input_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	str = get(hObject, 'String');
	try
		if isempty(str)
			throw();
		end
		if ~isfinite(double(sym(str)))
			throw();
		end
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
	end
end

function eval_btn_Callback(hObject, eventdata, handles)
% hObject    handle to eval_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch1.*;
	global equation;
	subexpressions = cell(0);
	subexpression_parents = ones(0, 0);
	values = ones(0, 0);
	errors = ones(0, 0);
	[var_names var_values var_errors] = get_vars(handles);

	parse_tree = parse(tokenize(char(equation)));
	dfs(parse_tree, 0);

	function [value error] = dfs(pt, parent)
		ind = length(subexpression_parents) + 1;
		subexpressions{ind} = ['$', pt.value, '$'];
		subexpression_parents(ind) = parent;
		child_error = ones(length(pt.children), 1);
		child_value = ones(length(pt.children), 1);
		for i = 1:length(pt.children)
			[child_value(i) child_error(i)] = dfs(pt.children{i}, ind);
		end
		
		switch pt.token.type
			case 'n'
				error = 0;
				value = double(pt.token.value);
			case 'v'
				
				error = abs(var_errors(ismember(var_names, pt.token.value)));
				value = var_values(ismember(var_names, pt.token.value));
			case 'o'
				switch pt.token.value
					case '+'
						error = sum(abs(child_error));
						value = sum(child_value);
					case '-'
						error = sum(abs(child_error));
						value = child_value(1) - child_value(2);
					case '*'
						error = abs(child_error(1) * child_value(2)) + ...
							abs(child_error(2) * child_value(1));
						value = child_value(1) * child_value(2);
					case '/'
						error = abs(child_error(1) * child_value(2)) + ...
							abs(child_error(2) * child_value(1)) / ...
							(child_value(2)^2);
						value = child_value(1) / child_value(2);
					case '^'
						error = abs(child_value(1) ^ (child_value(2) - 1) * ...
							child_value(2) * child_error(1)) + ...
							abs(child_error(2) * log(abs(child_value(1))));
						value = child_value(1) ^ child_value(2);
				end
			case 'f'
				error = abs(child_error(1) * ...
					subs(diff(sym([pt.token.value, '(x)'])), child_value(1)));
				value = subs(sym([pt.token.value, '(x)']), child_value(1));
		end
		errors(ind) = error;
		values(ind) = value;
	end

	treeplot(subexpression_parents);
	[x,y] = treelayout(subexpression_parents);
	x = x';
	y = y';
	for j = 1:length(subexpressions)
		text(x(j,1), y(j,1), ...
			sprintf('%s=%g \pm %g', subexpressions{j}, values(j), errors(j)), ...
			'Interpreter', 'latex', 'VerticalAlignment', 'bottom', ...
			'HorizontalAlignment','center', 'FontSize', 12);
	end
	title(latex(equation),'FontSize',12);
end

%% other stuff
 function clearErronous(hObject, handles)
	global error_count;
	
	if isequal(get(hObject, 'ForegroundColor'), [0.8, 0, 0])
		set(hObject, 'ForegroundColor', [0 0 0]);
		error_count = error_count - 1;
		if error_count == 0
			set(handles.eval_btn, 'Enable', 'on');
		end
	end
end

function setErronous(hObject, handles)
	global error_count;
	
	if isequal(get(hObject, 'ForegroundColor'), [0, 0, 0])
		error_count = error_count + 1;
		set(hObject, 'ForegroundColor', [0.8 0 0]);
		set(handles.eval_btn, 'Enable', 'off');
	end
end

function add_var_input(var_name, handles)
	global var_count;
	var_count = var_count + 1;
	
	value_tag = sprintf('var_value_input%d', var_count);
	label_tag = sprintf('var_label%d', var_count);
	pm_tag = sprintf('pm%d', var_count);
	err_tag = sprintf('var_err_input%d', var_count);
	handles.(label_tag) = uicontrol('Style', 'text', 'Tag', label_tag, ...
		'Units', 'pixels', 'Position', [5 var_count*25-20 60 20], ...
		'Parent', handles.var_scrl_pnl.handle, 'String', var_name);
	handles.(value_tag) = uicontrol('Style', 'edit', 'Tag', value_tag, ...
		'Units', 'pixels', 'Position', [70 var_count*25-20 130 20], ...
		'Parent', handles.var_scrl_pnl.handle, 'Callback', ...
		@(hObject, eventdata)var_value_input_Callback(hObject, ...
		eventdata, guidata(hObject)));
	handles.(pm_tag) = uicontrol('Style', 'text', 'Tag', pm_tag, ...
		'Units', 'pixels', 'Position', [201 var_count*25-20 10 20], ...
		'Parent', handles.var_scrl_pnl.handle, 'String', '±');
	handles.(err_tag) = uicontrol('Style', 'edit', 'Tag', err_tag, ...
		'Units', 'pixels', 'Position', [213 var_count*25-20 57 20], ...
		'Parent', handles.var_scrl_pnl.handle, 'String', '', ...
		'Callback', @(hObject, eventdata)var_err_input_Callback(hObject, ...
		eventdata, guidata(hObject)));
	set(handles.(value_tag), 'Userdata', ...
		struct('type', 'value', 'pair', handles.(err_tag), 'name', var_name));
	set(handles.(err_tag), 'Userdata', ...
		struct('type', 'errpr', 'pair', handles.(value_tag), 'name', var_name));
	
	set(handles.var_scrl_pnl, 'ScrollArea', [0 0 276 25*var_count+5]);
	
	guidata(handles.chp1_menu, handles);
end

function delete_all_var_input(handles)
	global var_count;
	var_count = 0;
	
	children = allchild(handles.var_scrl_pnl.handle);
	for i = 1:length(children)
		clearErronous(children(i), handles);
		delete(children(i));
	end
end

function precision = get_precision(str)
	decimal_dig_ind = strfind(str, '.');
	if isempty(decimal_dig_ind)
		last_zero = regexp(str, '0*$', 'once');
		if isempty(last_zero)
			precision = 0;
		else
			precision = regexp(str, '0*$') - length(str)- 1;
			if regexp(str, '^0+$')
				precision = precision + 1;
			end
		end
	else
		precision = length(str) - decimal_dig_ind;
	end
end

function [var_name, var_values, var_errors] = get_vars(handles)
	children = allchild(handles.var_scrl_pnl.handle);
	var_values = zeros(length(children) / 4, 1);
	var_errors = zeros(length(children) / 4, 1);
	var_name = cell(length(children) / 4, 1);
	j = 1;
	for i = 1:length(children)
		userdata = get(children(i), 'Userdata');
		style = get(children(i), 'Style');
		if strcmp(style, 'edit') && strcmp(userdata.type, 'value')
			var_values(j) = double(sym(get(children(i), 'String')));
			var_errors(j) = double(sym(get(userdata.pair, 'String')));
			var_name{j} = userdata.name;
			j = j + 1;
		end
	end
end

function redraw(hObject, obj, event_obj, handles)
end
