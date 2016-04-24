function varargout = hackGUI(varargin)
% global im;
% HACKGUI MATLAB code for hackGUI.fig
%      HACKGUI, by itself, creates a new HACKGUI or raises the existing
%      singleton*.
%
%      H = HACKGUI returns the handle to a new HACKGUI or the handle to
%      the existing singleton*.
%
%      HACKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HACKGUI.M with the given input arguments.
%
%      HACKGUI('Property','Value',...) creates a new HACKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hackGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hackGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hackGUI

% Last Modified by GUIDE v2.5 23-Apr-2016 16:54:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hackGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @hackGUI_OutputFcn, ...
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


% --- Executes just before hackGUI is made visible.
function hackGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hackGUI (see VARARGIN)

% Choose default command line output for hackGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hackGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hackGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clear all:
global im0;
[filename,pathname,filterindex]=uigetfile({'*.jpg';'*.bmp';'*.gif'},'選擇圖片')
str=[pathname filename]; 
set(handles.text1,'String',str);
axes(handles.axes1);
% axes1=imread(str); 
im0=imread(str);
imshow(im0);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global im0;
global small;
     axes(handles.axes1);
     imshow(im0);
load('鬼頭刀標準.mat');
load('鮪魚標準.mat');
im=rgb2gray(im0);
i=1;
long=294;
short=110;
for y=0:(704-long)/10
for x=0:(480-short)/10
        L=im(1+x*10:short+x*10,1+y*10:long+y*10);
A=imresize(L,[50 100]);
[Aout,Aaa]=func2(A);
aaaaaa{i}=Aaa;
t{1}=Aaa(:,1:25);
t{4}=Aaa(:,81:100);
t{5}=Aaa(1:10,26:80);
t{6}=Aaa(41:50,26:80);
t{2}=Aaa(11:40,26:53);
t{3}=Aaa(11:40,54:80);
T1=func1(t{1}); T1=T1';
T2=func1(t{2}); T2=T2';
T3=func1(t{3}); T3=T3';
T4=func1(t{4}); T4=T4';
T5=func1(t{5}); T5=T5';
T6=func1(t{6}); T6=T6';
T7=reshape(Aout,1,100*50);
T8=T7/sum(T7); T8=T8';

cof1(i)=func3(T1,stand1);
cof2(i)=func3(T2,stand2);
cof3(i)=func3(T3,stand3);
cof4(i)=func3(T4,stand4);
cof5(i)=func3(T5,stand5);
cof6(i)=func3(T6,stand6);
cof7(i)=func3(T8,stand7);

cof8(i)=func3(T1,stand8);
cof9(i)=func3(T2,stand9);
cof10(i)=func3(T3,stand10);
cof11(i)=func3(T4,stand11);
cof12(i)=func3(T5,stand12);
cof13(i)=func3(T6,stand13);
cof14(i)=func3(T8,stand14);

Ans(i)=(cof1(i)+1)*(cof1(i)+1)*(cof2(i)+1)*(cof2(i)+1)*(cof3(i)+1)*(cof3(i)+1)*(cof4(i)+1)*(cof5(i)+1)*(cof6(i)+1)*(cof7(i)+1);

Ans2(i)=(cof8(i)+1)*(cof8(i)+1)*(cof9(i)+1)*(cof9(i)+1)*(cof10(i)+1)*(cof10(i)+1)*(cof11(i)+1)*(cof12(i)+1)*(cof13(i)+1)*(cof14(i)+1);

if Ans(i)>Ans2(i)
    Ans3(i)=Ans(i);
end

if Ans2(i)>Ans(i)
    Ans3(i)=Ans2(i);
end

i=i+1
end

end   

%  GG=find(Ans>=6);
 GG=find(Ans3==max(Ans3));
 Ansmax=max(Ans3);

i=1;
for y=0:(704-long)/10
for x=0:(480-short)/10
    
        L=im0(1+x*10:short+x*10,1+y*10:long+y*10,:);

        [e,f]=find(GG==i);
        
if f>0  

if Ansmax>=9.5    

     rectangle('Position',[1+y*10,1+x*10,long,short],'Curvature',[0,0],'LineWidth',1,'LineStyle','-','EdgeColor','r') 
small=L;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     imshow(L);
end


end
i=i+1;
end
end
      
      axes(handles.axes2);
      imshow(small);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global small;
A=imresize(small,[36 76]);
%產生rgb sobel
    B=rgb2gray(A);
    Hx = [-1 0 1; -2 0 2;-1 0 1];
    Hy = [1 2 1; 0 0 0; -1 -2 -1]; 
    kx = convn(B,Hx,'same'); %x方向梯度值 
    ky = convn(B,Hy,'same'); %y方向梯度值
    k = (kx.^2 + ky.^2).^0.5;
    k = k./max(max(k)); 
    k=k*255;
    k=uint8(k);
%cnn input
soninputx(:,:,1:3,1)=A;
soninputx(:,:,4,1)=k;
soninputx(:,:,:,2)=soninputx(:,:,:,1);
    test_x = double(reshape(soninputx,36,76,4,2))/255;
    load('hackson/hacksonDT_ep15.mat');
    net = cnnff(net, test_x);
    [~, h] = max(net.o);
    if h(1,1) == 1
        set(handles.text2,'String',['鬼頭刀']);
    else if h(1,1) == 2
        set(handles.text2,'String',['鮪魚']); 
        end
    end
