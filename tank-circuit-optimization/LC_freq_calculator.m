function varargout = LC_freq_calculator(varargin)
% LC_FREQ_CALCULATOR MATLAB code for LC_freq_calculator.fig
%      LC_FREQ_CALCULATOR, by itself, creates a new LC_FREQ_CALCULATOR or raises the existing
%      singleton*.
%
%      H = LC_FREQ_CALCULATOR returns the handle to a new LC_FREQ_CALCULATOR or the handle to
%      the existing singleton*.
%
%      LC_FREQ_CALCULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LC_FREQ_CALCULATOR.M with the given input arguments.
%
%      LC_FREQ_CALCULATOR('Property','Value',...) creates a new LC_FREQ_CALCULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LC_freq_calculator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LC_freq_calculator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
findL = false; findC = false; findfreq = false;
L = 0; C = 0; freq = 0;
% Edit the above text to modify the response to help LC_freq_calculator

% Last Modified by GUIDE v2.5 28-Apr-2019 21:15:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LC_freq_calculator_OpeningFcn, ...
                   'gui_OutputFcn',  @LC_freq_calculator_OutputFcn, ...
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


% --- Executes just before LC_freq_calculator is made visible.
function LC_freq_calculator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LC_freq_calculator (see VARARGIN)

% Choose default command line output for LC_freq_calculator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LC_freq_calculator wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end


% --- Outputs from this function are returned to the command line.
function varargout = LC_freq_calculator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
% button values
findL = get(handles.radiobutton1, 'Value'); 
findC = get(handles.radiobutton3, 'Value');
findfreq = get(handles.radiobutton4, 'Value');

% text values
L = str2double(get(handles.edit2, 'String')); % in uH
C = str2double(get(handles.edit3, 'String')); % in pF
freq = str2double(get(handles.edit4, 'String')); % in MHz

% calcs
if findL
    L = 1/(C*10^-12 * (2*pi*freq*10^6)^2) * 10^6; % in uH
    set(handles.edit2, 'String', L);
elseif findC
    C = 1/(L*10^-6 * (2*pi*freq*10^6)^2) *10^12; % in pF
    set(handles.edit3, 'String', C);
elseif findfreq
    freq = 1/(2*pi*sqrt(L*10^-6*C*10^-12)) * 10^-6; % in MHz
    set(handles.edit4, 'String', freq);
end

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
