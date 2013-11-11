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

% Last Modified by GUIDE v2.5 10-Nov-2013 05:09:33

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


% --- Executes just before chp3_menu is made visible.
function chp3_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chp3_menu (see VARARGIN)

% Choose default command line output for chp3_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chp3_menu wait for user response (see UIRESUME)
% uiwait(handles.chp3_menu);


% --- Outputs from this function are returned to the command line.
function varargout = chp3_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
