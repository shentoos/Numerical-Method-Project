function varargout = menu_bar(varargin)
	if nargin >= 1
		func = str2func(varargin{1});
		[varargout{1:nargout}] = func(varargin{2:end});
	else
		error('Too few arguments');
	end
end

function help_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to help_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function about_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to about_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	msgbox({['\textbf{Brought to you by' ...
		'$\beta\Lambda\subset\kappa\int\iota\alpha^s_h $ $\aleph$ team}:'], ...
		'\textit{Amir Alam~ol~hoda}', '\textit{Ali Shameli}', ...
		'\textit{Mohammad Motiei}', '\textit{Sahand Mozaffari}'}, 'About', ...
		'custom', imread('../img/logo.png'), [], ...
		struct('Interpreter', 'latex', 'WindowStyle', 'replace'));
end

function prf_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to prf_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function imprt_prf_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to imprt_prf_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function exprt_prf_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exprt_prf_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end

function exit_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	global window_stack;
	while ~window_stack.isempty()
		close(window_stack.pop());
	end
	close(handles.main_menu);
end

function data_cursor_mode_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	figure = gcf;
	if strcmp(get(pan(figure), 'Enable'), 'on') || ...
			strcmp(get(zoom(figure), 'Enable'), 'on');
		datacursormode(figure, 'on');
	end

	pan(figure, 'off');
	zoom(figure, 'off');
	
	set(handles.data_cursor_mode_mnuitm, 'Checked', 'on');
	set(handles.pan_mnuitm, 'Checked', 'off');
	set(handles.zoom_mnuitm, 'Checked', 'off');
end

function pan_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	figure = gcf;
	if strcmp(get(datacursormode(figure), 'Enable'), 'on') || ...
			strcmp(get(zoom(figure), 'Enable'), 'on');
		pan(figure, 'on');
	end

	datacursormode(figure, 'off');
	zoom(figure, 'off');
	
	set(handles.data_cursor_mode_mnuitm, 'Checked', 'off');
	set(handles.pan_mnuitm, 'Checked', 'on');
	set(handles.zoom_mnuitm, 'Checked', 'off');
end

function zoom_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
	figure = gcf;
	if strcmp(get(datacursormode(figure), 'Enable'), 'on') || ...
			strcmp(get(pan(figure), 'Enable'), 'on');
		zoom(figure, 'on');
	end

	datacursormode(figure, 'off');
	pan(figure, 'off');
	
	set(handles.data_cursor_mode_mnuitm, 'Checked', 'off');
	set(handles.pan_mnuitm, 'Checked', 'off');
	set(handles.zoom_mnuitm, 'Checked', 'on');
end

function eq_input_mnuitm_Callback(hObject, eventdata, handles)
% hObject    handle to exit_mnuitm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end
