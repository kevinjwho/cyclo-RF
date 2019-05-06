function varargout = gui_test(varargin)
% GUI_TEST MATLAB code for gui_test.fig
%      GUI_TEST, by itself, creates a new GUI_TEST or raises the existing
%      singleton*.
%
%      H = GUI_TEST returns the handle to a new GUI_TEST or the handle to
%      the existing singleton*.
%
%      GUI_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TEST.M wi th the given input arguments.
%
%      GUI_TEST('Property','Value',...) creates a new GUI_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_test

% Last Modified by GUIDE v2.5 04-Apr-2019 10:43:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_test_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_test_OutputFcn, ...
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


% --- Executes just before gui_test is made visible.
function gui_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_test (see VARARGIN)

% Choose default command line output for gui_test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

D = str2double(get(handles.edit57, 'String')); % in in.
n_l = str2double(get(handles.edit58, 'String')); % in turns/1in.
a = D^2 * n_l^2; b = -40*L*10^6; c = -18*D*L*10^6;

l = max(roots([a b c]));
set(handles.edit59, 'String', l);

% --- Outputs from this function are returned to the command line.
function varargout = gui_test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%--------------------
% C_Dee edit field
%--------------------
function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% L edit field
%--------------------
function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

D = str2double(get(handles.edit57, 'String')); % in in.
n_l = str2double(get(handles.edit58, 'String')); % in turns/1in.
a = D^2 * n_l^2; b = -40*L*10^6; c = -18*D*L*10^6;

l = max(roots([a b c]));
set(handles.edit59, 'String', l);

% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% Freq_min edit field
%--------------------
function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% Freq_max edit field
%--------------------
function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% C_min out field
%--------------------
function edit52_Callback(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit52 as text
%        str2double(get(hObject,'String')) returns contents of edit52 as a double


% --- Executes during object creation, after setting all properties.
function edit52_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% C_max out field
%--------------------
function edit53_Callback(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit53 as text
%        str2double(get(hObject,'String')) returns contents of edit53 as a double


% --- Executes during object creation, after setting all properties.
function edit53_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% P edit field
%--------------------
function edit55_Callback(hObject, eventdata, handles)
% hObject    handle to edit55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit55 as text
%        str2double(get(hObject,'String')) returns contents of edit55 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

% --- Executes during object creation, after setting all properties.
function edit55_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% Rs edit field
%--------------------
function edit56_Callback(hObject, eventdata, handles)
% hObject    handle to edit56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit56 as text
%        str2double(get(hObject,'String')) returns contents of edit56 as a double
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

% --- Executes during object creation, after setting all properties.
function edit56_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--------------------
% Generate button field
%--------------------
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C_Dee = str2double(get(handles.edit19, 'String')) * 10^-12; % in F
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
freq_min = str2double(get(handles.edit21, 'String')) * 10^6; % in Hz
freq_max = str2double(get(handles.edit22, 'String')) * 10^6; % in Hz
P = str2double(get(handles.edit55, 'String')); % in W
Rs = str2double(get(handles.edit56, 'String')) * 10^-3; % in Ohm

C_max = (1/(L*(2*pi*freq_min)^2) - C_Dee)*10^12;
C_min = (1/(L*(2*pi*freq_max)^2) - C_Dee)*10^12; % in pF

set(handles.edit52, 'String', C_min);
set(handles.edit53, 'String', C_max);

C_vec = (C_min:((C_max-C_min)/10000):C_max)*10^-12;
V_vec = 2*sqrt(2*P*L./(Rs.*(C_vec+C_Dee)));
freq_vec = 1./(2*pi*sqrt(L*(C_vec+C_Dee))); 
axes(handles.axes1); scatter(C_vec*10^12, V_vec, 1, freq_vec*10^-6); 
grid;
title(['V_{pp} and Freq. vs C_{var} for L = ' num2str(L*10^6) ... 
    'uH, Rs = ' num2str(Rs) 'm\Omega']);
xlabel('C_{var} (pF)'), ylabel('Voltage (V)'); ylim([0 max(V_vec)]);
cb = colorbar; ylabel(cb, 'freq (MHz)');

D = str2double(get(handles.edit57, 'String')); % in in.
n_l = str2double(get(handles.edit58, 'String')); % in turns/1in.
a = D^2 * n_l^2; b = -40*L*10^6; c = -18*D*L*10^6;

l = max(roots([a b c]));
set(handles.edit59, 'String', l);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton2.
function pushbutton2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit57_Callback(hObject, eventdata, handles)
% hObject    handle to edit57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit57 as text
%        str2double(get(hObject,'String')) returns contents of edit57 as a double
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
D = str2double(get(handles.edit57, 'String')); % in in.
n_l = str2double(get(handles.edit58, 'String')); % in turns/1in.
a = D^2 * n_l^2; b = -40*L*10^6; c = -18*D*L*10^6;

l = max(roots([a b c]));
set(handles.edit59, 'String', l);

% --- Executes during object creation, after setting all properties.
function edit57_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit58_Callback(hObject, eventdata, handles)
% hObject    handle to edit58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit58 as text
%        str2double(get(hObject,'String')) returns contents of edit58 as a double
L = str2double(get(handles.edit20, 'String')) * 10^-6; % in H
D = str2double(get(handles.edit57, 'String')); % in in.
n_l = str2double(get(handles.edit58, 'String')); % in turns/1in.
a = D^2 * n_l^2; b = -40*L*10^6; c = -18*D*L*10^6;

l = max(roots([a b c]));
set(handles.edit59, 'String', l);

% --- Executes during object creation, after setting all properties.
function edit58_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit59_Callback(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit59 as text
%        str2double(get(hObject,'String')) returns contents of edit59 as a double


% --- Executes during object creation, after setting all properties.
function edit59_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
