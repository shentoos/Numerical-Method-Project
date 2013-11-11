function varargout = chp2_menu(varargin)
% CHP2_MENU MATLAB code for chp2_menu.fig
%      CHP2_MENU, by itself, creates a new CHP2_MENU or raises the existing
%      singleton*.
%
%      H = CHP2_MENU returns the handle to a new CHP2_MENU or the handle to
%      the existing singleton*.
%
%      CHP2_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHP2_MENU.M with the given input arguments.
%
%      CHP2_MENU('Property','Value',...) creates a new CHP2_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chp2_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chp2_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

	% Edit the above text to modify the response to help chp2_menu

	% Last Modified by GUIDE v2.5 10-Nov-2013 05:09:05

	% Begin initialization code - DO NOT EDIT
	gui_Singleton = 1;
	gui_State = struct('gui_Name',       mfilename, ...
					   'gui_Singleton',  gui_Singleton, ...
					   'gui_OpeningFcn', @chp2_menu_OpeningFcn, ...
					   'gui_OutputFcn',  @chp2_menu_OutputFcn, ...
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

% --- Executes just before chp2_menu is made visible.
function chp2_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chp2_menu (see VARARGIN)

	% Choose default command line output for chp2_menu
	handles.output = hObject;

	% Update handles structure
	guidata(hObject, handles);

	% UIWAIT makes chp2_menu wait for user response (see UIRESUME)
	% uiwait(handles.chp2_menu);
end

% --- Outputs from this function are returned to the command line.
function varargout = chp2_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

	% Get default command line output from handles structure
	varargout{1} = handles.output;
end

% --- Executes on button press in back_btn.
function back_btn_Callback(hObject, eventdata, handles)
% hObject    handle to back_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global window_stack;
	set(window_stack.pop(), 'Visible', 'on');
	close(handles.chp2_menu);
end

% --- Executes on button press in bisection_btn.
function bisection_btn_Callback(hObject, eventdata, handles)
% hObject    handle to bisection_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch2.bisection;
	import ch2.bolzano_verifier;
	ch2_fig1('UserData', ...
		struct('algorithm', @bisection, 'verifier', @bolzano_verifier));
end

% --- Executes on button press in false_position_btn.
function false_position_btn_Callback(hObject, eventdata, handles)
% hObject    handle to false_position_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch2.false_position;
	import ch2.bolzano_verifier;
	ch2_fig1('UserData', ...
		struct('algorithm', @false_position, 'verifier', @bolzano_verifier));
end

% --- Executes on button press in fixed_point_btn.
function fixed_point_btn_Callback(hObject, eventdata, handles)
% hObject    handle to fixed_point_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in gnr_btn.
function gnr_btn_Callback(hObject, eventdata, handles)
% hObject    handle to gnr_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

% --- Executes on button press in halley_btn.
function halley_btn_Callback(hObject, eventdata, handles)
% hObject    handle to halley_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch2.halley;
	import ch2.no_verifier;
	ch2_fig2('UserData', ...
		struct('algorithm', @halley, 'verifier', @no_verifier));
end

% --- Executes on button press in secant_btn.
function secant_btn_Callback(hObject, eventdata, handles)
% hObject    handle to secant_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch2.false_position;
	import ch2.no_verifier;
	ch2_fig1('UserData', ...
		struct('algorithm', @false_position, 'verifier', @no_verifier));
end

% --- Executes on button press in nr_btn.
function nr_btn_Callback(hObject, eventdata, handles)
% hObject    handle to nr_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	import ch2.newton_raphson;
	import ch2.no_verifier;
	ch2_fig2('UserData', ...
		struct('algorithm', @newton_raphson, 'verifier', @no_verifier));
end
