function varargout = ch2_fig3(varargin)
% CH2_FIG3 MATLAB code for ch2_fig3.fig
%      CH2_FIG3, by itself, creates a new CH2_FIG3 or raises the existing
%      singleton*.
%
%      H = CH2_FIG3 returns the handle to a new CH2_FIG3 or the handle to
%      the existing singleton*.
%
%      CH2_FIG3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CH2_FIG3.M with the given input arguments.
%
%      CH2_FIG3('Property','Value',...) creates a new CH2_FIG3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ch2_fig3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ch2_fig3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help ch2_fig3

	% Last Modified by GUIDE v2.5 12-Nov-2013 07:11:11

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @ch2_fig3_OpeningFcn, ...
					   'gui_OutputFcn',  @ch2_fig3_OutputFcn, ...
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

% --- Executes just before ch2_fig3 is made visible.
function ch2_fig3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ch2_fig3 (see VARARGIN)

	% Choose default command line output for ch2_fig3
	handles.output = hObject;

	% Update handles structure
	guidata(hObject, handles);

	% UIWAIT makes ch2_fig3 wait for user response (see UIRESUME)
	% uiwait(handles.ch2_fig3);
	
	global cur_step;
	cur_step = 1;
	
	% Initializing scroll panels
	handles.eq_scrl_pnl = ScrollPanel('Units', 'pixels', ...
		'Position', [10 240 330 160], 'ScrollArea', [0 0 330 160]);
	handles.var_scrl_pnl = ScrollPanel('Units', 'pixels', ...
		'Position', [350 270 310 130], 'ScrollArea', [0 0 0 0]);
	handles.rslt_scrl_pnl = ScrollPanel('Units', 'pixels', ...
		'Position', [10 10 650 210], 'ScrollArea', [0 0 0 0]);
	handles.dummy_axes = axes('Parent', handles.rslt_scrl_pnl.handle, ...
		'Tag', 'dummy_axes', 'Visible', 'off', 'Units', 'points', ...
		'Position', [0 0 1 1]);
	guidata(hObject, handles);
	
	itr_count_input_Callback(handles.itr_count_input, eventdata, handles);
	reset_btn_Callback(handles.reset_btn, eventdata, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = ch2_fig3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

% --------------------------------------------------------------------
function gnrt_latex_code_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to gnrt_latex_code_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function itr_count_input_Callback(hObject, eventdata, handles)
% hObject    handle to itr_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global itr_count;

	if isempty(get(hObject,'String'))
		set(hObject,'String', '0');
	end

	try
		itr_count = double(sym(get(hObject, 'string')));
		if itr_count <= 0 || mod(itr_count, 1)
			throw;
		end
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
	end
end

% --- Executes during object creation, after setting all properties.
function itr_count_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itr_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empt4y - handles not created until after all CreateFcns called
	if ispc && isequal(get(hObject,'BackgroundColor'), ...
			get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
end

% --- Executes on button press in iterate_btn.
function iterate_btn_Callback(hObject, eventdata, handles)
% hObject    handle to iterate_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global itr_count;
	doStep(hObject, handles, itr_count);
end

% --- Executes on button press in single_step_btn.
function single_step_btn_Callback(hObject, eventdata, handles)
% hObject    handle to single_step_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	doStep(hObject, handles, 1);
end

% --- Executes on button press in reset_btn.
function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global eq_input_count;
	global error_count;
	global cur_step;
	global vars;
	global X_i;
	global F_i;
	
	error_count = 0;
	
	if cur_step == 1
		children = allchild(handles.eq_scrl_pnl.handle);
		for i = 1:length(children)
			delete(children(i));
		end
		children = allchild(handles.var_scrl_pnl.handle);
		for i = 1:length(children)
			delete(children(i));
		end
		set(handles.rslt_scrl_pnl, 'ScrollArea', [0 0 0 0]);

		eq_input_count = 0;
		set(handles.eq_scrl_pnl, 'ScrollArea', [0 0 310 50]);
		handles.eq_input1 = new_eq_input(handles);
		guidata(hObject, handles);
		
		vars = containers.Map();
		% for the equation not being provided.
		setErronous(handles.eq_input1, handles);
	else
		cur_step = 1;
		
		children = allchild(handles.eq_scrl_pnl.handle);
		for i = 1:length(children)
			set(children(i), 'Enable', 'on');
		end
		children = allchild(handles.var_scrl_pnl.handle);
		for i = 1:length(children)
			set(children(i), 'Enable', 'on');
		end
	end
	
	children = allchild(handles.eq_scrl_pnl.handle);
	for i = 1:length(children)
		eq_input_Callback(children(i), eventdata, handles);
	end
	children = allchild(handles.var_scrl_pnl.handle);
	for i = 1:length(children)
		if ~isempty(regexp(get(children(i), 'tag'), 'var_input\d+', 'once'))
			var_input_Callback(children(i), eventdata, handles);
		end
	end
	
	children = allchild(handles.dummy_axes);
	for i = 1:length(children)
		delete(children(i));
	end
	X_i = [];
	F_i = [];
end

function var_input_Callback(hObject, eventdata, handles)
	global vars;
	
	try
		value = double(sym(get(hObject, 'String')));
		
		userdata = get(hObject, 'Userdata');
		name = userdata.name;
		old_var = vars(name);
		old_var.value = value;
		vars(name) = old_var;
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
	end
end

function eq_input_Callback(hObject, eventdata, handles)
	global eq_input_count;
	userdata = get(hObject, 'Userdata');
	
	if userdata.ind == eq_input_count
		if ~isempty(get(hObject, 'String'))
			add_eq_input(eventdata, handles);
		end
	elseif isempty(get(hObject, 'String'))
		delete_eq_input(hObject, handles);
		return;
	end
	
	if ~isempty(get(hObject, 'String'))
		try
			equation = sym(get(hObject,'String'));
			update_vars(hObject, handles);
			ud = get(hObject, 'Userdata');
			ud.equation = equation;
			set(hObject, 'Userdata', ud);
			clearErronous(hObject, handles);
		catch err
			setErronous(hObject, handles);
		end
	end
end

function clearErronous(hObject, handles)
	global error_count;
	if isequal(get(hObject, 'ForegroundColor'), [0.8, 0, 0])
		set(hObject, 'ForegroundColor', [0 0 0]);
		error_count = error_count - 1;
		if error_count == 0
			set(handles.single_step_btn, 'Enable', 'on');
			set(handles.iterate_btn, 'Enable', 'on');
		end
	end
end

function setErronous(hObject, handles)
	global error_count;
	if isequal(get(hObject, 'ForegroundColor'), [0, 0, 0])
		error_count = error_count + 1;
		set(hObject, 'ForegroundColor', [0.8 0 0]);
		set(handles.single_step_btn, 'Enable', 'off');
		set(handles.iterate_btn, 'Enable', 'off');
	end
end

function add_eq_input(eventdata, handles)
	global eq_input_count;
	
	scroll_area = get(handles.eq_scrl_pnl, 'ScrollArea');
	position = get(handles.eq_scrl_pnl, 'Position');
	scroll_area(4) = max(20+30*eq_input_count, position(4));
	set(handles.eq_scrl_pnl, 'ScrollArea', scroll_area);
	handles.(sprintf('eq_input%d', eq_input_count)) = new_eq_input(handles);
	
	if eq_input_count == 2
		children = allchild(handles.eq_scrl_pnl.handle);
		for i = 1:length(children)
			child_userdata = get(children(i), 'Userdata');
			if child_userdata.ind == 1
				first_eq_input = children(i);
				break;
			end
		end
		
		try
			sym(get(first_eq_input,'String'));
			clearErronous(first_eq_input, handles);
		catch err
		end
	end
end

function delete_eq_input(eq_input, handles)
	global eq_input_count;
	userdata = get(eq_input, 'Userdata');
	
	children = allchild(handles.eq_scrl_pnl.handle);
	for i = 1:length(children)
		child = children(i);
		child_userdata = get(child, 'Userdata');
		if child_userdata.ind > userdata.ind
			child_userdata.ind = child_userdata.ind - 1;
			set(child, 'Userdata', child_userdata, 'Position', ...
				[10 child_userdata.ind*30-20 310 22]);
		end
	end
	delete(eq_input);
	eq_input_count =  eq_input_count - 1;

	if eq_input_count == 1
		setErronous(children(1), handles);
	end
end

function update_vars(eq_input, handles)
	global vars;
	new_vars = symvar(sym(get(eq_input, 'String')));
	for i = 1:length(new_vars)
		if vars.isKey(char(new_vars(i)))
			v = vars(char(new_vars(i)));
			vars(char(new_vars(i))) = struct('count', v.count + 1, 'value', 0);
		else
			vars(char(new_vars(i))) = struct('count', 1, 'value', 0);
		end
	end
	userdata = get(eq_input, 'Userdata');
	old_vars = symvar(userdata.equation);
	for i = 1:length(old_vars)
		v = vars(char(old_vars(i)));
		if v.count > 1
			vars(char(old_vars(i))) = ...
				struct('count', v.count - 1, 'value', v.value);
		else
			vars.remove(char(old_vars(i)));
		end
	end
	
	var_inputs = allchild(handles.var_scrl_pnl.handle);
	for i = 1:length(var_inputs)
		clearErronous(var_inputs(i), handles);
		delete(var_inputs(i));
	end
	keys = vars.keys;
	for i = 1:length(keys)
		uicontrol(handles.ch2_fig3, 'Style', 'edit', ...
			'Tag', sprintf('var_input%d', i), 'Units', 'pixels', ...
			'Parent', handles.var_scrl_pnl.handle, 'Visible', 'on', ...
			'Position', [85 i*30-20 220 22], ...
			'String', sprintf('%g', vars(char(keys(i))).value),...
			'Userdata', struct('name', keys(i)), 'Callback', ...
			@(hObject, eventdata)var_input_Callback(hObject, eventdata, ...
			guidata(hObject)));
		uicontrol(handles.ch2_fig3, 'Style', 'text', 'String', keys(i), ...
			'Tag', sprintf('var_text%d', i), 'Units', 'pixels', ...
			'Parent', handles.var_scrl_pnl.handle, 'Visible', 'on', ...
			'Position', [10 i*30-20 65 22]);
	end
	guidata(handles.ch2_fig3, handles);
end

function eq_input = new_eq_input(handles)
	global eq_input_count;
	eq_input_count = eq_input_count + 1;
	eq_input = uicontrol(handles.ch2_fig3, 'Style', 'edit', ...
		'Tag', sprintf('eq_input%d', eq_input_count), ...
		'Parent', handles.eq_scrl_pnl.handle, 'Units', 'pixels', ...
		'Position', [10 eq_input_count*30-20 310 22], 'Visible', 'on', ...
		'Userdata', struct('ind', eq_input_count, 'equation', nan), ...
		'Callback', @(hObject, eventdata)eq_input_Callback(hObject, ...
		eventdata, guidata(hObject)));
	guidata(handles.ch2_fig3, handles);
end

function doStep(hObject, handles, itr_count)
	global cur_step;
	global vars;
	
	if cur_step == 1
		children = allchild(handles.eq_scrl_pnl.handle);
		for i = 1:length(children)
			set(children(i), 'Enable', 'off');
		end
		children = allchild(handles.var_scrl_pnl.handle);
		for i = 1:length(children)
			set(children(i), 'Enable', 'off');
		end
	end
	
	userdata = get(handles.ch2_fig3, 'Userdata');
	algorithm = userdata.algorithm;
	verifier = userdata.verifier;
	variable_names = vars.keys;
	variable_values = zeros(vars.length, 1);
	for i = 1:vars.length
		variable_values(i) = vars(char(variable_names(i))).value;
	end
	
	if ~verifier(algorithm, variable_names, variable_values)
		if strcmp('No', questdlg(['Your provided information do not ' ...
				'guarantee the algorithm to converge. Do you still ' ...
				'want to proceed?'], 'Continue?', 'Yes', 'No', 'No'))
			return;
		end
	end
	
	children = allchild(handles.eq_scrl_pnl.handle);
	equations = sym(zeros(length(children) - 1, 1));
	j = 1;
	for i = 1:length(children)
		if ~isempty(get(children(i), 'String'))
			equations(j) = sym(get(children(i), 'String'));
			j = j + 1;
		end
	end
	
	axes(handles.dummy_axes);
	for i = 1:itr_count
		variable_values = compute(algorithm, equations, variable_names, ...
			variable_values);
		
		% print
		str = sprintf('$i=%d$,', cur_step);
		precision = 4;
		for j = 1:vars.length
			str = [str sprintf(sprintf('$%%s=%%.%dg$,', precision), ...
				char(variable_names(j)), variable_values(j))];
		end
		str = str(1:end-1);
		
		h = text(10, (cur_step - 1) * 25, str, 'Units', 'pixels', ...
			'Tag', sprintf('s_text%d', cur_step), 'interpreter', 'latex', ...
			'FontSize', 20);
		scroll_area = get(handles.rslt_scrl_pnl, 'ScrollArea');
		text_extent = get(h, 'extent');
		scroll_area(3) = max(scroll_area(3), text_extent(1) + text_extent(3));
		scroll_area(4) = max(scroll_area(4), text_extent(2) + text_extent(4));
		set(handles.rslt_scrl_pnl, 'ScrollArea', scroll_area);
	end
	map = containers.Map(variable_names, variable_values);
	for i = 1:vars.length
		vars(char(variable_names(i))) = ...
			struct('count', vars(char(variable_names(i))).count, ...
			'value', map(char(variable_names(i))));
	end
end

function variable_values = compute(algorithm, equations, variable_names, ...
		variable_values)
	global X_i;
	global F_i;
	global cur_step;

	variable_values = algorithm(equations, variable_names, variable_values);
	X_i(:, cur_step) = variable_values;
	F_i(:, cur_step) = subs(equations, variable_names, variable_values);
	cur_step = cur_step + 1;
end
