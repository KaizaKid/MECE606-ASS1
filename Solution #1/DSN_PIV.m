%MecE 606 Program #1: Handling Image in Matlab: SOLUTION
%DSN, Sept 2012
% DESCRIPTION
% This prgram will open two images with sequential names.
% Data on the images are desplyed on the GUI
% A toggle button allows toggling between images to show the moving 
% particle field 
%**********************************************************
% FUNCTIONS
%Function FrameToggle_Callback will get the value from the slider and then
%display either the first or second image

%Functions DisplayImg1 and DisplayImg2 display the images on screen
%These functions are called by loadIMG_CB_Callback and FrameToggle_Callback
%to display the images on screen

%Program will allow for tif, bmp, jpeg or gif to be opened

%Function loadIMG_CB_Callback will load the find the name of the image file
%and display the first image on screen

%Function aboutCBbutton_Callback will display authoer information

%**********************************************************
function varargout = DSN_PIV(varargin)
% This is the initialization code
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSN_PIV_OpeningFcn, ...
                   'gui_OutputFcn',  @DSN_PIV_OutputFcn, ...
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

%**********************************************************
% --- Executes just before DSN_PIV is made visible.
function DSN_PIV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function 
%       - starts the GUI
%       - determines the size of the screen and locates the GUI
%       - 
handles.output = hObject; % give the object a handle
guidata(hObject, handles);
MecEImg=imread('MecE.jpg');     % Load the engineering logo
imshow(MecEImg);                % Put logo on the screen
%position the GUI in the north west corner of the screen out of the way of
%the images
scrsz = get(0,'ScreenSize');
movegui(hObject, [80 scrsz(4)]);
%set(1, 'Position',[325 scrsz(4)/2-75 scrsz(3)/2 scrsz(4)/2]);
    
%movegui(hObject, 'northwest')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DSN_PIV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSN_PIV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function LoadIMG_edit_Callback(hObject, eventdata, handles)
% hObject    handle to LoadIMG_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadIMG_edit as text
%        str2double(get(hObject,'String')) returns contents of LoadIMG_edit as a double


% --- Executes during object creation, after setting all properties.
function LoadIMG_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadIMG_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadIMG_CB.
function loadIMG_CB_Callback(hObject, eventdata, handles)
% hObject    handle to loadIMG_CB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_name
global img_path
global imageScale
%Select the image file to be displayed
[img_name, img_path] = uigetfile({'*.*';'*.bmp';'*.tif';'*.jpeg';'*.gif'},'Choose Image File');
%Get the scale of the images from the GUI
imageScale = str2double(get(handles.imgScaleFactor, 'String'));
imageOffsetX=str2double(get(handles.imgOffsetX, 'String'));
imageOffsetY=str2double(get(handles.imgOffsetX, 'String'));
if img_name ~= 0
    %Find the period (.) before the file extension and remove the _ and
    %number from the filename. Display only the root file name in the GUI
    index1 = strfind(img_name,'.');
    index2 = index1;
    while strcmp(img_name(index2),'_') ~= 1
        index2 = index2 - 1;
    end
    img_name = strcat(img_name(1:index2-1),img_name(index1:end));

    set(handles.LoadIMG_edit,'String',img_name);
    %Get the size of computer screen and display image in the lefthand 
    %corner of the screen out of the way of the GUI
    scrsz = get(0,'ScreenSize');
    figure(1);
    set(1, 'Position',[360 scrsz(4)/2-75 scrsz(3)/2 scrsz(4)/2]);
    DisplayImg1(img_path, img_name,handles, imageScale,imageOffsetX,imageOffsetY)
else
    set(handles.LoadIMG_edit,'String','');
end


% --- Executes during object creation, after setting all properties.
function FrameToggle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FrameToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in ImageDataBox.
function ImageDataBox_Callback(hObject, eventdata, handles)
% hObject    handle to ImageDataBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ImageDataBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImageDataBox


% --- Executes during object creation, after setting all properties.
function ImageDataBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageDataBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imgScaleFactor_Callback(hObject, eventdata, handles)
% hObject    handle to imgScaleFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgScaleFactor as text
%        str2double(get(hObject,'String')) returns contents of imgScaleFactor as a double


% --- Executes during object creation, after setting all properties.
function imgScaleFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgScaleFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%=========================================================================
%DisplayImg1:: Display the first image and displays image information
%in the list box
%Image will rescale when the image scale is changed and the slider is moved
%=========================================================================
function DisplayImg1(img_path, img_name,handles, imageScale,imageOffsetX,imageOffsetY)
    %Find the period(.) before the file extenstion and add the image number
    %to the file name
    index3 = strfind(img_name,'.');
    imgName1 = strcat(img_name(1:index3-1),'_01', img_name(index3:end));
    img1 = strcat(img_path, imgName1);
    %read image 1, collect image 1 information, display image 1 info in
    %list box and display image 1
    a=imread(img1);
    %get the information for image 2
    img1Data = imfinfo(img1)
    img1DataString = {sprintf('FileName: %s', img1Data.Filename); sprintf('FileModDate: %s', img1Data.FileModDate);sprintf('Image Format: %s', img1Data.Format); sprintf('Image Size: %d x %d', img1Data.Width, img1Data.Height); sprintf('Image Bit Depth: %d', img1Data.BitDepth)};
    set(handles.ImageDataBox, 'String', img1DataString, 'Value', 1);
    figure(1);
   %Display image 1 and scale according to the image scale in the GUI
    imagesc(imageOffsetX:img1Data.Width*imageScale, imageOffsetY:img1Data.Height*imageScale,a);
    colormap gray;
    %axis([0 img1Data.Width*imageScale 0 img1Data.Height*imageScale]);
    %set the image axes depending on the image scale
    if imageScale == 1
        xlabel('{\itx} (pixels)');
        ylabel('{\ity} (pixels)');
    else
        xlabel('{\itx} (mm)');
        ylabel('{\ity} (mm)');
    end
%=========================================================================
%DisplayImg2:: Display the second image and displays image information
%in the list box
%Image will rescale when the image scale is changed and the slider is moved
%=========================================================================
function DisplayImg2(img_path, img_name, handles, imageScale,imageOffsetX,imageOffsetY)
    %Find the period(.) before the file extenstion and add the image number
    %to the file name
    index3 = strfind(img_name,'.');    
    imgName2 = strcat(img_name(1:index3-1),'_02', img_name(index3:end));
    img2 = strcat(img_path, imgName2);
    %read image 2, collect image 2 information, display image 2 info in
    %list box and display image 2
    b=imread(img2);
    %get the information for image 2
    img2Data = imfinfo(img2);
    img2DataString = {sprintf('FileName: %s', img2Data.Filename); sprintf('FileModDate: %s', img2Data.FileModDate);sprintf('Image Format: %s', img2Data.Format); sprintf('Image Size: %d x %d', img2Data.Width, img2Data.Height); sprintf('Image Bit Depth: %d', img2Data.BitDepth)};
    set(handles.ImageDataBox, 'String', img2DataString, 'Value', 1);
    figure(1);
    %Display image 2 and scale according to the image scale in the GUI
    imagesc(imageOffsetX:img2Data.Width*imageScale, imageOffsetY:img2Data.Height*imageScale,b)
    colormap gray
    %axis([0 img2Data.Width*imageScale 0 img2Data.Height*imageScale]);
    %set the image axes depending on the image scale
     if imageScale == 1
        xlabel('{\itx} (pixels)');
        ylabel('{\ity} (pixels)');
    else
        xlabel('{\itx} (mm)');
        ylabel('{\ity} (mm)');
    end


% --- Executes on button press in aboutCBbutton.
function aboutCBbutton_Callback(hObject, eventdata, handles)
% hObject    handle to aboutCBbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Tell the user who wrote this program
h = msgbox(sprintf('Course: MecE 606\nAuthor: DSN\nDate: Sept, 2012'),'LoadIMG_GUI Info');


function imgOffsetX_Callback(hObject, eventdata, handles)
% hObject    handle to imgOffsetX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgOffsetX as text
%        str2double(get(hObject,'String')) returns contents of imgOffsetX as a double


% --- Executes during object creation, after setting all properties.
function imgOffsetX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgOffsetX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function imgOffsetY_Callback(hObject, eventdata, handles)
% hObject    handle to imgOffsetY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgOffsetY as text
%        str2double(get(hObject,'String')) returns contents of imgOffsetY as a double

% --- Executes during object creation, after setting all properties.
function imgOffsetY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgOffsetY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Toggle_Button.
function Toggle_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Toggle_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Toggle_Button
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global img_name
global img_path
%read the string for image scale and create a number
imageScale = str2double(get(handles.imgScaleFactor, 'String'));
%read the string for image offset and create a number
imageOffsetX=str2double(get(handles.imgOffsetX, 'String'));
imageOffsetY=str2double(get(handles.imgOffsetY, 'String'));
%Get the value from the Toggle_Button 0 or 1 and display the corresponding image
sliderval = get(handles.Toggle_Button, 'Value');

if sliderval == 0  
    %Display image 1 and list image data in list box
    DisplayImg1(img_path, img_name,handles, imageScale,imageOffsetX,imageOffsetY);
end
if sliderval == 1
    %Display image 2 and list image data in list box
    DisplayImg2(img_path, img_name,handles, imageScale,imageOffsetX,imageOffsetY);    
end





% --- Executes when user attempts to close figure1.
%function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Close all Figures
%close(1);

% Hint: delete(hObject) closes the figure
%delete(hObject);


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
