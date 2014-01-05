function varargout = User_guide(varargin)
%USER_GUIDE M-file for User_guide.fig
%      USER_GUIDE by itself, creates a new USER_GUIDE or raises the
%      existing singleton*.
%
%      H = USER_GUIDE returns the handle to a new USER_GUIDE or the handle to
%      the existing singleton*.
%
%      USER_GUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USER_GUIDE.M with the given input arguments.
%
%      USER_GUIDE('Property','Value',...) creates a new USER_GUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before User_guide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to User_guide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%
% Authors: Francisco Llobet, Jose Rivera
% Editor: Ferdinand Trommsdorff (f.trommsdorff@gmail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)

% Last Modified by GUIDE v2.5 04-Jan-2014 02:24:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @User_guide_OpeningFcn, ...
                   'gui_OutputFcn',  @User_guide_OutputFcn, ...
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

% --- Executes just before User_guide is made visible.
function User_guide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to User_guide (see VARARGIN)
% Choose default command line output for User_guide
handles.output = 'Yes';
% Update handles structure
guidata(hObject, handles);
% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.text1, 'String', varargin{index+1});
        end
    end
end
% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);
    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat
% IconData=questIconData;
questIconMap(256,:) = get(handles.figure1, 'Color');
IconCMap=questIconMap;
MTIDSLogo = imread('mtidslogo.png');;
Img=image(MTIDSLogo);
set(handles.figure1, 'Colormap', IconCMap);
set(handles.axes1, ...
    'Visible', 'off', ...
    'YDir'   , 'reverse'       , ...
    'XLim'   , get(Img,'XData'), ...
    'YLim'   , get(Img,'YData')  ...
    );
% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')
% UIWAIT makes User_guide wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = User_guide_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    % Update handles structure
    guidata(hObject, handles);
    uiresume(handles.figure1);
end    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'There are many systems or networks from very different fields, which can be modeled by using the graph   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'theory. They are also mentioned in [1]. Some technical examples are the Power system, including transformators, ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,' loads and generators, the traffic system which ties to avoid jams and the internet which connects millions of computers.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'In biology graph theory helps to reconstruct neuronal networks for brain studies or to model animal populations ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'or little ecosystems. Another point of research is the flocking behavior of birds or fish. Other practical ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'applications are the economical or social networks.\\A networked control system is a spatially distributed ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'control system, where information is exchanged over a (digital) network, [3].\\' ,'interpreter' ,'latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 500 220],'visible','off')
h12=imshow('GraphTheory1.png'); 



axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
Directed_graph_statistics();


% handles.output = get(hObject,'String');
% % Update handles structure
% guidata(hObject, handles);
% % Use UIRESUME instead of delete because the OutputFcn needs
% % to get the updated handles structure.
% uiresume(handles.figure1);



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Connections:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of connections between the nodes of the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Independent Graphs:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'The number of independent subgraphs that are not connected to each other.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'In this example the nodes one and two form a subgraph and the nodes thre  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'and four form a subgraph. So there are two independent subgraphs.\\  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('IndependentGraph.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{About MTIDS:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'Copyright (C) 2012 The MTIDS Project ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'Licence as published by the Free Software Foundation; either version 2 (GPL 2), or (at your option) any later version. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h7=text(0,0.5,'For more information read LICENCE.txt','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 440],'visible','off')
h8=text(0,0.5,'The MTIDS project is hosted at: http://code.google.com/p/mtids','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 400],'visible','off')
h9=text(0,0.5,'MTIDS uses Matgraph (c) Ed Scheinermann','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h10=text(0,0.5,'General Public License for more details.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Graph density:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The graph density is computed as follows:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'\[\mbox{graph density} = mean(\mbox{degree vector})/(dim(\mbox{Laplacian})-1)\] \\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'The graph density is the mean of the degree of every node divided by the number of nodes minus one.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Workflow with MTIDS:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'In this chapter a short plan to work with MTIDS is given. The first thing to do is  to generate the dynamics of the','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'individual subsystems. Therefore an empty SIMULINK template needs to be filled with any SIMULINK blocks to create','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'the dynamics. Then the desired subsystem dynamics has to be imported into MTIDS. In the  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'parameter set manager (PSM) the parameters can be set numerically by MTIDS or manually by the user. ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'Also some standard templates can be chosen.\\ The building of a graph is straight foreward by clicking the','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'buttons on the graphical surface of MTIDS where also the dynamics can be applied to the nodes. The graph ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'statistics are updated automatically.  Additionally it is possible to set the colour of a node.\\ To change the dynamics of ','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'a node, a double-click on the node opens the settings. Some simulation and plot parameters can be varied, too.\\When the  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'graph with its dynamics and parameter settings is ready, the user can work with the system in MTIDS or export it ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'to SIMULINK for a simulation. The simulation parameters can be determined in MTIDS. The simulation data and results  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'can be saved in *.mat files.\\ The letter [1] explains more details for the work with MTIDS and shows some examples.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Algebraic connectivity:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The algebraic connectivity of a graph G is the second-smallest eigenvalue of the Laplacian matrix of G.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'This eigenvalue is greater than zero if and only if G is a connected graph. This is a corollary to the fact  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,' that the number of times zero appears as an eigenvalue in the Laplacian matrix is the number of connected ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'components in the graph. The magnitude of this value reflects how well connected the overall graph is,','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'and has been used in analysing the robustness and synchronizability of networks.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide



% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[230 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Rooted spanning tree:}\\','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[230 110 10 280],'visible','off')
h2=text(0,0.5,'This field says Yes if the graph can be built as a rooted spanning tree.  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 240],'visible','off')
h3=text(0,0.5,'Otherwise it says No. As you can see in the figure every node is connected   ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 200],'visible','off')
h4=text(0,0.5,'to the root node by one or more lines. There are no cirle.\\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 175 160],'visible','off')
h5=imshow('rootedspanningtree.png'); 


axes('units','pixels','position',[230 110 10 160],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 120],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[230 110 10 80],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[230 110 20 40],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide




% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Minimum degree:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The degree vector contains the diagonal elements of the Laplacian matrix. These elements are the degrees','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'of the nodes, which means number of edges leave or arrive in one node.\\ The Minimum degree shows the \\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'smallest degree of all nodes.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide
if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
end
x=20;
axes('units','pixels','position',[40 110 30 320],'visible','off')
h1=text(0,0.5,'\underline{Nodes:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 10 280],'visible','off')
h2=text(0,0.5,'The number of nodes in the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 240],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 200],'visible','off')
h4=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 10 160],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 20 120],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 80],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 20 40],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 20 1],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);

x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Toolbox statistics:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'To improve the work with distributed networks and because of the complexity they can reach, the MATLAB toolbox  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'MTIDS was built. This toolbox shows the important statistics that give information about the convergence, ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'the connectivity and the robustness of the control system.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'This chapter includes the explanations for the statistics of the toolbox located in the window next to the','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,' picture of the actual graph. For the two typs of edges, either directed or undirected, there are two different','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'versions of the graph statistics window. A look in the handbook, [4], on the webpage, [2], of MTIDS is profitable, too.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{References:}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'[1] F. Deroo and S. Hirche; A MATLAB Toolbox for Large-scale Networked Systems;','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h3=text(0,0.5,'[2] URL: https://code.google.com/p/mtids/ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h4=text(0,0.5,'[3] S. Hirche; slides of the course: networked control systems, SS13.  ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 560],'visible','off')
h5=text(0,0.5,'[4] Francisco Llobet, Jose Rivera; Numerical Test Rig for Large-Scale and Interconnected Dynamical Systems;','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 680],'visible','off')
h6=text(0,0.5,'     at- Automatisierungstechnik, July 2013.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'    at- Institude of Automatic Control Engineering, 2011.','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h15=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (2):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'The benefits are higher flexibility and lower costs for cabling and installation. Many problems can be solved faster,','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,' because they are split up in different little subproblems. All controlers are connected via communication paths. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'The controlled systems could also be coupled. To model this networked control systems the graph theory is used. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'The controlers become nodes and the communication paths become edges. One of the reasons why graph theory is ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'chosen is, that the systems can be easily analysed and it is simple to compute some statistics for the dynamical systems.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'For modeling these interconnected systems a graph $ G $ is defined by a set of vertices $ V $ (also called nodes) and a set ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'of edges $ E $, [1]. Two vertices that are connected by an edge can be written in brackets like (i,j).\\','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 440],'visible','off')
h9=text(0,0.5,'There are two typs of graphs, directed or undirected. In undirected graphs the nodes that are connected ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,'with an edge communicate in both directions which is shown by a line. The nodes in directed graphs are ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'connected with arrows that show the direction of the information flow.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[140 110 450 160],'visible','off')
h15=imshow('GraphTheory2.png');  
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 40],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (3):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'Three special undirected graphs can be found:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'- The tree, where every node is connected by exactly one edge. It contains no cycles. \\ ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 640],'visible','off')
h4=text(0,0.5,'- The cycle in which the nodes are joined in a closed chain. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'- The complete graph, in which every node is connected to all the other nodes.','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[100 110 550 360],'visible','off')
h9=imshow('GraphTheory3.png');   
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 240],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'For the possibility of making some computations three important matricies are defined. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'The entries of the Incidence Matrix of a directed graph are defined as follows: (next page) \\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h19=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle'); 
save User_guide


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (4):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[290 110 330 640],'visible','off')
h4=imshow('GraphTheory_M_1.png');  
axes('units','pixels','position',[40 110 30 600],'visible','off')
h5=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 560],'visible','off')
h6=text(0,0.5,'The Incidence Matrix exits only for simple graphs that means, for graphs without self-loops.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 520],'visible','off')
h7=text(0,0.5,'The entries of Adjacency Matrix are computed like this: \\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');

axes('units','pixels','position',[240 110 430 440],'visible','off')
h9=imshow('GraphTheory_M_2.png'); 
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'The matrix A is the binary directed or indirected connection matrix. Normally A has no diagonal elements, because ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'in most cases no edge starts and ends in the same node.\\ The definition of the entries of the Degree Matrix is: \\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 280],'visible','off')
h13=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 400 240],'visible','off')
h14=imshow('GraphTheory_M_3.png'); 
% axes('units','pixels','position',[100 110 850 360],'visible','off')
% h9=imshow('GraphTheory4.png');
axes('units','pixels','position',[300 110 30 40],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h16=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h17=text(0,0.5,'D is a diagonal matrix. Its elements are the degrees of the nodes.\\The Laplacian matrix L is difference between ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h18=text(0,0.5,'the adjacency matrix A and the degree matrix D.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[300 110 30 40],'visible','off')
h19=text(0,0.5,'L=D-A','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load User_guide

if x > 1
delete(h1);
delete(h2);
delete(h3);
delete(h4);
delete(h5);
delete(h6);
delete(h7);
delete(h8);
delete(h9); delete(h10); delete(h11); delete(h12); delete(h13); delete(h14); delete(h15); delete(h16); delete(h17); delete(h18); delete(h19);
x=20;
end
x=20;
axes('units','pixels','position',[40 110 30 760],'visible','off')
h1=text(0,0.5,'\underline{Graph theory (5):}\\ ','interpreter','latex',...
    'horiz','left','vert','middle');


axes('units','pixels','position',[40 110 30 720],'visible','off')
h2=text(0,0.5,'The Laplacian matrix is symmetric, positive semidefinite and diagonally dominant.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 680],'visible','off')
h3=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 150 540],'visible','off')
h4=imshow('GraphTheory_5.png');  
axes('units','pixels','position',[200 110 530 475],'visible','off')
h5=imshow('GraphTheory_6.png');

axes('units','pixels','position',[240 110 30 600],'visible','off')
h6=text(0,0.5,'The matricies for this graph look like follows:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h7=text(0,0.5,'If the graph is connected the eigenvalues of L increase starting with zero.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h8=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 80],'visible','off')
h9=text(0,0.5,'These problems are explained in greater detail in [1].\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 430 440],'visible','off')
%h9=imshow('GraphTheory_M_2.png'); 
axes('units','pixels','position',[40 110 30 400],'visible','off')
h10=text(0,0.5,' ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 360],'visible','off')
h11=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 320],'visible','off')
h12=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 30 280],'visible','off')
h13=text(0,0.5,'0=$\lambda_{1}$  $<$ $\lambda_{2}$ $<$ $\lambda_{3}$ $<$ $\lambda_{4}$ $<$ ... $<$ $\lambda_{n}$','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[240 110 400 240],'visible','off')
h14=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 480],'visible','off')
h15=text(0,0.5,'','interpreter','latex',...
    'horiz','left','vert','middle');
% axes('units','pixels','position',[100 110 850 360],'visible','off')
% h9=imshow('GraphTheory4.png');  
axes('units','pixels','position',[40 110 30 240],'visible','off')
h16=text(0,0.5,'For the eigenvalue $\lambda_2=0$, which is called algebraic connectivity or fiedler value, the graph is not connected. ','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 200],'visible','off')
h17=text(0,0.5,'It is a measure for connectivity. The greater $\lambda_2$ is, the better is the robustness of the graph.\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 160],'visible','off')
h18=text(0,0.5,'Three problems of interconnected systems are often discussed:\\','interpreter','latex',...
    'horiz','left','vert','middle');
axes('units','pixels','position',[40 110 30 120],'visible','off')
h19=text(0,0.5,'1. Linear Time Invariant (LTI) systems 2. Consensus 3. Coupled oscillators','interpreter','latex',...
    'horiz','left','vert','middle');

save User_guide


% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');
% Update handles structure
guidata(hObject, handles);
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);
Undirected_graph_statistics();
