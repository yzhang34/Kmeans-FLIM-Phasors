function varargout = Kmeans_FLIM_Phasors(varargin)
% Kmeans_FLIM_Phasors MATLAB code for Kmeans_FLIM_Phasors.fig
%
%   Author: Yide Zhang
%   Email: yzhang34@nd.edu
%   Date: April 12, 2019
%   Copyright: University of Notre Dame, 2019

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kmeans_FLIM_Phasors_OpeningFcn, ...
                   'gui_OutputFcn',  @Kmeans_FLIM_Phasors_OutputFcn, ...
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

% --- Executes just before Kmeans_FLIM_Phasors is made visible.
function Kmeans_FLIM_Phasors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kmeans_FLIM_Phasors (see VARARGIN)

% Choose default command line output for Kmeans_FLIM_Phasors
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kmeans_FLIM_Phasors wait for user response (see UIRESUME)
% uiwait(handles.Figure_PM_FLIM);


clc

addpath('./functions')

set(handles.Axes_G,'XTick',[],'YTick',[]); 
set(handles.Axes_S,'XTick',[],'YTick',[]); 
set(handles.Axes_I,'XTick',[],'YTick',[]); 
set(handles.Axes_L,'XTick',[],'YTick',[]); 
set(handles.Axes_LBar,'XTick',[],'YTick',[]); 
set(handles.Axes_PC,'XTick',[],'YTick',[]); 
set(handles.Axes_O,'XTick',[],'YTick',[]);

set(handles.Slider_G, 'visible', 'off');
set(handles.Slider_S, 'visible', 'off');
set(handles.Slider_I, 'visible', 'off');
set(handles.Slider_L, 'visible', 'off');
set(handles.Slider_O, 'visible', 'off');

fun_colorbarHSV2RGB(handles)


% --- Outputs from this function are returned to the command line.
function varargout = Kmeans_FLIM_Phasors_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%%%%%%%%%%% GUI Functions for Image Formation %%%%%%%%%%%%

function Button_LoadG_Callback(hObject, eventdata, handles)
% hObject    handle to Button_LoadG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'GSgood')
     handles = rmfield(handles, 'GSgood'); 
end
if isfield(handles,'xyzgood')
     handles = rmfield(handles, 'xyzgood'); 
end
[filenames, pathname] = uigetfile({'*.tif;*.tiff;*.csv'},'Select the CSV or TIF files to be imported', 'MultiSelect','on');
if iscell(filenames) % multiple selection
    if strfind(filenames{1},'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageG_backup = image_stack; % for filtering purposes
        handles.imageG = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'G');    
    else
        msgbox('Only a single TIF file (2D frame or 3D stack) can be imported.', 'Error','error');
    end
elseif ischar(filenames) % single selection
    if strfind(filenames,'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageG_backup = image_stack; % for filtering purposes
        handles.imageG = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'G');    
    else
        [image_stack, ~, ~, ~] = fun_importTIFstack(filenames, pathname);
        handles.imageG_backup = image_stack; % for filtering purposes
        handles.imageG = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'G');   
    end
end


function Button_LoadS_Callback(hObject, eventdata, handles)
% hObject    handle to Button_LoadS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filenames, pathname] = uigetfile({'*.tif;*.tiff;*.csv'},'Select the CSV or TIF files to be imported', 'MultiSelect','on');
if iscell(filenames) % multiple selection
    if strfind(filenames{1},'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageS_backup = image_stack; % for filtering purposes
        handles.imageS = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'S');    
    else
        msgbox('Only a single TIF file (2D frame or 3D stack) can be imported.', 'Error','error');
    end
elseif ischar(filenames) % single selection
    if strfind(filenames,'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageS_backup = image_stack; % for filtering purposes
        handles.imageS = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'S');    
    else
        [image_stack, ~, ~, ~] = fun_importTIFstack(filenames, pathname);
        handles.imageS_backup = image_stack; % for filtering purposes
        handles.imageS = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'S');   
    end
end

function Button_LoadI_Callback(hObject, eventdata, handles)
% hObject    handle to Button_LoadI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filenames, pathname] = uigetfile({'*.tif;*.tiff;*.csv'},'Select the CSV or TIF files to be imported', 'MultiSelect','on');
if iscell(filenames) % multiple selection
    if strfind(filenames{1},'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageI_backup = image_stack; % for filtering purposes
        handles.imageI = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'I');    
    else
        msgbox('Only a single TIF file (2D frame or 3D stack) can be imported.', 'Error','error');
    end
elseif ischar(filenames) % single selection
    if strfind(filenames,'.csv')
        [image_stack, ~, ~, ~] = fun_importCSVstack(filenames, pathname);
        handles.imageI_backup = image_stack; % for filtering purposes
        handles.imageI = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'I');    
    else
        [image_stack, ~, ~, ~] = fun_importTIFstack(filenames, pathname);
        handles.imageI_backup = image_stack; % for filtering purposes
        handles.imageI = image_stack; guidata(hObject,handles) 
        fun_updateFigures(handles, -1, 'I');   
    end
end

function Button_CalcL_Callback(hObject, eventdata, handles)
% hObject    handle to Button_CalcL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_calcLifetimes(hObject, handles);

function Button_CalcPC_Callback(hObject, eventdata, handles)
% hObject    handle to Button_CalcPC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_calcClusters(hObject, handles);

function Button_CalcO_Callback(hObject, eventdata, handles)
% hObject    handle to Button_CalcO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_calcOverlap(hObject, handles);

function Button_IntensityHist_Callback(hObject, eventdata, handles)
% hObject    handle to Button_IntensityHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_intensityHist(hObject, handles);

function Button_LifetimeHist_Callback(hObject, eventdata, handles)
% hObject    handle to Button_LifetimeHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_lifetimeHist(hObject, handles);

function Button_ApplyFilter_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ApplyFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_applyFilters(hObject, handles);


%%%%%%%%%%%% GUI Functions that Update Figures %%%%%%%%%%%%

function Edit_Gmin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Gmin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Gmin as a double
fun_updateFigures(handles, round(get(handles.Slider_G, 'Value')), 'G');

function Edit_Gmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Gmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Gmax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Gmax as text
%        str2double(get(hObject,'String')) returns contents of Edit_Gmax as a double
fun_updateFigures(handles, round(get(handles.Slider_G, 'Value')), 'G');

function Edit_Gmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Gmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Smin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Smin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Smin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Smin as a double
fun_updateFigures(handles, round(get(handles.Slider_S, 'Value')), 'S');

function Edit_Smin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Smin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Smax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Smax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Smax as text
%        str2double(get(hObject,'String')) returns contents of Edit_Smax as a double
fun_updateFigures(handles, round(get(handles.Slider_S, 'Value')), 'S');

function Edit_Smax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Smax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Imin_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Imin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Imin as text
%        str2double(get(hObject,'String')) returns contents of Edit_Imin as a double
set(handles.Check_AutoI, 'Value', false)
fun_updateLimRange(handles, 'lim2range');
fun_updateFigures(handles, round(get(handles.Slider_I, 'Value')), 'I');

function Edit_Imin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Imin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Imax_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_Imax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_Imax as text
%        str2double(get(hObject,'String')) returns contents of Edit_Imax as a double
set(handles.Check_AutoI, 'Value', false)
fun_updateLimRange(handles, 'lim2range');
fun_updateFigures(handles, round(get(handles.Slider_I, 'Value')), 'I');

function Edit_Imax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Imax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Check_AutoI_Callback(hObject, eventdata, handles)
% hObject    handle to Check_AutoI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_AutoI
fun_updateLimRange(handles, 'range2lim');
fun_updateFigures(handles, round(get(handles.Slider_I, 'Value')), 'I');

function Edit_MaxPerc_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_MaxPerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_MaxPerc as text
%        str2double(get(hObject,'String')) returns contents of Edit_MaxPerc as a double
set(handles.Check_AutoI, 'Value', false)
fun_updateLimRange(handles, 'range2lim');
fun_updateFigures(handles, round(get(handles.Slider_I, 'Value')), 'I');

function Edit_MaxPerc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_MaxPerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_MinPerc_Callback(hObject, eventdata, handles)
% hObject    handle to Edit_MinPerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edit_MinPerc as text
%        str2double(get(hObject,'String')) returns contents of Edit_MinPerc as a double
set(handles.Check_AutoI, 'Value', false)
fun_updateLimRange(handles, 'range2lim');
fun_updateFigures(handles, round(get(handles.Slider_I, 'Value')), 'I');

function Edit_MinPerc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_MinPerc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Check_isLHSV_Callback(hObject, eventdata, handles)
fun_updateFigures(handles, round(get(handles.Slider_L, 'Value')), 'L');

function Check_isOHSV_Callback(hObject, eventdata, handles)
% hObject    handle to Check_isOHSV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Check_isOHSV
fun_updateFigures(handles, round(get(handles.Slider_O, 'Value')), 'O');



%%%%%%%%%%%% GUI Functions that Not-Update Figures %%%%%%%%%%%%

function Edit_ModFreq_Callback(hObject, eventdata, handles)
ModFreq = str2double(get(hObject, 'String'));
if ModFreq < 1
    ModFreq = 1;
end
set(hObject, 'String', num2str(round(ModFreq)));

function Edit_ModFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_ModFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_MaxL_Callback(hObject, eventdata, handles)
fun_calcLifetimes(hObject, handles);

function Edit_MaxL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_MaxL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_MinL_Callback(hObject, eventdata, handles)
fun_calcLifetimes(hObject, handles);

function Edit_MinL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_MinL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_K_Callback(hObject, eventdata, handles)
K = str2double(get(hObject, 'String'));
if K < 1
    K = 1;
end
set(hObject, 'String', num2str(round(K)));

function Edit_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pop_Distance_Callback(hObject, eventdata, handles)

function Pop_Distance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_Distance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Edit_Rep_Callback(hObject, eventdata, handles)
Rep = str2double(get(hObject, 'String'));
if Rep < 1
    Rep = 1;
end
set(hObject, 'String', num2str(round(Rep)));

function Edit_Rep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edit_Rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Pop_FilterSelect_Callback(hObject, eventdata, handles)

function Pop_FilterSelect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pop_FilterSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Check_IntensityFilter_Callback(hObject, eventdata, handles)


%%%%%%%%%%%% GUI Functions for Sliders %%%%%%%%%%%%

function Slider_G_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slice_idx = round(get(hObject, 'Value'));
fun_updateFigures(handles, slice_idx, 'G');

function Slider_G_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_G (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Slider_S_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slice_idx = round(get(hObject, 'Value'));
fun_updateFigures(handles, slice_idx, 'S');

function Slider_S_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_S (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Slider_I_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slice_idx = round(get(hObject, 'Value'));
fun_updateFigures(handles, slice_idx, 'I');

function Slider_I_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Slider_L_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slice_idx = round(get(hObject, 'Value'));
fun_updateFigures(handles, slice_idx, 'L');

function Slider_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function Slider_O_Callback(hObject, eventdata, handles)
% hObject    handle to Slider_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slice_idx = round(get(hObject, 'Value'));
fun_updateFigures(handles, slice_idx, 'O');

function Slider_O_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider_O (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



%%%%%%%%%%%% GUI Functions for Exporting Image Data %%%%%%%%%%%%

function Button_ExportG_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'G');

function Button_ExportS_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'S');

function Button_ExportI_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'I');

function Button_ExportL_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'L');

function Button_ExportPC_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportPC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'PC');

function Button_ExportO_Callback(hObject, eventdata, handles)
% hObject    handle to Button_ExportO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fun_exportFigures(handles, 'O');
