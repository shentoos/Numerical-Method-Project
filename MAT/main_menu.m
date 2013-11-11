function varargout = main_menu(varargin)
% MAIN_MENU MATLAB code for main_menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*.
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help main_menu

	% Last Modified by GUIDE v2.5 09-Nov-2013 22:14:50

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @main_menu_OpeningFcn, ...
					   'gui_OutputFcn',  @main_menu_OutputFcn, ...
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

% --- Executes just before main_menu is made visible.
function main_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_menu (see VARARGIN)

	% Choose default command line output for main_menu
	handles.output = hObject;

	% Update handles structure
	guidata(hObject, handles);

	% UIWAIT makes main_menu wait for user response (see UIRESUME)
	% uiwait(handles.main_menu);
	
	import datastructures.Stack;
	global window_stack;
	window_stack = Stack();
end

% --- Outputs from this function are returned to the command line.
function varargout = main_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

% --- Executes on button press in chp1_btn.
function chp1_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chp1_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global window_stack;
	window_stack.push(handles.main_menu);
	set(handles.main_menu, 'Visible', 'off');
	chp1_menu;
end

% --- Executes on button press in chp2_btn.
function chp2_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chp2_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global window_stack;
	window_stack.push(handles.main_menu);
	set(handles.main_menu, 'Visible', 'off');
	chp2_menu;
end

% --- Executes on button press in chp4_btn.
function chp4_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chp4_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in chp5_btn.
function chp5_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chp5_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in chp6_btn.
function chp6_btn_Callback(hObject, eventdata, handles)
% hObject    handle to chp6_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --------------------------------------------------------------------
function exit_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	menu_bar.exit_mnuitm_Callback(hObject, eventdata, handles);
end

% --- Executes during object creation, after setting all properties.
function main_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end
