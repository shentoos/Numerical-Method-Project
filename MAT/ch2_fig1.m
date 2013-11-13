function varargout = ch2_fig1(varargin)
% CH2_FIG1 MATLAB code for ch2_fig1.fig
%      CH2_FIG1, by itself, creates a new CH2_FIG1 or raises the existing
%      singleton*.
%
%      H = CH2_FIG1 returns the handle to a new CH2_FIG1 or the handle to
%      the existing singleton*.
%
%      CH2_FIG1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CH2_FIG1.M with the given input arguments.
%
%      CH2_FIG1('Property','Value',...) creates a new CH2_FIG1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ch2_fig1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ch2_fig1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help ch2_fig1

	% Last Modified by GUIDE v2.5 11-Nov-2013 05:11:18

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @ch2_fig1_OpeningFcn, ...
					   'gui_OutputFcn',  @ch2_fig1_OutputFcn, ...
					   'gui_LayoutFcn',  [] , ...
					   'gui_Callback',   []);
	if nargin && ischar(varargin{1})
		gui_State.gui_Callback = str2func(varargin{1});
	end

	if nargout
		[varargout{:}] = gui_mainfcn(gui_State, varargin{:});
	else
		gui_mainfcn(gui_State, varargin{:});
	end
	% End initialization code - DO NOT EDIT	
end

% --- Executes just before ch2_fig1 is made visible.
function ch2_fig1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ch2_fig1 (see VARARGIN)

	% Choose default command line output for ch2_fig1
	handles.output = hObject;

	% Update handles structure
	guidata(hObject, handles);

	% UIWAIT makes ch2_fig1 wait for user response (see UIRESUME)
	% uiwait(handles.ch2_fig1);
	
	sp=ScrollPanel();
	handles.scroll_panel=sp;
	guidata(hObject, handles);
	set(sp,'Units', 'pixels', 'Position', [10 10 300 300]);
	handles.dummy_axes = axes('parent', handles.scroll_panel.handle, ...
		'Visible', 'off', 'Tag', 'dummy_axes');
	guidata(hObject, handles);
	
	axes(handles.axes1);
	set(handles.dummy_axes, 'Units', 'points', 'Position', [0 0 1 1]);
	set(datacursormode, 'Enable', 'off', 'DisplayStyle', 'datatip', ...
		'SnapToDataVertex', 'on');
	set(pan, 'Enable', 'off', 'Motion', 'horizontal', 'ActionPostCallback', ...
		@(obj, event_obj)redraw(handles.axes1, obj, event_obj));
	set(zoom, 'Enable', 'off', 'RightClickAction', 'InverseZoom', ...
		'ActionPostCallback', ...
		@(obj, event_obj)redraw(handles.axes1, obj, event_obj));
	
	global error_count;		% number of erronous user inputs
	error_count = 0;
	reset_btn_Callback(handles.reset_btn, eventdata, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = ch2_fig1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

function eq_input_Callback(hObject, eventdata, handles)
% hObject    handle to eq_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	global equation;
	
	if isempty(get(hObject,'String'))
		set(hObject,'String', '0');
	end
	
	try
		equation = sym(get(hObject,'String'));
		if length(symvar(equation)) > 1
			throw;
		end
		clearErronous(hObject, handles);
	catch err
		setErronous(hObject, handles);
		equation = sym(nan);
	end
end

function rng_start_input_Callback(hObject, eventdata, handles)
% hObject    handle to rng_start_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global range_start;
	global range_end;
	
	if isempty(get(hObject,'String'))
		set(hObject,'String', '0');
	end
	
	try
		range_start = double(sym(get(hObject,'String')));
		if isfinite(range_start) && ...
				(~isfinite(range_end) || range_start < range_end)
			clearErronous(hObject, handles);
		else
			setErronous(hObject, handles);
		end
		if ~isfield(eventdata, 'propagate') || eventdata.propagate == 1
			eventdata.propagate = 0;
			rng_end_input_Callback(handles.rng_end_input, eventdata, handles);
		end
	catch err
		setErronous(hObject, handles);
		range_start = nan;
	end
end

function rng_end_input_Callback(hObject, eventdata, handles)
% hObject    handle to rng_end_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global range_start;
	global range_end;
	
	if isempty(get(hObject,'String'))
		set(hObject,'String', '0');
	end
	
	try
		range_end = double(sym(get(hObject,'String')));
		if isfinite(range_end) && ...
				(~isfinite(range_start) || range_start < range_end)
			clearErronous(hObject, handles);
		else
			setErronous(hObject, handles);
		end
		if ~isfield(eventdata, 'propagate') || eventdata.propagate == 1
			eventdata.propagate = 0;
			rng_start_input_Callback(handles.rng_start_input, eventdata, ...
				handles);
		end
	catch err
		range_end = nan;
		setErronous(hObject, handles);
	end
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

% --- Executes when ch2_fig1 is resized.
function ch2_fig1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to ch2_fig1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	pos = get(handles.ch2_fig1, 'Position');
	set(handles.axes1, 'Position', [360 20 pos(3)-375 pos(4)-57]);
	set(handles.input, 'Position', [10 pos(4)-120 320 110]);
	set(handles.scroll_panel, 'Position', [12 10 317 pos(4)-140]);
	set(handles.scroll_panel, 'ScrollArea', [0 0 300 0]);
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
	global a_i;				% array of range_starts
	global b_i;				% array of range_ends
	global x_i;				% array of approximated roots
	global cur_step;		% current step

	a_i = [];
	b_i = [];
	x_i = [];
	cur_step = 1;

	children = allchild(handles.dummy_axes);
	for i = 1:length(children)
		if ~isempty(regexp(get(children(i), 'tag'), 'x_\d+', 'once'))
			delete(children(i));
		end
	end

	set(handles.eq_input, 'Enable', 'on');
	set(handles.rng_start_input, 'Enable', 'on');
	set(handles.rng_end_input, 'Enable', 'on');
	set(handles.itr_count_input, 'Enable', 'on');
	set(handles.gnrt_latex_code_mnuitm, 'Enable', 'off');
	set(datacursormode(handles.ch2_fig1), 'Enable', 'off');
	pan(handles.ch2_fig1, 'off');
	zoom(handles.ch2_fig1, 'off');
	set(handles.scroll_panel, 'ScrollArea', [0 0 300 0]);
	cla(handles.axes1);

	eventdata.propagate = 0;
	itr_count_input_Callback(handles.itr_count_input, eventdata, handles);
	eq_input_Callback(handles.eq_input, eventdata, handles);
	rng_start_input_Callback(handles.rng_start_input, eventdata, handles);
	rng_end_input_Callback(handles.rng_end_input, eventdata, handles);
end

function doStep(hObject, handles, itr_count)
	import util.double2latex;
	global range_start;
	global range_end;
	global root;
	global a_i;
	global b_i;
	global x_i;
	global cur_step;
	global equation;
	struct = get(handles.ch2_fig1, 'UserData');
	algorithm = struct.algorithm;
	
	if cur_step == 1
		if ~struct.verifier(equation, range_start, range_end)
			if strcmp('No', questdlg(['Your provided information do not ' ...
					'guarantee the algorithm to converge. Do you still ' ...
					'want to proceed?'], 'Continue?', 'Yes', 'No', 'No'))
				return;
			end
		end
		
		set(handles.eq_input, 'Enable', 'off');
		set(handles.rng_start_input, 'Enable', 'off');
		set(handles.rng_end_input, 'Enable', 'off');
		set(handles.gnrt_latex_code_mnuitm, 'Enable', 'on');
		
		if strcmp(get(handles.data_cursor_mode_mnuitm, 'Checked'), 'on')
			set(datacursormode(handles.ch2_fig1), 'Enable', 'on');
		elseif strcmp(get(handles.pan_mnuitm, 'Checked'), 'on')
			pan(handles.ch2_fig1, 'on');
		else
			zoom(handles.ch2_fig1, 'on');
		end
	end

	axes(handles.dummy_axes);
	for i = 1:itr_count
		[range_start range_end root] = ...
			compute(range_start, range_end, algorithm);
		tag = sprintf('x_%d', cur_step - 1);
		precision = 16;
		str = [sprintf(' $x_{%d}=$ ', cur_step - 1), ...
			double2latex(x_i(cur_step - 1), precision), ...
			sprintf(' $, a_{%d}=$ ', cur_step - 1), ...
			double2latex(a_i(cur_step - 1), precision), ...
			sprintf(' $, b_{%d}=$ ', cur_step - 1), ...
			double2latex(b_i(cur_step - 1), precision)];
		h = text(10, (cur_step - 1) * 25, str, 'Tag', tag, ...
			'Units', 'pixels', 'interpreter', 'latex', 'FontSize', 20);
		scroll_area = get(handles.scroll_panel, 'ScrollArea');
		text_extent = get(h, 'extent');
		scroll_area(3) = max(scroll_area(3), text_extent(1) + text_extent(3));
		scroll_area(4) = max(scroll_area(4), text_extent(2) + text_extent(4));
		set(handles.scroll_panel, 'ScrollArea', scroll_area);
	end
	axes(handles.axes1);
	cla;
	hold on;
	x_lim = get(handles.axes1, 'XLim');
	h = ezplot(equation, root - sum(x_lim)/2 + x_lim);
	var = symvar(equation);
	for i = 1:(cur_step - 1)
		plot(x_i, subs(equation, var(1), x_i), 'o-k');
	end
	set(h, 'Color', 'green');
	set(h, 'LineStyle', '--');
	plot(range_start, subs(equation, var(1), range_start), '<-r');
	plot(range_end, subs(equation, var(1), range_end), '>-r');
	plot(root, subs(equation, var(1), root), '*-b');
	title(['$' latex(simple(equation)) '$'], 'Interpreter', 'latex', ...
		'FontSize', 20);
end

function [range_start range_end root] = ...
		compute(range_start, range_end, algorithm)
	global a_i;
	global b_i;
	global x_i;
	global cur_step;
	global equation;

	a_i(cur_step) = range_start;
	b_i(cur_step) = range_end;
	[range_start range_end root] = algorithm(equation, range_start, range_end);
	x_i(cur_step) = root;
	cur_step = cur_step + 1;
end

function redraw(axes1, obj, event_obj)
	global range_start;
	global range_end;
	global root;
	global equation;
	global x_i;
	global cur_step
	
	axes(axes1);
	cla;
	hold on;
	var = symvar(equation);
	for i = 1:cur_step-1
		plot(x_i, subs(equation, var(1), x_i), 'o-k');
	end
	h = ezplot(equation, get(axes1, 'XLim'));
	set(h, 'Color', 'green');
	set(h, 'LineStyle', '--');
	plot(range_start, subs(equation, var(1), range_start), '<-r');
	plot(range_end, subs(equation, var(1), range_end), '>-r');
	plot(root, subs(equation, var(1), root), '*-b');
	title(['$' latex(simple(equation)) '$'], 'Interpreter', 'latex', ...
		'FontSize', 20);
end

% --------------------------------------------------------------------
function gnrt_latex_code_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to gnrt_latex_code_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import util.double2latex;
	global cur_step;
	global a_i;
	global b_i;
	global x_i;
	
	precision = 4;
	
	code = sprintf([
		'\\begin{tabular}{|c|c|c|c|}\n'...
		'    \\hline\n'...
		'    $\\bf{i}$ & $\\bf{a_i}$ & $\\bf{b_i}$ & $\\bf{x_i}$\n'...
		'    \\\\\\hline\\hline\n'...
		]);
	for i = 1:cur_step-1
		code = [code, sprintf('    $%d$ & ', i), ...
			double2latex(a_i(i), precision), ' & ', ...
			double2latex(b_i(i), precision), ' & ', ...
			double2latex(x_i(i), precision), sprintf('\n    \\\\\\hline\n')];
	end
	code = [code '\end{tabular}'];
	
	latex_fig('UserData', code);
end
