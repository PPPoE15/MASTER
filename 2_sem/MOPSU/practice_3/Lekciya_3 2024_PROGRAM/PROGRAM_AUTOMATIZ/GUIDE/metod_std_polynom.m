function varargout = metod_std_polynom(varargin)
% METOD_STD_POLYNOM M-file for metod_std_polynom.fig
%      METOD_STD_POLYNOM, by itself, creates a new METOD_STD_POLYNOM or raises the existing
%      singleton*.
%
%      H = METOD_STD_POLYNOM returns the handle to a new METOD_STD_POLYNOM or the handle to
%      the existing singleton*.
%
%      METOD_STD_POLYNOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in METOD_STD_POLYNOM.M with the given input arguments.
%
%      METOD_STD_POLYNOM('Property','Value',...) creates a new METOD_STD_POLYNOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before metod_std_polynom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to metod_std_polynom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help metod_std_polynom

% Last Modified by GUIDE v2.5 27-Mar-2019 22:36:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @metod_std_polynom_OpeningFcn, ...
                   'gui_OutputFcn',  @metod_std_polynom_OutputFcn, ...
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


% --- Executes just before metod_std_polynom is made visible.
function metod_std_polynom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to metod_std_polynom (see VARARGIN)

% Choose default command line output for metod_std_polynom
handles.output = hObject;
handles.calc_on = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes metod_std_polynom wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = metod_std_polynom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function eRank_Callback(hObject, eventdata, handles)
% hObject    handle to eRank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eRank as text
%        str2double(get(hObject,'String')) returns contents of eRank as a double
try    
    n =  eval(get(handles.eRank,'String'));
    if(~isnumeric(n))
        error('Ранг системы должен быть числом!')
    end
    if (n <= 0)
        error('Ранг системы должен быть строго больше нуля');
    end;
    if (round(n)~= n)
        error('Ранг системы должен быть целым числом');
    end;
catch
    errordlg(lasterr);
    set(handles.eXMax,'String','0.05');
end

% --- Executes during object creation, after setting all properties.
function eRank_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eRank (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cbType.
function cbType_Callback(hObject, eventdata, handles)
% hObject    handle to cbType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cbType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cbType


% --- Executes during object creation, after setting all properties.
function cbType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cbType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eTime_Callback(hObject, eventdata, handles)
% hObject    handle to eTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eTime as text
%        str2double(get(hObject,'String')) returns contents of eTime as a double
try    
    t_req      = eval(get(handles.eTime,'String'));
    if(~isnumeric(t_req))
        error('Желаемое время должно быть числом!')
    end
    if (t_req <= 0)
        error('Желаемое время должно быть положительным!');
    end;
catch
    errordlg(lasterr);
    set(handles.eXMax,'String','5');
end

% --- Executes during object creation, after setting all properties.
function eTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ePrecision_Callback(hObject, eventdata, handles)
% hObject    handle to ePrecision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ePrecision as text
%        str2double(get(hObject,'String')) returns contents of ePrecision as a double
try
    acc_req    = eval(get(handles.ePrecision,'String'))*0.01;
    if(~isnumeric(acc_req))
        error('Точность должна  быть числом!')
    end
    if (acc_req > 10 || acc_req < 0)
        error('Точность должна лежать в пределах [0;1o]!');
    end;
catch
    errordlg(lasterr);
    set(handles.eXMax,'String','10');
end

% --- Executes during object creation, after setting all properties.
function ePrecision_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ePrecision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function eStaticCoef_Callback(hObject, eventdata, handles)
% hObject    handle to eStaticCoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eStaticCoef as text
%        str2double(get(hObject,'String')) returns contents of eStaticCoef as a double


% --- Executes during object creation, after setting all properties.
function eStaticCoef_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eStaticCoef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lbRoots.
function lbRoots_Callback(hObject, eventdata, handles)
% hObject    handle to lbRoots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lbRoots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lbRoots


% --- Executes during object creation, after setting all properties.
function lbRoots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lbRoots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btCalc.
function btCalc_Callback(hObject, eventdata, handles)
% hObject    handle to btCalc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.calc_on    = 1;
handles.n          = eval(get(handles.eRank,'String'));
handles.t_req      = eval(get(handles.eTime,'String'));
handles.acc_req    = eval(get(handles.ePrecision,'String'));
handles.poly_type  = get(handles.cbType,'Value');
[handles.roots, handles.b] =...
    GetPolyRoots(handles.n,handles.t_req,handles.acc_req,handles.poly_type );

set(handles.eStaticCoef,'String',num2str(handles.b));
if (size(handles.roots,2) ~= 1)
    handles.roots = handles.roots';
end
roots_Str = strtrim(cellstr(num2str(handles.roots)));
set(handles.lbRoots,'String',roots_Str);
display('---------------------------------------------------');
display('Выполнен расчет со следующими параметрами:')
display(['Порядок полинома: ',num2str(handles.n)]);
Type_names = get(handles.cbType,'String');
display(['Тип: Cтандартный полином ',Type_names{handles.poly_type}]);
display(['Желаемое время перехдного процесса: ',num2str(handles.t_req)]);
display(['Точность установившегося режима: ',num2str(handles.acc_req*100),'%']);
display('---------------------------------------------------');
display('Результаты расчета:');
display(['Статический коэффициент усиления: ', num2str(handles.b)]);
display('Корни полинома: ');
disp(roots_Str);
display('---------------------------------------------------');
guidata(gcbo,handles) 
PlotGraphs(handles)


function PlotGraphs(handles)
if (handles.calc_on ~= 1)
    return;
end;
if (get(handles.cbPlotAll,'Value'))
    Type_names = get(handles.cbType,'String');
    LineWidthes = ones(1,length(Type_names))*2;
    LineWidthes(handles.poly_type) = 3;
    Colors = get(gca,'ColorOrder');
    for i=1:length(Type_names)
        [roots, coeff]=...
            GetPolyRoots(handles.n,handles.t_req,handles.acc_req,i);
        [y,x] = step(zpk([],roots,coeff),handles.t_req*1.5);
        plot(x,y,'LineWidth',LineWidthes(i),'Color', Colors(i,:));
        hold on;
    end
    hold off;
    grid on;
    legend(Type_names,'FontName','ZapfDingbats','Location','Best');
    
else
    Type_names = get(handles.cbType,'String');
    Colors = get(gca,'ColorOrder');
    [y,x] =step(zpk([],handles.roots,handles.b),handles.t_req*1.5);
    plot(x,y,'LineWidth',3,'Color', Colors(handles.poly_type,:));
    grid on
end;


% --- Executes on button press in cbPlotAll.
function cbPlotAll_Callback(hObject, eventdata, handles)
% hObject    handle to cbPlotAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cbPlotAll
PlotGraphs(handles)


% --- Executes on button press in PushOut.
function PushOut_Callback(hObject, eventdata, handles)
% hObject    handle to PushOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('metod_std_polynom');


% --- Executes during object deletion, before destroying properties.
function text2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnFile_Callback(hObject, eventdata, handles)
% hObject    handle to mnFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnFile_OpenPlot_Callback(hObject, eventdata, handles)
% hObject    handle to mnFile_OpenPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnFile_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to mnFile_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on ePrecision and none of its controls.
function ePrecision_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ePrecision (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ePrecision.
function ePrecision_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ePrecision (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
