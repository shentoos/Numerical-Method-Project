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

% Last Modified by GUIDE v2.5 10-Nov-2013 05:09:19

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


% --- Executes just before chp1_menu is made visible.
function chp1_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chp1_menu (see VARARGIN)

% Choose default command line output for chp1_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chp1_menu wait for user response (see UIRESUME)
% uiwait(handles.chp1_menu);


% --- Outputs from this function are returned to the command line.
function varargout = chp1_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
