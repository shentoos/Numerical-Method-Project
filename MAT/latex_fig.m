function varargout = latex_fig(varargin)
% LATEX_FIG MATLAB code for latex_fig.fig
%      LATEX_FIG, by itself, creates a new LATEX_FIG or raises the existing
%      singleton*.
%
%      H = LATEX_FIG returns the handle to a new LATEX_FIG or the handle to
%      the existing singleton*.
%
%      LATEX_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LATEX_FIG.M with the given input arguments.
%
%      LATEX_FIG('Property','Value',...) creates a new LATEX_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before latex_fig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to latex_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help latex_fig

	% Last Modified by GUIDE v2.5 11-Nov-2013 14:14:41

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @latex_fig_OpeningFcn, ...
					   'gui_OutputFcn',  @latex_fig_OutputFcn, ...
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


% --- Executes just before latex_fig is made visible.
function latex_fig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to latex_fig (see VARARGIN)

	% Choose default command line output for latex_fig
	handles.output = hObject;

	% Update handles structure
	guidata(hObject, handles);

	% UIWAIT makes latex_fig wait for user response (see UIRESUME)
	% uiwait(handles.latex_fig);
	
	sp = ScrollPanel();
	handles.scroll_panel = sp;
	guidata(hObject, handles);
	set(sp,'Units', 'pixels', 'Position', [340 40 320 400], ...
		'ScrollArea', [0 0 320 400]);
	handles.dummy_axes = axes('parent', handles.scroll_panel.handle, ...
		'Visible', 'off', 'Tag', 'dummy_axes', 'Units', 'pixels');
	axes(handles.dummy_axes);
	
	latex_code = get(hObject, 'UserData');
	set(handles.latex_code, 'String', latex_code);
	text_h = text(0, 0, regexprep(latex_code, '\n', ' '), ...
		'Interpreter', 'latex', 'FontSize', 20, 'Units', 'pixels');
	old_scroll_area = get(sp, 'ScrollArea');
	new_scroll_area = get(text_h, 'extent');
	new_scroll_area(1:2)=[0 0];
	new_scroll_area(3) = max(new_scroll_area(3) + 20, old_scroll_area(3));
	new_scroll_area(4) = max(new_scroll_area(4) + 20, old_scroll_area(4));
	set(sp, 'ScrollArea', new_scroll_area);
	set(text_h, 'Position', [-15 new_scroll_area(4)/2-40 0]);
	guidata(hObject, handles);
end


% --- Outputs from this function are returned to the command line.
function varargout = latex_fig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

% --- Executes during object creation, after setting all properties.
function latex_code_CreateFcn(hObject, eventdata, handles)
% hObject    handle to latex_code (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

	if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
		set(hObject,'BackgroundColor','white');
	end
end


% --- Executes on button press in copy_btn.
function copy_btn_Callback(hObject, eventdata, handles)
% hObject    handle to copy_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	str = get(handles.latex_code, 'String');
	line = [];
	for i = 1:size(str, 1)
		line = [line sprintf('\n') regexprep(str(i, :), '\s+$', '')];
	end
	clipboard('copy', line(2:end));
end


% --- Executes on button press in close_btn.
function close_btn_Callback(hObject, eventdata, handles)
% hObject    handle to close_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	delete(handles.latex_fig);
end
