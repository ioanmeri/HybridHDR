function varargout = HybridHDR(varargin)
% HYBRIDHDR MATLAB code for HybridHDR.fig
%      HYBRIDHDR, by itself, creates a new HYBRIDHDR or raises the existing
%      singleton*.
%
%      H = HYBRIDHDR returns the handle to a new HYBRIDHDR or the handle to
%      the existing singleton*.
%
%      HYBRIDHDR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYBRIDHDR.M with the given input arguments.
%
%      HYBRIDHDR('Property','Value',...) creates a new HYBRIDHDR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HybridHDR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HybridHDR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HybridHDR

% Last Modified by GUIDE v2.5 04-Nov-2015 22:55:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HybridHDR_OpeningFcn, ...
                   'gui_OutputFcn',  @HybridHDR_OutputFcn, ...
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

% --- Executes just before HybridHDR is made visible.
function HybridHDR_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for HybridHDR
handles.output = hObject;
% % create an axes that spans the whole gui
% ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% % import the background image and show it on the axes
% bg = imread('art4.jpg'); imagesc(1);
% % prevent plotting over the background and turn the axis off
% set(ah,'handlevisibility','off','visible','off')
% % making sure the background is behind all the other uicontrols
% uistack(ah, 'bottom');
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes HybridHDR wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%setappdata(0,'hMainGui',gcf);
set(handles.file2,'Enable','off');
set(handles.file3,'Enable','off');
set(handles.reset,'Enable','off');
set(handles.pushbutton2,'Enable','off');
set(handles.pushbutton3,'Enable','off');
set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton5,'Enable','off');
set(handles.post,'Enable','off');
set(handles.slider2,'Enable','off');
set(handles.slider3,'Enable','off');
set(handles.slider5,'Enable','off');
set(handles.slider6,'Enable','off');
set(handles.slider10,'Enable','off');
set(handles.slider15,'Enable','off');
set(handles.slider16,'Enable','off');
set(handles.togglebutton2,'Enable','off');
set(handles.togglebutton3,'Enable','off');
set(handles.togglebutton4,'Enable','off');
set(handles.togglebutton5,'Enable','off');
set(handles.togglebutton9,'Enable','off');
set(handles.aligned,'Enable','off');
set(handles.gray,'Enable','off');
set(handles.gauss,'Enable','off');
set(handles.hybrid,'Enable','off');
set(handles.savefiles,'Enable','off');
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.radiobutton4,'Enable','off'); 
set(handles.radiobutton5,'Enable','off');
set(handles.radiobutton3,'Enable','off');
set(handles.uipanel19,'Visible','off');
global im1 im2 im3 y g frgb tonesize a b c 
global bfil filtered Cr Cg Cb 
global effect1 effect3 effect33 micro fuz
global lumeout iptP iptPnew iptT iptTnew thrch2 MM NN colorbal
global onefile hsv outscreen  orton sze one
global count row col fName1 fName2 fName3 fPath
cd('GAUSS');
logo = imread('logo.JPG');
cd('../');
axes(handles.axes15); imshow(logo);
a = []; b = []; c = [];
im1 = []; im2 = []; im3 = [];
y = []; g = []; frgb = [];
tonesize = []; bfil = []; filtered = [];
Cr = []; Cg = []; Cb = [];
effect1 = []; effect3 = [];effect33 = [];micro = [];fuz = [];
lumeout = []; iptP = []; iptPnew = []; iptT = [];iptTnew = [];thrch2 = [];
MM = [];NN = []; colorbal = []; onefile = [];
hsv = [];outscreen = [];orton = [];sze = [];one = [];
count = [];row = [];col = [];fName1= [];fName2= [];fName3= [];fPath= [];


% --- Outputs from this function are returned to the command line.
function varargout = HybridHDR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function files_Callback(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%-----------------LDR No.1 ------------------------------------
function file1_Callback(hObject, eventdata, handles)
global row col im1
global fName1 fPath
[fName1 fPath]  = imgetfile();
im1 = imread(fName1);
[row col] = size(im1);
axes(handles.axes3);imshow(im1);
set(handles.allfiles,'Enable','off');
set(handles.file2,'Enable','on');
set(handles.file1,'Enable','off');
set(handles.onefile,'Enable','off');
set(handles.reset,'Enable','on');
set(handles.text21,'String','Load the secold Low Dynamic Range Image');

% ------------Load Image No.2 and Check Rows,Cols-------------------------
function file2_Callback(hObject, eventdata, handles)
% hObject    handle to allfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global row col im2
global fName2 fName1
[fName2 fPath]  = imgetfile();
if size(fName2) == size(fName1)
    if fName2 == fName1
         msgbox(sprintf('You Must Select a Different Image\nChoose a Proper File'),'Error','Error');
        return
    end
end
im2 = imread(fName2);
[r c] = size(im2);
if r~=row || c~=col
    msgbox(sprintf('Rows and Columns Must Agree\nChoose a Proper File'),'Error','Error');
    return
end
axes(handles.axes4);
imshow(im2);
set(handles.file3,'Enable','on');
set(handles.file2,'Enable','off');
set(handles.text21,'String','Load the third Low Dynamic Range Image');

% ------- Load Image No.3 -------------------------------------
function file3_Callback(hObject, eventdata, handles)
% hObject    handle to file3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global row col im3 
global fName1 fName2 fName3
[fName3 fPath]  = imgetfile();
if size(fName3) == size(fName1)
       if (fName3 == fName1)
         msgbox(sprintf('You Selected The Image No.1 Again\nChoose a Proper File'),'Error','Error');
         return
       end
end
if size(fName3) == size(fName2)
       if (fName3 == fName2)
         msgbox(sprintf('You Selected The Image No.2 Again\nChoose a Proper File'),'Error','Error');
         return
       end
end

im3 = imread(fName3);
[r c] = size(im3);
if r~=row || c~=col
    msgbox(sprintf('Rows and Columns Must Agree\nChoose a Proper File'),'Error','Error');
    return
end
axes(handles.axes5); imshow(im3);
set(handles.file3,'Enable','off');
set(handles.pushbutton2,'Enable','on');
set(handles.text21,'String','Images have been successfully loaded. Press alignment to align');

% --------------------Multi Load    ----------------------------
function allfiles_Callback(hObject, eventdata, handles)
% hObject    handle to allfiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%hMainGui = getappdata(0,'hMainGui');
global im1 im2 im3 fName1 fName2 fName3 fPath
[fNames fPath] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'; ...
    '*.*','All Files' },'Select LDR Images','MultiSelect','on');
%return if no values
if ~iscell(fNames) 
    return
end
size = length(fNames);
fName1 = fNames(1);
fName2 = fNames(2);
fName3 = fNames(3);
if size~=3
    msgbox(sprintf('This Program Uses 3 Low Dynamic Range Images to Make HDR\nPlease select 3 Files'),'Error','Error');
    return
end
files = cell([1 size]);
for i = 1:size
    files(i) = fullfile(fPath, fNames(i));
end
% post images into LDR panel
h = waitbar(0, 'Loading images...'); i =1;% start progress bar
im1 = imread(char(files(i)));
r1 = length(im1(:,1,1)); c1 = length(im1(1,:,1));
waitbar(i / size); i = i+1;
im2 = imread(char(files(i)));
r2 = length(im2(:,1,1)); c2 = length(im2(1,:,1));
waitbar(i / size);
if r2~=r1 || c2~=c1
    msgbox(sprintf('All Images Must Have the Same Size\nChoose Proper Files'),'Error','Error');
    close(h);
    return
end
i = i+1;
im3 = imread(char(files(i)));
r3 = length(im3(:,1,1)); c3 = length(im3(1,:,1));
waitbar(i / size);
if r3~=r1 || c3~=c1
    msgbox(sprintf('All Images Must Have the Same Size\nChoose Proper Files'),'Error','Error');
    close(h);
    return
end
close(h);
set(handles.file1,'Enable','off');
set(handles.file2,'Enable','off');
set(handles.file3,'Enable','off');
set(handles.pushbutton2,'Enable','on');
axes(handles.axes3); imshow(im1);
axes(handles.axes4); imshow(im2);
axes(handles.axes5); imshow(im3);
set(handles.reset,'Enable','on');
set(handles.onefile,'Enable','off');
set(handles.allfiles,'Enable','off');
set(handles.text21,'String','Images have been successfully loaded. Press alignment to align');

% -------------------Reset -----------------------------
function reset_Callback(hObject, eventdata, handles)
global im1 im2 im3 y g frgb tonesize a b c 
global bfil filtered Cr Cg Cb 
global effect1 effect3 effect33 micro fuz
global lumeout iptP iptPnew iptT iptTnew thrch2 MM NN colorbal
global onefile hsv outscreen  orton sze one
global count row col fName1 fName2 fName3 fPath savetmp
a = []; b = []; c = [];
im1 = []; im2 = []; im3 = [];
y = []; g = []; frgb = [];
tonesize = []; bfil = []; filtered = [];
Cr = []; Cg = []; Cb = [];
effect1 = []; effect3 = [];effect33 = [];micro = [];fuz = [];
lumeout = []; iptP = []; iptPnew = []; iptT = [];iptTnew = [];thrch2 = [];
MM = [];NN = []; colorbal = []; onefile = [];
hsv = [];outscreen = [];orton = [];sze = [];one = [];
count = [];row = [];col = [];fName1= [];fName2= [];fName3= [];fPath= [];
savetmp = [];
axes(handles.axes3); imshow(0);
axes(handles.axes4); imshow(0);
axes(handles.axes5); imshow(0);
axes(handles.axes7); imshow(256); axes(handles.axes14); imshow(256);
set(handles.file1,'Enable','on');
set(handles.file2,'Enable','off');
set(handles.file3,'Enable','off');
set(handles.onefile,'Enable','on');
set(handles.allfiles,'Enable','on');
set(handles.savefiles,'Enable','off');
set(handles.post,'Enable','on');
set(handles.reset,'Enable','off');
set(handles.pushbutton2,'Enable','off');
set(handles.pushbutton3,'Enable','off');
set(handles.pushbutton4,'Enable','off');
set(handles.pushbutton5,'Enable','off');
set(handles.slider6,'Enable','off');
set(handles.slider6,'Value',1);
set(handles.slider10,'Enable','off')
set(handles.slider10,'Value',0);
set(handles.slider15,'Enable','off');
set(handles.slider15,'Value',25);
set(handles.slider16,'Enable','off');
set(handles.slider16,'Value',1);
set(handles.togglebutton2,'Enable','off');
set(handles.togglebutton2,'String','OFF');
set(handles.togglebutton2,'Value',0);
set(handles.togglebutton3,'Enable','off');
set(handles.togglebutton3,'String','OFF');
set(handles.togglebutton3,'Value',0);
set(handles.togglebutton5,'Enable','off');
set(handles.togglebutton5,'String','OFF');
set(handles.togglebutton5,'Value',0);
set(handles.togglebutton9,'Enable','off');
set(handles.togglebutton9,'String','OFF');
set(handles.togglebutton9,'Value',0);
set(handles.togglebutton4,'Enable','off');
set(handles.togglebutton4,'String','CHAIN');
set(handles.togglebutton4,'Value',0);
set(handles.slider5,'Enable','off');
set(handles.slider5,'Value',0);
set(handles.slider3,'Enable','off');
set(handles.slider3,'Value',0.5);
set(handles.slider2,'Enable','off');
set(handles.slider2,'Value',0.5);
set(handles.radiobutton1,'Value',0);
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton1,'Enable','off');
set(handles.radiobutton2,'Enable','off');
set(handles.radiobutton3,'Enable','off');
set(handles.radiobutton4,'Enable','off');
set(handles.radiobutton5,'Enable','off');
set(handles.uipanel19,'Visible','off');
set(handles.togglebutton10,'Value',0);
set(handles.togglebutton10,'String','Small Screen');
set(handles.pushbutton3,'Visible','on');
set(handles.pushbutton4,'Visible','on');
set(handles.pushbutton2,'Visible','on');
set(handles.uipanel5,'Visible','on');
set(handles.uipanel6,'Visible','on');
set(handles.uipanel22,'Visible','on');
set(handles.text21,'String','A Thesis Project by Merianos Ioannis, Supervisor : Mitianoudis Nikolaos, DUTH University of Thrace, Greece');

% --- Executes on button press in Align.
function pushbutton2_Callback(hObject, eventdata, handles)
set(handles.pushbutton2,'Enable','off');
set(handles.files,'Enable','off');
axes(handles.axes3); imshow(0);
axes(handles.axes4); imshow(0);
axes(handles.axes5); imshow(0);
global im1 im2 im3 savetmp
global a b c
savetmp =1;
N  = 1;
imgs(:,:,:,1) = im1;
imgs(:,:,:,2) = im2;
imgs(:,:,:,3) = im3;
h = waitbar(0,'Alignment of the Original Fotos');
waitbar(0.33);
for i = 1:N
     alignedImgs = alignMTB(imgs, 0);
     imgs(:,:,:,1) = alignedImgs(:,:,:,1);
     imgs(:,:,:,2) = alignedImgs(:,:,:,2);
     imgs(:,:,:,3) = alignedImgs(:,:,:,3);
end
waitbar(0.66);
im1 = imgs(:,:,:,1);
im2 = imgs(:,:,:,2);
im3 = imgs(:,:,:,3);
% hd = 1980;
% r = length(im1(:,1,1)); col = length(im3(1,:,1));
% factor = 1;
% if r>=col
%     if r>=hd
%         factor = double(hd/r);
%     end
% else
%     if col>=hd
%         factor = double(hd/col);
%     end
% end
% a = imresize(im1,factor);
% b = imresize(im2,factor);
% c = imresize(im3,factor);
a = im1;
b = im2;
c = im3;
axes(handles.axes3); imshow(a);
axes(handles.axes4); imshow(b);
axes(handles.axes5); imshow(c);
set(handles.pushbutton3,'Enable','on');
set(handles.files,'Enable','on');
clear im1 im2 im3;
set(handles.savefiles,'Enable','on');
set(handles.aligned,'Enable','on');
set(handles.radiobutton4,'Enable','on');
set(handles.radiobutton5,'Enable','on');
set(handles.radiobutton3,'Enable','on');
waitbar(1);
close(h);    
set(handles.text21,'String','Images have been aligned. Press HDR Luminance to get the grayscale HDR Image');

% --- Executes on button press in HDR Luminance.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text21,'String','');
set(handles.pushbutton3,'Enable','off');
set(handles.files,'Enable','off');
set(handles.savefiles,'Enable','off');
global a b c y 
cd('ICA');
y = RunChannelY(a,b,c);
cd('../');
axes(handles.axes7); imshow(y); axes(handles.axes14); imshow(y);
set(handles.files,'Enable','on');
set(handles.savefiles,'Enable','on');
set(handles.pushbutton4,'Enable','on');
set(handles.gray,'Enable','on');
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton2,'Value',0);
set(handles.text21,'String','This is the fused intensity channel.Continue with HDR Color ');

% --- Executes on button press in HDR Color.
function pushbutton4_Callback(hObject, eventdata, handles)
set(handles.text21,'String','');
h = waitbar(0);
set(h,'Name','HDR Selection of the Chromatic Channels');
waitbar(0.33,h,'Choosing the colors via Gauss Exposure fusion...');
set(handles.pushbutton4,'Enable','off');
set(handles.files,'Enable','off');
global a b c g y frgb
cd('GAUSS');
g = gauss(a,b,c);
waitbar(0.66,h,'Combining the intensity and the chromatic channels... ');
frgb = finalrgb(y,g);
cd('../');
waitbar(1);
axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
set(handles.files,'Enable','on');
set(handles.pushbutton5,'Enable','on');
set(handles.gauss,'Enable','on');
set(handles.hybrid,'Enable','on');
set(handles.radiobutton2,'Enable','on');
set(handles.radiobutton2,'Value',1);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
close(h);
set(handles.text21,'String','The Original Hybrid HDR Image is ready. Save is possible. Press Post Processing to add effects.');

% --- Executes on button press in Post Processing.
function pushbutton5_Callback(hObject, eventdata, handles)
global frgb bfil filtered Cr Cg Cb tonesize effect1 count
set(handles.text21,'String','');
set(handles.pushbutton5,'Enable','off');
cd('Post_Processing');
[bfil,filtered,Cr,Cg,Cb] = Postsend2(frgb);
cd('../');
tone = tone_size(bfil,filtered,Cr,Cg,Cb,0.5);
tonesize = 0.5*tone +0.5*frgb;
effect1 = tonesize;
axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
set(handles.slider2,'Enable','on');
set(handles.slider3,'Enable','on');
set(handles.togglebutton2,'Enable','on');
set(handles.togglebutton2,'Value',1);
set(handles.togglebutton2,'String','ON');
set(handles.togglebutton3,'Enable','on');
set(handles.togglebutton3,'String','OFF');
set(handles.togglebutton3,'Value',0);
set(handles.togglebutton4,'Enable','on');
set(handles.togglebutton4,'String','CHAIN');
set(handles.togglebutton4,'Value',0);
set(handles.slider5,'Enable','off');
set(handles.savefiles,'Enable','on');
set(handles.post,'Enable','on');
set(handles.radiobutton1,'Enable','on');
set(handles.radiobutton1,'Value',1);
set(handles.radiobutton2,'Enable','on');
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.radiobutton4,'Value',0);
set(handles.radiobutton5,'Value',0);
count = 0;
set(handles.text21,'String','Effects work sequentially. Alter Highlights and Shadows or Auto Color Saturation. Press Chain to continue.');

% --- Executes on button press in togglebutton2. --- Highlights and Shadows
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2
set(handles.text21,'String','');  
global bfil filtered Cr Cg Cb frgb tonesize colorbal effect1
global lumeout iptP iptPnew iptT iptTnew thrch2 MM NN 
a = get(hObject,'Value');
if a ==1
    pr1 = get(handles.slider2,'Value');
    tone = tone_size(bfil,filtered,Cr,Cg,Cb,pr1);
    param_tone = get(handles.slider3,'Value');
    tonesize = param_tone*tone +abs(1-param_tone)*frgb;
    effect1 = tonesize;
    set(handles.togglebutton2,'String','ON');
    axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
    set(handles.slider2,'Enable','on');
    set(handles.slider3,'Enable','on');
    set(handles.togglebutton3,'String','OFF');
    set(handles.togglebutton3,'Value',0);
    set(handles.slider5,'Enable','off');
    set(handles.slider5,'Value',0);
    label1 = pr1*100;
    param2 = get(handles.slider3,'Value');
    label2 = param2*100;
    str = sprintf('Highlights and Shadows : HDR Look is set to %d %%, Amount is set to %d %%. Turn Auto Color Saturation ON',round(label1),round(label2));
    set(handles.text21,'String',str);  
else
    set(handles.togglebutton2,'String','OFF');
    b = get(handles.togglebutton3,'Value');
    colorbal = frgb;
    set(handles.slider2,'Enable','off');
    set(handles.slider3,'Enable','off');
    if (b==1)
        cd('Post_Processing')
        [lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN ] = Burn(frgb);
        cd('../');
        boost = get(handles.slider5,'Value');
        colorbal = auto_boost(lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN,boost);
    end
    axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);   
    str = sprintf('Alter Auto Color Saturation. CHAIN to continue');
    set(handles.text21,'String',str);  
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end




% --- Executes on slider movement. --- HDR LOOK
function slider2_Callback(hObject, eventdata, handles)
size = get(hObject,'Value');
global bfil filtered Cr Cg Cb frgb tonesize effect1
tonesize = tone_size(bfil,filtered,Cr,Cg,Cb,size);
param_tone = get(handles.slider3,'Value');
effect1 = param_tone*tonesize +abs(1-param_tone)*frgb;
axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
set(handles.togglebutton3,'Value',0);
set(handles.slider5,'Enable','off');
set(handles.slider5,'Value',0);
set(handles.togglebutton3,'String','OFF');
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('Highlights and Shadows : HDR Look is set to %d %%. Turn Auto Color Saturation ON for better result',round(size*100));
set(handles.text21,'String',str);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement. --AMOUNT
function slider3_Callback(hObject, eventdata, handles)
global tonesize frgb effect1
val = get(hObject,'Value');
effect1 = val*tonesize +abs(1-val)*frgb;
axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
set(handles.togglebutton3,'Value',0); 
set(handles.slider5,'Enable','off');
set(handles.slider5,'Value',0);
set(handles.togglebutton3,'String','OFF');
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('Highlights and Shadows : Amount is set to %d %%. Turn Auto Color Saturatin ON for better result',round(val*100));
set(handles.text21,'String',str);

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in togglebutton3. -- COLOR SATURATION
function togglebutton3_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
global colorbal effect1
global lumeout iptP iptPnew iptT iptTnew thrch2 MM NN frgb
b = get(hObject,'Value');
a = get(handles.togglebutton2,'Value');
if (b ==1)
    if a ==1
        cd('Post_Processing');
        [lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN ] = Burn(effect1);
        cd('../');
        boost = get(handles.slider5,'Value');
        colorbal = auto_boost(lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN,boost);
        set(handles.togglebutton3,'String','ON');
        axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
        set(handles.slider5,'Enable','on');
    else
        cd('Post_Processing');
        [lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN ] = Burn(frgb);
        cd('../');
        boost = get(handles.slider5,'Value');
        colorbal = auto_boost(lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN,boost);
        set(handles.togglebutton3,'String','ON');
        axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
        set(handles.slider5,'Enable','on'); 
    end
    str = sprintf('Auto Color Saturation : Boost is set to %d %%. Alter Boost if is needed. Chain to Enable the rest effects',round((boost*2.5)*100));
    set(handles.text21,'String',str);
else
    set(handles.togglebutton3,'String','OFF');
    set(handles.slider5,'Enable','off');
    if a==1
        colorbal = effect1;
        axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
    else
        colorbal = frgb;
        axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
    end
    str = sprintf('Alter Highlights and Shadows or Chain to continue editing');
    set(handles.text21,'String',str);
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end




% -------------------Single File Edit-----------------------
function onefile_Callback(hObject, eventdata, handles)
global onefile frgb fName2 savetmp
[fName2 fPath]  = imgetfile();
savetmp = 0;
onefile = imread(fName2);
%Resize
hd = 10980;
r = length(onefile(:,1,1)); col = length(onefile(1,:,1));
factor = 1;
if r>=col
    if r>=hd
        factor = double(hd/r);
    end
else
    if col>=hd
        factor = double(hd/col);
    end
end
frgb = imresize(onefile,factor);
set(handles.file1,'Enable','off');
set(handles.allfiles,'Enable','off');
set(handles.onefile,'Enable','off');
set(handles.reset,'Enable','on');
set(handles.pushbutton5,'Enable','on');
axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
set(handles.text21,'String','Press Post Processing to add effects.');
set(handles.uipanel19,'Visible','on');
set(handles.togglebutton10,'Value',1);
set(handles.togglebutton10,'String','Full Screen');
set(handles.pushbutton3,'Visible','off');
set(handles.pushbutton4,'Visible','off');
set(handles.pushbutton2,'Visible','off');
set(handles.uipanel5,'Visible','off');
set(handles.uipanel6,'Visible','off');
set(handles.uipanel22,'Visible','off');

% --- Executes on slider movement. -- BOOST
function slider5_Callback(hObject, eventdata, handles)
global lumeout iptP iptPnew iptT iptTnew thrch2 MM NN colorbal
boost = get(hObject,'Value');
colorbal = auto_boost(lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN,boost);
axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('Auto Color Saturation : Boost is set to %d %%. Chain to Enable the rest effects',round((boost*2.5)*100));
set(handles.text21,'String',str);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in togglebutton4 --- CHAIN.
function togglebutton4_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
a = get(hObject,'Value');
b = get(handles.togglebutton3,'Value');
c = get(handles.togglebutton2,'Value');
global frgb effect1 effect3 effect33 colorbal micro fuz
if (a==1)
    set(handles.togglebutton2,'Enable','off');
    set(handles.togglebutton3,'Enable','off');
    if b==0 
        if c==0
            effect3 = frgb;  
        else
            effect3 = effect1;
            set(handles.slider2,'Enable','off');
            set(handles.slider3,'Enable','off');
        end
    else
        set(handles.slider5,'Enable','off');
        if c ==1
            set(handles.slider2,'Enable','off');
            set(handles.slider3,'Enable','off');
        end
        effect3 = colorbal;
    end
    micro = effect3;
    cd('Post_Processing');
    effect33 = Unsharp(effect3);
    fuz = effect33;
    cd('../');
    axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
    set(hObject,'String','UNCHAIN');
    set(hObject,'Enable','on');
    set(handles.togglebutton5,'Enable','on');
    set(handles.togglebutton9,'Enable','on');
    set(handles.togglebutton5,'Value',1);
    set(handles.togglebutton5,'String','ON');
    set(handles.slider6,'Enable','on');
    set(handles.slider6,'Value',1);
    set(handles.slider10,'Enable','on');
    set(handles.slider10,'Value',0)
    str = sprintf(' Local Contrast Adjustments is ON. Microsmoothing is set to %d %%. Save anytime: Save->Post Processed Image. Try The Orton Effect',round(1*100));
    set(handles.text21,'String',str);
else
    set(handles.togglebutton2,'Enable','on');
    set(handles.togglebutton3,'Enable','on');
    if b==0
        if c==0
            axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
        else
            axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
            set(handles.slider2,'Enable','on');
            set(handles.slider3,'Enable','on');     
        end
    else
        set(handles.slider5,'Enable','on');
        if c ==1
            set(handles.slider2,'Enable','on');
            set(handles.slider3,'Enable','on');
        end
        axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
    end
    set(handles.togglebutton5,'Enable','off');
    set(handles.togglebutton5,'Value',0);
    set(handles.togglebutton5,'String','OFF');
    set(handles.togglebutton9,'Enable','off');
    set(handles.togglebutton9,'Value',0);
    set(handles.togglebutton9,'String','OFF');
    set(handles.slider6,'Enable','off');
    set(handles.slider10,'Enable','off');
    set(handles.slider15,'Enable','off');
    set(handles.slider16,'Enable','off');
    set(hObject,'String','CHAIN');
    str = sprintf('Alter Highlights and Shadows and/or Auto Color Saturation');
    set(handles.text21,'String',str);
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end



% --- Executes on button press in togglebutton5. ---local contrast adj
function togglebutton5_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
a = get(hObject,'Value');
d = get(handles.togglebutton9,'Value');
global effect33 micro 
if a==1
    set(handles.slider6,'Enable','on');
    set(handles.slider10,'Enable','on');
    set(handles.togglebutton5,'Value',1);
    set(handles.togglebutton5,'String','ON');
    axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
    if d == 1
        set(handles.slider15,'Enable','off');
        set(handles.slider16,'Enable','off');
        set(handles.togglebutton9,'Value',0);
        set(handles.togglebutton9,'String','OFF');
    end
    xx = get(handles.slider6,'Value');
    yy = get(handles.slider10,'Value');
    str = sprintf('Local Contrast Adjustments : Microsmoothing is set to %d %%. Fyzzy Contrast is set to %d %%',round(xx*100),round(yy*100));
    set(handles.text21,'String',str);
else
    set(handles.slider6,'Enable','off');
    set(handles.slider10,'Enable','off');
    set(handles.togglebutton5,'Value',0);
    set(handles.togglebutton5,'String','OFF');
    if d == 0
        axes(handles.axes7); imshow(micro); axes(handles.axes14); imshow(micro); 
    else 
        set(handles.slider15,'Enable','off');
        set(handles.slider16,'Enable','off');
        set(handles.togglebutton9,'Value',0);
        set(handles.togglebutton9,'String','OFF');
        axes(handles.axes7); imshow(micro); axes(handles.axes14); imshow(micro);
    end
    str = sprintf('UNCHAIN to return. Alter The Orton Effect. Save from menu Save->Post Processed Image');
    set(handles.text21,'String',str);
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end


% --- Executes on slider movement. -- MICROSMOOTHING
function slider6_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
a = get(hObject,'Value');
set(handles.slider10,'Value',0)
global micro  effect33 fuz
effect33 = a*fuz + (1-a)*micro;
c = get(handles.togglebutton9,'Value');
if c == 1
    set(handles.togglebutton9,'Value',0);
    set(handles.togglebutton9,'String','OFF');
    set(handles.slider15,'Enable','off');
    set(handles.slider16,'Enable','off');
end
axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('Local Contrast Adjustments : Microsmoothing is set to %d %%.Try The Orton Effect',round(a*100));
set(handles.text21,'String',str);


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement. ---FUZZY CONTRAST
function slider10_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
global effect33 fuz
a = get(hObject,'Value');
cd('Post_Processing');
fuzzy = FuzzyContrast(effect33);
cd('../');
effect33 = a*fuzzy + (1-a)*fuz;
c = get(handles.togglebutton9,'Value');
if c == 1
    set(handles.togglebutton9,'Value',0);
    set(handles.togglebutton9,'String','OFF');
    set(handles.slider15,'Enable','off');
    set(handles.slider16,'Enable','off');
end
axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('Local Contrast Adjustments : Fuzzy Contrast is set to %d %%. Try The Orton Effect',round(a*100));
set(handles.text21,'String',str);

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement. -- ORTON SIZE
function slider15_Callback(hObject, eventdata, handles)
set(handles.text21,'String',''); 
a = get(hObject,'Value');
b = get(handles.togglebutton5,'Value');
global hsv outscreen effect33 orton sze micro
sze = a;
c = get(handles.slider16,'Value');
if b ==1
    cd('Post_Processing');
    orton = orton_size( hsv,outscreen,effect33,sze);
    one = orton;
    orton = c*one + (1-c)*effect33;
    cd('../');
else
    cd('Post_Processing');
    orton = orton_size( hsv,outscreen,micro,sze);
    one = orton;
    orton = c*one + (1-c)*micro;
    cd('../');
end
axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('The Orton Effect : Mask size is set to [%d x %d] . Alter sliders, turn on/off effects or Save the Preview',round(a),round(a));
set(handles.text21,'String',str);

% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in togglebutton9. --The Orton Effect
function togglebutton9_Callback(hObject, eventdata, handles)
set(handles.text21,'String','');
a = get(hObject,'Value');
b = get(handles.togglebutton5,'Value');
global effect33 outscreen hsv orton one effect3
if a==1
    set(handles.slider15,'Enable','on');
    set(handles.slider16,'Enable','on');
    set(hObject,'Value',1);
    set(hObject,'String','ON');
    rr = get(handles.slider15,'Value');
    gg = get(handles.slider16,'Value');
    if b==1
        cd('Post_Processing');
        [outscreen,hsv ] = Orton2(effect33);
        orton = orton_size( hsv,outscreen,effect33,rr);
        one = orton;
        cd('../');
        orton = gg*one + abs(1-gg)*effect33;
        axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
    else
        cd('Post_Processing');
        [outscreen,hsv ] = Orton2(effect3);
        orton = orton_size( hsv,outscreen,effect3,rr);
        one = orton;
        cd('../');
        orton = gg*one + abs(1-gg)*effect3;
        axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
    end
    str = sprintf('The Orton Effect : Mask size is set to [%d x %d] . Amount is set to %d %%',round(rr),round(rr),round(gg*100));
    set(handles.text21,'String',str);
else
     set(hObject,'Value',0);
     set(hObject,'String','OFF');
     set(handles.slider15,'Enable','off');
     set(handles.slider16,'Enable','off');
     if b ==1
        axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
     else
        axes(handles.axes7); imshow(effect3); axes(handles.axes14); imshow(effect3);
     end
     str = sprintf('Alter Local Contrast Adjustments.UNCHAIN to edit the previous effects section. Save anytime');
     set(handles.text21,'String',str);
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end


% --- Executes on slider movement. Amount of Orton Effect
function slider16_Callback(hObject, eventdata, handles)
global orton effect33 one effect3
a = get(hObject,'Value');
b = get(handles.togglebutton5,'Value');
if b==1
    orton = a*one + (1-a)*effect33;
    axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
else
    orton = a*one + (1-a)*effect3;
    axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
end
radio = get(handles.radiobutton1,'Value');
if radio==0
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton5,'Value',0);
end
str = sprintf('The Orton Effect : Amount is set to %d %% . Alter sliders, turn on/off effects or Save the Preview',round(a*100));
set(handles.text21,'String',str);

% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function savefiles_Callback(hObject, eventdata, handles)
% hObject    handle to savefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ----------------Save Aligned Images----------------------
function aligned_Callback(hObject, eventdata, handles)
global a b c fName1 fName2 fName3 fPath
pattern = '.jpg';
pattern2 = '.JPG';
replace = '';
name1 = regexprep(fName1,pattern,replace);
name1 = regexprep(name1,pattern2,replace);
name11 = strcat(name1,'_aligned');
name11 = cell2mat(name11);
name2 = regexprep(fName2,pattern,replace);
name2 = regexprep(name2,pattern2,replace);
name22 = strcat(name2,'_aligned');
name22 = cell2mat(name22);
name3 = regexprep(fName3,pattern,replace);
name3 = regexprep(name3,pattern2,replace);
name33 = strcat(name3,'_aligned');
name33 = cell2mat(name33);
vv = cell2mat(name2);
if ~exist('Results')
    mkdir('Results');
end
cd('Results')
if ~exist(vv)
    mkdir(vv);
end
cd(vv)
imwrite(a,[name11 ,'.jpg']);
imwrite(b,[name22 ,'.jpg']);
imwrite(c,[name33 ,'.jpg']);
cd('../');
cd('../');
pwd;
current = pwd;
name = sprintf('Aligned Images location: %s\\Results\\%s\\',current,vv);
set(handles.text21,'String',name);
set(handles.aligned,'Enable','off');


% ---------------Save grayscale Result-------------------------------
function gray_Callback(hObject, eventdata, handles)
global fName2 y
pattern = '.jpg';
pattern2 = '.JPG';
replace = '';
name1 = regexprep(fName2,pattern,replace);
name1 = regexprep(name1,pattern2,replace);
name2 = strcat(name1,'_gray_hdr');
name2 = cell2mat(name2);
vv = cell2mat(name1);
if ~exist('Results')
    mkdir('Results');
end
cd('Results')
if ~exist(vv)
    mkdir(vv);
end
cd(vv)
imwrite(y,[name2 ,'.jpg']);
cd('../');
cd('../');
set(handles.gray,'Enable','off');
pwd;
current = pwd;
name = sprintf('Image location\\name %s\\Results\\%s\\%s',current,vv,name2);
set(handles.text21,'String',name);


% --------------Save Gauss Result--------------------------------
function gauss_Callback(hObject, eventdata, handles)
global fName2 g
pwd;
current = pwd;
pattern = '.jpg';
pattern2 = '.JPG';
replace = '';
name1 = regexprep(fName2,pattern,replace);
name1 = regexprep(name1,pattern2,replace);
name2 = strcat(name1,'_Gauss_HDR_Result');
name2 = cell2mat(name2);
namex = cell2mat(name1);
if ~exist('Results')
    mkdir('Results');
end
cd('Results')
if ~exist(namex)
    mkdir(namex);
end
cd(namex);
imwrite(g,[name2 ,'.jpg']);
cd('../');
cd('../');
set(handles.gauss,'Enable','off');
name = sprintf('Image location %s\\Results\\%s\\',current,namex);
set(handles.text21,'String',name);


% --------------Save Hybrid HDR Result------------------
function hybrid_Callback(hObject, eventdata, handles)
global fName2 frgb
pwd;
current = pwd;

pattern = '.jpg';
pattern2 = '.JPG';
replace = '';
name1 = regexprep(fName2,pattern,replace);
name1 = regexprep(name1,pattern2,replace);
name2 = strcat(name1,'_Hybrid_HDR_Result');
name2 = cell2mat(name2);
namex = cell2mat(name1);
if ~exist('Results')
    mkdir('Results');
end
cd('Results')
if ~exist(namex)
    mkdir(namex);
end
cd(namex);
imwrite(frgb,[name2 ,'.jpg']);
cd('../');
cd('../');
set(handles.hybrid,'Enable','off');
name = sprintf('Image location %s\\Results\\%s\\',current,namex);
set(handles.text21,'String',name);


% --------------Save Post Processed Image-------------------------
function post_Callback(hObject, eventdata, handles)
global fName2 frgb orton effect33 colorbal effect1 count micro savetmp
pattern = '.jpg';
pattern2 = '.JPG';
replace = '';
name1 = regexprep(fName2,pattern,replace);
name1 = regexprep(name1,pattern2,replace);
if savetmp ~= 1
    [pathstr,namee,ext] = fileparts(name1);
    name1 = namee;
end
if count == 0;
    name2 = strcat(name1,'_Final_Process');
    count = count+1;
%     name2 = cell2mat(name2);
else
    name2 = strcat(name1,'_Final_Process');
    cau = sprintf('%d',count);
    name2 = strcat(name2,cau);
    count = count +1;
%     name2 = cell2mat(name2);
end
% namex = cell2mat(name1);
chain = get(handles.togglebutton4,'Value');
a = get(handles.togglebutton2,'Value');
b = get(handles.togglebutton3,'Value');
c = get(handles.togglebutton5,'Value');
d = get(handles.togglebutton9,'Value');
if ~exist('Results')
    mkdir('Results');
end
cd('Results')
if savetmp ~= 1  
    fak = sprintf('%s',name1);
else
    name1 = cell2mat(name1);
    fak = sprintf('%s',name1);
    name2 = cell2mat(name2);
end
if ~exist(fak)
    mkdir(fak);
end
cd(fak)
if chain == 0
    if a ==0
        if b==0
            imwrite(frgb,[name2 ,'.jpg']);
        else
            imwrite(colorbal,[name2 ,'.jpg']);
        end
    else
        if b==0
            imwrite(effect1,[name2 ,'.jpg']);
        else
            imwrite(colorbal,[name2 ,'.jpg']);
        end
    end
else
    if c == 0
        if d ==0
             imwrite(micro,[name2 ,'.jpg']);
        else
             imwrite(orton,[name2 ,'.jpg']);
        end
    else
        if d ==0
             imwrite(effect33,[name2 ,'.jpg']);
        else
             imwrite(orton,[name2 ,'.jpg']);
        end
    end
end
cd('../');
cd('../');
pwd;
current = pwd;
str = sprintf('Image location\\name ...\\Results\\%s\\%s',name1,name2);
set(handles.text21,'String',str); 


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
global frgb colorbal effect1 micro orton effect33
a = get(hObject,'Value');
if a==0
    axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
    set(handles.radiobutton2,'Value',1);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
else
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    chain = get(handles.togglebutton4,'Value');
    a = get(handles.togglebutton2,'Value');
    b = get(handles.togglebutton3,'Value');
    c = get(handles.togglebutton5,'Value');
    d = get(handles.togglebutton9,'Value');
    if chain == 0
        if a ==0
            if b==0
                axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
            else
               axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
            end
        else
            if b==0
               axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
            else
               axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
            end
        end
    else
        if c == 0
            if d ==0
                axes(handles.axes7); imshow(micro); axes(handles.axes14); imshow(micro);
            else
                axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
            end
        else
            if d ==0
                axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
            else
                axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
            end
        end
    end
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global frgb colorbal effect1 micro orton effect33
a = get(hObject,'Value');
if a==1
    axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
else
    set(handles.radiobutton1,'Value',1);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton4,'Value',0);
    chain = get(handles.togglebutton4,'Value');
    a = get(handles.togglebutton2,'Value');
    b = get(handles.togglebutton3,'Value');
    c = get(handles.togglebutton5,'Value');
    d = get(handles.togglebutton9,'Value');
    if chain == 0
        if a ==0
            if b==0
                axes(handles.axes7); imshow(frgb); axes(handles.axes14); imshow(frgb);
            else
               axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
            end
        else
            if b==0
               axes(handles.axes7); imshow(effect1); axes(handles.axes14); imshow(effect1);
            else
               axes(handles.axes7); imshow(colorbal); axes(handles.axes14); imshow(colorbal);
            end
        end
    else
        if c == 0
            if d ==0
                axes(handles.axes7); imshow(micro); axes(handles.axes14); imshow(micro);
            else
                axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
            end
        else
            if d ==0
                axes(handles.axes7); imshow(effect33); axes(handles.axes14); imshow(effect33);
            else
                axes(handles.axes7); imshow(orton); axes(handles.axes14); imshow(orton);
            end
        end
    end
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
global b frgb
aa = get(hObject,'Value');
if (aa == 1)
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton5,'Value',0);
    axes(handles.axes7);imshow(b); axes(handles.axes14);imshow(b);
else
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',1);
    set(handles.radiobutton3,'Value',0);
    set(handles.radiobutton5,'Value',0);
    axes(handles.axes7);imshow(frgb); axes(handles.axes14);imshow(frgb);
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
global c frgb
aa = get(hObject,'Value');
if (aa == 1)
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton3,'Value',0);
    axes(handles.axes7);imshow(c); axes(handles.axes14);imshow(c);
else
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',1);
    set(handles.radiobutton4,'Value',0);
    set(handles.radiobutton3,'Value',0);
    axes(handles.axes7);imshow(frgb); axes(handles.axes14);imshow(frgb);
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
global a frgb
aa = get(hObject,'Value');
if (aa == 1)
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',0);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton4,'Value',0);
    axes(handles.axes7);imshow(a); axes(handles.axes14);imshow(a);
else
    set(handles.radiobutton1,'Value',0);
    set(handles.radiobutton2,'Value',1);
    set(handles.radiobutton5,'Value',0);
    set(handles.radiobutton4,'Value',0);
    axes(handles.axes7);imshow(frgb); axes(handles.axes14);imshow(frgb);
end


% --- Executes on button press in togglebutton10.
function togglebutton10_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton10
a = get(hObject,'Value');

if a == 1
    set(handles.uipanel19,'Visible','on');
    set(handles.togglebutton10,'String','Full Screen');
    set(handles.pushbutton3,'Visible','off');
    set(handles.pushbutton4,'Visible','off');
    set(handles.pushbutton2,'Visible','off');
    set(handles.uipanel5,'Visible','off');
    set(handles.uipanel6,'Visible','off');
    set(handles.uipanel22,'Visible','off');
else
    set(handles.uipanel19,'Visible','off');
    set(handles.togglebutton10,'String','Small Screen');
    set(handles.pushbutton3,'Visible','on');
    set(handles.pushbutton4,'Visible','on');
    set(handles.pushbutton2,'Visible','on');
    set(handles.uipanel5,'Visible','on');
    set(handles.uipanel6,'Visible','on');
    set(handles.uipanel22,'Visible','on');
end
