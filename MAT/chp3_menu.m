%% dont touch stuff
function varargout = chp3_menu(varargin)
% CHP3_MENU MATLAB code for chp3_menu.fig
%      CHP3_MENU, by itself, creates a new CHP3_MENU or raises the existing
%      singleton*.
%
%      H = CHP3_MENU returns the handle to a new CHP3_MENU or the handle to
%      the existing singleton*.
%
%      CHP3_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHP3_MENU.M with the given input arguments.
%
%      CHP3_MENU('Property','Value',...) creates a new CHP3_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chp3_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chp3_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help chp3_menu

	% Last Modified by GUIDE v2.5 13-Nov-2013 15:58:20

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @chp3_menu_OpeningFcn, ...
					   'gui_OutputFcn',  @chp3_menu_OutputFcn, ...
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

% --- Executes during object creation, after setting all properties.
function evaluate_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to evaluate_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
end

% --- Outputs from this function are returned to the command line.
function varargout = chp3_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

%% initialization
% --- Executes just before chp3_menu is made visible.
function chp3_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chp3_menu (see VARARGIN)
	import ch3.interpolation.*

	% Choose default command line output for chp3_menu
	handles.output = hObject;

	% UIWAIT makes chp3_menu wait for user response (see UIRESUME)
	% uiwait(handles.chp3_menu);
	
	handles.points_scrl_pnl = ScrollPanel();
	set(handles.points_scrl_pnl,'Units', 'pixels', 'ScrollMode', 'verticle', ...
		'Position', [105 365 195 75], 'ScrollArea', [0 0 195 75]);
	set(handles.input_pnl, 'SelectionChangeFcn', ...
		@(hObject, eventdata)input_pnl_SelectionChangeFcn(hObject, ...
		eventdata, guidata(hObject)));
	set(handles.fitting_pnl, 'SelectionChangeFcn', ...
		@(hObject, eventdata)fitting_pnl_SelectionChangeFcn(hObject, ...
		eventdata, guidata(hObject)));
	guidata(hObject, handles);
	
	set(handles.lagrange_rdbtn, 'Userdata', ...
		struct('type', 'interpolation', 'equally_spaced', false, ...
		'algorithm', @lagrange));
	set(handles.ndd_rdbtn, 'Userdata', ...
		struct('type', 'interpolation', 'equally_spaced', false, ...
		'algorithm', @NDD));
	set(handles.nfd_rdbtn, 'Userdata', ...
		struct('type', 'interpolation', 'equally_spaced', true, ...
		'algorithm', @NF));
	set(handles.nbd_rdbtn, 'Userdata', ...
		struct('type', 'interpolation', 'equally_spaced', true, ...
		'algorithm', @NB));
	set(handles.nfcd_rdbtn, 'Userdata', .../mnt/data/E-Books/Edu/SUT/Sem_5/Numerical_Methods/Project/Numerical-Method-Project/MAT
		struct('type', 'interpolation', 'equally_spaced', true));
	set(handles.nbcd_rdbtn, 'Userdata', ...
		struct('type', 'interpolation', 'equally_spaced', true));
	set(handles.curve1, 'Userdata', struct('type', 'fitting'));
	set(handles.curve2, 'Userdata', struct('type', 'fitting'));
	set(handles.curve3, 'Userdata', struct('type', 'fitting'));
	set(handles.curve4, 'Userdata', struct('type', 'fitting'));
	set(handles.curve5, 'Userdata', struct('type', 'fitting'));
	
	axes(handles.axes1);
	set(datacursormode(hObject), 'Enable', 'off', 'DisplayStyle', 'datatip', ...
		'SnapToDataVertex', 'on');
	set(pan(hObject), 'Enable', 'off', 'Motion', 'horizontal', ...
		'ActionPostCallback', @(obj, event_obj)redraw(handles.axes1, ...
		event_obj, handles));
	set(zoom(hObject), 'Enable', 'off', 'RightClickAction', 'InverseZoom', ...
		'ActionPostCallback', @(obj, event_obj)redraw(handles.axes1, ...
		event_obj, handles));
	
	reset_btn_Callback(handles.reset_btn, eventdata, handles);
end

%% callbacks
function input_pnl_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to input_pnl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles fittingand user data (see GUIDATA)
	if get(hObject, 'SelectedObject') == handles.function_rdbtn
		% disable and clear errors of points_scr_pnl
		children = allchild(handles.points_scrl_pnl.handle);
		for i = 1:length(children)
			child_userdata = get(children(i), 'Userdata');
			if child_userdata.type == 'y'
				clearErronous(children(i), handles);
				set(children(i), 'Enable', 'off');
			end
		end
		
		% enable and check for errors of eq_input
		set(handles.eq_input, 'Enable', 'on');
		eq_input_Callback(handles.eq_input, eventdata, handles);
	else
		% disable and clear errors of eq_input
		clearErronous(handles.eq_input, handles);
		set(handles.eq_input, 'Enable', 'off');
		
		% enable and check for errors of points_scr_pnl
		children = allchild(handles.points_scrl_pnl.handle);
		for i = 1:length(children)
			child_userdata = get(children(i), 'Userdata');
			if child_userdata.type == 'y'
				set(children(i), 'Enable', 'on');
				point_input_Callback(children(i), eventdata, handles);
			end
		end
	end
end

function evaluate_input_Callback(hObject, eventdata, handles)
% hObject    handle to evaluate_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	try
		str = get(hObject, 'String');
		if isempty(str)
			throw();
		end
		double(sym(str));
		set(handles.evaluate_btn, 'Enable', 'on');
		set(handles.evaluate_input, 'Foreground', [0 0 0]);
	catch err
		set(handles.evaluate_input, 'Foreground', [0.8 0 0]);
		set(handles.evaluate_btn, 'Enable', 'off');
	end
end

function eq_input_Callback(hObject, eventdata, handles)
% hObject    handle to eq_input (seeGCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	try
		func = sym(get(hObject, 'String'));
		if length(symvar(func)) > 1
			throw();
		end
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
	end
end

function point_input_Callback(hObject, eventdata, handles)
% hObject    handle to point_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global point_count;
	userdata = get(hObject, 'Userdata');
	
	try
		str = get(hObject, 'String');
		if isempty(str) && (userdata.ind ~= point_count || userdata.ind == 1)
			throw();
		end
		val = double(sym(str));
		if ~isfinite(val)
			throw();
		end
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
	end
	
	userdata = get(hObject, 'Userdata');
	if userdata.ind == point_count
		if ~isempty(get(hObject, 'String')) || ...
				~isempty(get(userdata.pair, 'String'))
			add_point_input(handles);
			if ~isfield(eventdata, 'propagate') || eventdata.propagate
				eventdata.propagate = false;
				if strcmp(get(userdata.pair, 'Enable'), 'on')
					point_input_Callback(userdata.pair, eventdata, handles);
				end
			end
		end
	elseif isempty(get(hObject, 'String')) && ...
			isempty(get(userdata.pair, 'String'))
		delete_point_input(userdata.ind, handles);
	end
end

function reset_btn_Callback(hObject, eventdata, handles)
% hObject    handle to reset_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global error_count;
	global point_count;
	global X;
	global Y;
	global evaluation_X;
	global evaluation_Y;
	error_count = 0;
	point_count = 0;
	X = [];
	Y = [];
	evaluation_X = [];
	evaluation_Y = [];
	
	set(handles.gnr_latex_code_mnuitm, 'Enable', 'off');
	
	children = allchild(handles.points_scrl_pnl.handle);
	for i = 1:length(children)
		delete(children(i));
	end
	add_point_input(handles);
	handles = guidata(hObject);
	
	if get(handles.input_pnl, 'SelectedObject') == handles.pointset_rdbtn
		point_input_Callback(handles.x_input1, eventdata, handles);
		point_input_Callback(handles.y_input1, eventdata, handles);
	else
		eq_input_Callback(handles.eq_input, eventdata, handles);
	end
	
	set(handles.evaluate_input, 'Enable', 'off');
	set(handles.evaluate_btn, 'Enable', 'off');
	
	axes(handles.axes1);
	cla;
	set(datacursormode(handles.chp3_menu), 'Enable', 'off');
	set(pan(handles.chp3_menu), 'Enable', 'off');
	set(zoom(handles.chp3_menu), 'Enable', 'off');
end

function go_btn_Callback(hObject, eventdata, handles)
% hObject    handle to go_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global X;
	global Y;
	global fitted_func;

	selected = get(handles.fitting_pnl, 'SelectedObject');
	userdata = get(selected, 'Userdata');
	X = getX(handles);
	
	% check if equally-spacedness condition is vaiolated.
	if strcmp(userdata.type, 'interpolation') && userdata.equally_spaced && ...
			~is_equally_spaced(X)
		errordlg(['The provided data points are not equally spaced, but ', ...
			'your chosen algorithm depends on them being so. Please either', ...
			' choose another method or provide appropriate data points.'], ...
			'Not equally spaces!');
		return;
	end
	
	algorithm = userdata.algorithm;
	Y = getY(handles);
	fitted_func = algorithm(X, Y);
	
	set(handles.gnr_latex_code_mnuitm, 'Enable', 'on');
	set(handles.evaluate_input, 'Enable', 'on');
	evaluate_input_Callback(handles.evaluate_input, eventdata, handles);
	redraw(handles.axes1, eventdata, handles);
	if strcmp(get(handles.zoom_mnuitm, 'Checked'), 'on')
		set(zoom(handles.chp3_menu), 'Enable', 'on');
	elseif strcmp(get(handles.pan_mnuitm, 'Checked'), 'on')
		set(pan(handles.chp3_menu), 'Enable', 'on');
	else
		est(datacursormode(handles.chp3_menu), 'Enable', 'on');
	end
end

% --- Executes on button press in evaluate_btn.
function evaluate_btn_Callback(hObject, eventdata, handles)
% hObject    handle to evaluate_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global evaluation_X;
	global evaluation_Y;
	global fitted_func;
	
	X = double(sym(get(handles.evaluate_input, 'String')));
	if ~ismember(X, evaluation_X)
		evaluation_X = [evaluation_X X];
		evaluation_Y = [evaluation_Y subs(fitted_func, X)];
		
		XLim = get(handles.axes1, 'XLim');
		XLim = XLim - sum(XLim) / 2 + X;
		set(handles.axes1, 'XLim', XLim);
		redraw(handles.axes1, eventdata, handles);
	end
end

function fitting_pnl_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to fitting_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function gnr_latex_code_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to gnr_latex_code_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global fitted_func;
	global evaluation_X;
	global evaluation_Y;
	precision = 4;
	
	var_name = char(get_var_name(handles));
	code = sprintf(...
		'$$f(%s)=%s$$ \\hspace{30pt} \n\n', ...
		var_name, latex(fitted_func)); 
	if ~isempty(evaluation_X)
		code = [code, sprintf([...
			'\\begin{tabular}{|c|c|}\n', ...
			'    \\hline\n', ...
			'    $\\bf{%s}$ & $\\bf{y}$\n', ...
			'    \\\\\\hline\\hline\n'
			], var_name)];
		for i = 1:length(evaluation_X)
			code = [code, sprintf(sprintf([...
				'    $%%.%dg$ & $%%.%dg$\\n', ...
				'    \\\\\\\\\\\\hline\\n' ...
				], precision, precision), evaluation_X(i), evaluation_Y(i))];
		end
		code = [code '\end{tabular}'];
	end
	
	latex_fig('Userdata', code);
end

%% other stuff
function clearErronous(hObject, handles)
	global error_count;
	
	if isequal(get(hObject, 'ForegroundColor'), [0.8, 0, 0])
		set(hObject, 'ForegroundColor', [0 0 0]);
		error_count = error_count - 1;
		if error_count == 0
			set(handles.go_btn, 'Enable', 'on');
		end
	end
end

function setErronous(hObject, handles)
	global error_count;
	
	if isequal(get(hObject, 'ForegroundColor'), [0, 0, 0])
		error_count = error_count + 1;
		set(hObject, 'ForegroundColor', [0.8 0 0]);
		set(handles.go_btn, 'Enable', 'off');
	end
end

function add_point_input(handles)
	global point_count;
	point_count = point_count + 1;
	
	tag_x = sprintf('x_input%d', point_count);
	handles.(tag_x) = uicontrol('Style', 'edit', 'Tag', tag_x, 'String', '', ...
		'Position', [10 25*point_count-20 80 20], 'Units', 'pixels', ...
		'Parent', handles.points_scrl_pnl.handle, 'Callback', @(hObject, ...
		eventdata)point_input_Callback(hObject, eventdata, guidata(hObject)));
	tag_y = sprintf('y_input%d', point_count);
	handles.(tag_y) = uicontrol('Style', 'edit', 'Tag', tag_y, 'String', '', ...
		'Position', [95 25*point_count-20 80 20], 'Units', 'pixels', ...
		'Parent', handles.points_scrl_pnl.handle, 'Callback', @(hObject, ...
		eventdata)point_input_Callback(hObject, eventdata, guidata(hObject)));
	set(handles.(tag_x), 'Userdata', ...
		struct('ind', point_count, 'pair', handles.(tag_y), 'type', 'x'));
	set(handles.(tag_y), 'Userdata', ...
		struct('ind', point_count, 'pair', handles.(tag_x), 'type', 'y'));
	if get(handles.input_pnl, 'SelectedObject') == handles.function_rdbtn
		set(handles.(tag_y), 'Enable', 'off');
	end
	
	scrl_area = get(handles.points_scrl_pnl, 'ScrollArea');
	scrl_area(4) = 25 * point_count + 5;
	set(handles.points_scrl_pnl, 'ScrollArea', scrl_area);
	
	guidata(handles.chp3_menu, handles);
end

function delete_point_input(ind, handles)
	global point_count;
	
	children = allchild(handles.points_scrl_pnl.handle);
	for i = 1:length(children)
		userdata = get(children(i), 'Userdata');
		if userdata.ind == ind
			clearErronous(children(i), handles);
			delete(children(i));
		elseif userdata.ind > ind
			userdata.ind = userdata.ind - 1;
			position = get(children(i), 'Position');
			position(2) = position(2) - 30;
			set(children(i), 'Userdata', userdata, 'Position', position);
		end
	end
	
	point_count = point_count - 1;
	guidata(handles.chp3_menu, handles);
end

function out = is_equally_spaced(X)
	global point_count;
	
	if point_count > 3
		X = sort(X);
		diff = X(2) - X(1);
		for i = 3:length(X)
			if X(i) - X(i - 1) ~= diff
				out = false;
				return;
			end
		end
	end
	out = true;
end

function X = getX(handles)
	global point_count;
	
	children = allchild(handles.points_scrl_pnl.handle);
	X = zeros(point_count - 1, 1);
	j = 1;
	
	for i = 1:length(children)
		child_userdata = get(children(i), 'Userdata');
		if child_userdata.type == 'x'
			temp = get(children(i), 'String');
			if ~isempty(temp)
				X(j) = double(sym(temp));
				j = j + 1;
			end
		end
	end
end

function Y = getY(handles)
	global point_count;
	
	% check if equally-spacedness condition is vaiolated.
	if get(handles.input_pnl, 'SelectedObject') == handles.function_rdbtn
		X = getX(handles);
		Y = double(subs(sym(get(handles.eq_input, 'String')), X));
	else
		children = allchild(handles.points_scrl_pnl.handle);
		Y = zeros(point_count - 1, 1);
		j = 1;
		for i = 1:length(children)
			child_userdata = get(children(i), 'Userdata');
			if child_userdata.type == 'y'
				temp = get(children(i), 'String');
				if ~isempty(temp)
					Y(j) = double(sym(temp));
					j = j + 1;
				end
			end
		end
	end
end

function var = get_var_name(handles)
	if get(handles.input_pnl, 'SelectedObject') == handles.function_rdbtn && ...
			isequal(get(handles.eq_input, 'ForegroundColor'), [0 0 0])
		var = symvar(sym(get(handles.eq_input, 'String')));
	else
		var = sym('x');
	end
end

function redraw(hObject, eventdata, handles)
	global X;
	global Y;
	global evaluation_X;
	global evaluation_Y;
	global fitted_func;
	
	axes(handles.axes1);
	cla;
	hold on;
	plot(X, Y, 'or');
	if ~isempty(evaluation_X)
		plot(evaluation_X, evaluation_Y, 'sk');
	end
	ezplot(fitted_func, get(handles.axes1, 'XLim'));
	title(['$' latex(fitted_func) '$'], 'Interpreter', 'latex', 'FontSize', 15);
end
