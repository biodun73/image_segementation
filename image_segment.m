function varargout = image_segment(varargin)
% IMAGE_SEGMENT MATLAB code for image_segment.fig
%      IMAGE_SEGMENT, by itself, creates a new IMAGE_SEGMENT or raises the existing
%      singleton*.
%
%      H = IMAGE_SEGMENT returns the handle to a new IMAGE_SEGMENT or the handle to
%      the existing singleton*.
%
%      IMAGE_SEGMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_SEGMENT.M with the given input arguments.
%
%      IMAGE_SEGMENT('Property','Value',...) creates a new IMAGE_SEGMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before image_segment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to image_segment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help image_segment

% Last Modified by GUIDE v2.5 04-Apr-2022 23:49:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @image_segment_OpeningFcn, ...
                   'gui_OutputFcn',  @image_segment_OutputFcn, ...
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


% --- Executes just before image_segment is made visible.
function image_segment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to image_segment (see VARARGIN)

% Choose default command line output for image_segment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes image_segment wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global Seg
handles.output = hObject;
handles.Seg = 0;
handles.BW = 0;
handles.Sharp = 0;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = image_segment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imageLoad;
waitfor(msgbox('Please import an x-ray file of type jpg,jpeg or png any other type would end in failure.', 'Notification'));
[image, impath] = uigetfile({'*.jpg';'*.png';'*.jpeg';'*.*'}, 'Choose an x-ray Image');
 if isequal(image, 0) % if user cancels then show canceled
    disp('cancel button has clicked');
    waitfor(msgbox('cancel button has clicked', 'Canceled'));
    return;
 else
    
    imageLoad = imread(fullfile(impath,image));
    axes(handles.axes1);
    imshow(imageLoad);
    myicon = imread('okIcon.jpg');
    waitfor(msgbox('Image had Succesfully loaded', 'Success', 'custom', myicon));
    title('X-ray segmentation');
    handles.imageLoad = imageLoad;
    guidata(hObject, handles);
 end 


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imageSave=handles.imageLoad;
imageFolder = userpath
defaultFileName = fullfile(imageFolder, '.jpg');
[folderFileName, folder] = uiputfile(defaultFileName, 'Specify a file');
if(folderFileName == 0)
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, folderFileName);%get the image 
imwrite(imageSave, fullFileName); %save the image file
axes(handles.axes1);
imshow(imageSave)
myicon = imread('okIcon.jpg');
waitfor(msgbox('Image export sucessfully', 'Success', 'custom', myicon));
title('Image export');
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cannyImage
imageSample=handles.imageLoad;
cannyImage = rgb2gray(imageSample);
cannyImage = edge(cannyImage, 'canny');
axes(handles.axes1);
imshow(cannyImage);
title('Canny Edge Detection');
handles.cannyImage = cannyImage;
guidata(hObject, handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sobelimage
imageSample=handles.imageLoad;
 sobelimage = rgb2gray(imageSample);
 sobelimage = edge( sobelimage, 'sobel');
axes(handles.axes1);
imshow( sobelimage);
title('Sobel Edge Detection');
handles. sobelimage =  sobelimage;
guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newvalT = 0;
handles.newvalB = 0;

imageSample=handles.imageLoad;
axes(handles.axes1);
imshow(imageSample)
myicon = imread('okIcon.jpg');
waitfor(msgbox('Reset Image was Succesfull', 'Success', 'custom', myicon));
title('X-ray Reset');
handles.Seg = 0;
handles.BW = 0;
handles.Sharp = 0;


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global newvalT BW %declaring global variables
imageSample=handles.imageLoad; %loading image
k = numel(size(imageSample))>=3; %Checking if image is 3 dimension or 2 dimension
if(k == 0)
    gray = imageSample;
else
    gray = rgb2gray(imageSample); %converting image into grayscale
end
maxlevel = graythresh(gray); %finding out the maximum threshold level in image
set(hObject, 'min', 0);
set(hObject, 'max', maxlevel);
val = get(hObject,'value');

newvalT = val;
BW = im2bw(gray, newvalT);
axes(handles.axes1);
imshow(BW)
title('Thresholding');
handles.newvalT = newvalT;
handles.BW = BW;
handles.BW = 1;
guidata(hObject, handles);
