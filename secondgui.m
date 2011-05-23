

function varargout = secondgui(varargin)
% SECONDGUI M-file for secondgui.fig
%      SECONDGUI, by itself, creates a new SECONDGUI or raises the existing
%      singleton*.
%
%      H = SECONDGUI returns the handle to a new SECONDGUI or the handle to
%      the existing singleton*.
%
%      SECONDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDGUI.M with the given input arguments.
%
%      SECONDGUI('Property','Value',...) creates a new SECONDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before secondgui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to secondgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help secondgui

% Last Modified by GUIDE v2.5 16-May-2011 20:59:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @secondgui_OpeningFcn, ...
                   'gui_OutputFcn',  @secondgui_OutputFcn, ...
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


% --- Executes just before secondgui is made visible.
function secondgui_OpeningFcn(hObject, eventdata, handles, varargin)

addpath(strcat(pwd,'/matgraph'));
graph_init;
global g;
g = graph; %% Creating a graph
%%resize(g,5)
draw(g);

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to secondgui (see VARARGIN)

% Choose default command line output for secondgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes secondgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = secondgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in updategraph.
function updategraph_Callback(hObject, eventdata, handles)
% hObject    handle to updategraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
%% distxy(g);
rmxy(g)
cla;
if ne(g) > 0
    distxy(g);
end

draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);

function newnodelabel_Callback(hObject, eventdata, handles)
% hObject    handle to newnodelabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newnodelabel as text
%        str2double(get(hObject,'String')) returns contents of newnodelabel as a double


% --- Executes during object creation, after setting all properties.
function newnodelabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newnodelabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in newnode.
function newnode_Callback(hObject, eventdata, handles)
% hObject    handle to newnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
new_vertex = nv(g) + 1;
resize(g, new_vertex);
label(g,new_vertex, get(handles.newnodelabel,'String')); 
rmxy(g)
cla;
draw(g);
set(handles.nedges,'String', ne(g));
set(handles.nvertices,'String', nv(g));
guidata(hObject, handles);



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);




% --- Executes on button press in addconnection.
function addconnection_Callback(hObject, eventdata, handles)
% hObject    handle to addconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
from_node = str2num(get(handles.fromnode,'String'));
to_node = str2num(get(handles.tonode,'String'));
add(g,from_node, to_node);
rmxy(g);
cla;
draw(g);

set(handles.nedges,'String', ne(g));
set(handles.nvertices,'String', nv(g));

guidata(hObject, handles);



function fromnode_Callback(hObject, eventdata, handles)
% hObject    handle to fromnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromnode as text
%        str2double(get(hObject,'String')) returns contents of fromnode as a double


% --- Executes during object creation, after setting all properties.
function fromnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function tonode_Callback(hObject, eventdata, handles)
% hObject    handle to tonode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tonode as text
%        str2double(get(hObject,'String')) returns contents of tonode as a double


% --- Executes during object creation, after setting all properties.
function tonode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tonode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in randomconnection.
function randomconnection_Callback(hObject, eventdata, handles)
% hObject    handle to randomconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

a = ceil(nv(g)*rand());
b = floor(nv(g)*rand());

add(g,a,b);
rmxy(g);
cla;
draw(g);

set(handles.nedges,'String', ne(g));
set(handles.nvertices,'String', nv(g));

guidata(hObject, handles);

% --- Executes on button press in removeconnection.
function removeconnection_Callback(hObject, eventdata, handles)
% hObject    handle to removeconnection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
from_node = str2num(get(handles.fromnode,'String'));
to_node = str2num(get(handles.tonode,'String'));
delete(g,from_node, to_node);
rmxy(g);
cla;
draw(g);

set(handles.nedges,'String', ne(g));
set(handles.nvertices,'String', nv(g));

guidata(hObject, handles);




function remnode_Callback(hObject, eventdata, handles)
% hObject    handle to remnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of remnode as text
%        str2double(get(hObject,'String')) returns contents of remnode as a double


% --- Executes during object creation, after setting all properties.
function remnode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to remnode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in removenode.
function removenode_Callback(hObject, eventdata, handles)
% hObject    handle to removenode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;

a = str2num(get(handles.remnode,'String'));

delete(g,a);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);



% --- Executes on button press in trimgraph.
function trimgraph_Callback(hObject, eventdata, handles)
% hObject    handle to trimgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
trim(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);


% --- Executes on button press in clearconnections.
function clearconnections_Callback(hObject, eventdata, handles)
% hObject    handle to clearconnections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
clear_edges(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);




% --- Executes on button press in completegraph.
function completegraph_Callback(hObject, eventdata, handles)
% hObject    handle to completegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
complete(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);

% --- Executes on button press in randomgraph.
function randomgraph_Callback(hObject, eventdata, handles)
% hObject    handle to randomgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
random(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);

% --- Executes on button press in wheelgraph.
function wheelgraph_Callback(hObject, eventdata, handles)
% hObject    handle to wheelgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
wheel(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);

% --- Executes on button press in cubegraph.
function cubegraph_Callback(hObject, eventdata, handles)
% hObject    handle to cubegraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
cube(g);
rmxy(g);
cla;
draw(g);
set(handles.nedges,'String', num2str(ne(g)));
set(handles.nvertices,'String',num2str(nv(g)));
guidata(hObject, handles);
