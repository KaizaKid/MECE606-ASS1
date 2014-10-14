% MECE_606_KAISERLEUNG MATLAB code for MecE_606_KaiserLeung.fig
%      MECE_606_KAISERLEUNG, by itself, creates a new MECE_606_KAISERLEUNG or raises the existing
%      singleton*.
%
%      H = MECE_606_KAISERLEUNG returns the handle to a new MECE_606_KAISERLEUNG or the handle to
%      the existing singleton*.
%
%      MECE_606_KAISERLEUNG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MECE_606_KAISERLEUNG.M with the given input arguments.
%
%      MECE_606_KAISERLEUNG('Property','Value',...) creates a new MECE_606_KAISERLEUNG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MecE_606_KaiserLeung_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MecE_606_KaiserLeung_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES




function varargout = MecE_606_KaiserLeung(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MecE_606_KaiserLeung_OpeningFcn, ...
                   'gui_OutputFcn',  @MecE_606_KaiserLeung_OutputFcn, ...
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

end

% --- Executes just before MecE_606_KaiserLeung is made visible.
function MecE_606_KaiserLeung_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MecE_606_KaiserLeung (see VARARGIN)

% Choose default command line output for MecE_606_KaiserLeung
handles.output = hObject;

%Taken from Solution #1 on eclass
%Credit: Dr. Nobes
screensize = get(0,'ScreenSize');
movegui(hObject, [40 screensize(4)]);

% Update handles structure
guidata(hObject, handles);

end

% UIWAIT makes MecE_606_KaiserLeung wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = MecE_606_KaiserLeung_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function LoadImageCB_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImageCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LoadImageCB as text
%        str2double(get(hObject,'String')) returns contents of LoadImageCB as a double
end

% --- Executes during object creation, after setting all properties.
function LoadImageCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LoadImageCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in LoadImage.
function LoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Create global variables that will be used through out.
%This solution based off Solution #1 for Assignment #1
global ImName
global ImPath
global ImScale

[ImName, ImPath] = uigetfile({'*.*';'*.bmp';'*.tif';'*.jpeg';'*.gif'},'Choose Image File');

ImScale = str2double(get(handles.ImageScalingCB, 'String'));
ImOffsetX = str2double(get(handles.ImageOffsetXCB, 'String'));
ImOffsetY = str2double(get(handles.ImageOffsetYCB, 'String'));

if Im1 ~= 0
    %Find the period (.) before the file extension and remove the _ and
    %number from the filename. Display only the roote file name in GUI
    Index1 = strfind(ImName,'.');
    Index2 = Index1;
    while strcmp(ImName(Index2),'_') ~= 1
        Index2 = Index2 - 1;
    end
    ImName = strcat(ImName(1:Index2-1),ImName(Index1:end));
    
    %Sets the white box to the image name
    set(handles.LoadImageCB,'String',ImName);
    
    %Get size of computer screen and display image in the lefthand corner
    %of the screen out of the way of the GUI
    screensize = get(0,'ScreenSize');
    %Create figure
    figure(1);
    set(1, 'Position',[360 screensize(4)/2-75 screensize(3)/2 screensize(4)/2]);
    DisplayImage1(ImPath, ImName, handles, ImScale, ImOffsetX, ImOffsetY);
else
    set(handles.LoadImageCB,'String','');
end

end


% --- Executes on button press in ToggleButton.
function ToggleButton_Callback(hObject, eventdata, handles)
% hObject    handle to ToggleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
end


function ImageScalingCB_Callback(hObject, eventdata, handles)
% hObject    handle to ImageScalingCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImageScalingCB as text
%        str2double(get(hObject,'String')) returns contents of ImageScalingCB as a double
end

% --- Executes during object creation, after setting all properties.
function ImageScalingCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageScalingCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function ImageOffsetXCB_Callback(hObject, eventdata, handles)
% hObject    handle to ImageOffsetXCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImageOffsetXCB as text
%        str2double(get(hObject,'String')) returns contents of ImageOffsetXCB as a double
end

% --- Executes during object creation, after setting all properties.
function ImageOffsetXCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageOffsetXCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function ImageOffsetYCB_Callback(hObject, eventdata, handles)
% hObject    handle to ImageOffsetYCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImageOffsetYCB as text
%        str2double(get(hObject,'String')) returns contents of ImageOffsetYCB as a double
end

% --- Executes during object creation, after setting all properties.
function ImageOffsetYCB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageOffsetYCB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in ImagePropList.
function ImagePropList_Callback(hObject, eventdata, handles)
% hObject    handle to ImagePropList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ImagePropList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImagePropList
end

% --- Executes during object creation, after setting all properties.
function ImagePropList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagePropList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

%==========================================================================
%This function was taken from Solution #1 from Assignment #1
%Credit: Dr. Nobes
%It takes the image to display and display image information in the list
%box. Image will rescale when image scale is changed
%==========================================================================

function DisplayImage1(ImPath, ImName, handles, ImScale, ImOffsetX, ImOffsetY)
    %Find the period(.) before the file extenstion and add the image number
    %to the file name
    Index3 = strfind(ImName,'.');
    ImName1 = strcat(ImName(1:Index3-1),'_01', ImName(Index3:end));
    Im1 = strcat(ImPath, ImName1);
    %read image 1, collect image 1 information, display image 1 info in
    %list box and display image 1
    a=imread(img1);
    %get the information for image 2
    Im1Data = imfinfo(Im1)
    Im1DataString = {sprintf('FileName: %s', Im1Data.Filename); sprintf('FileModDate: %s', Im1Data.FileModDate);sprintf('Image Format: %s', Im1Data.Format); sprintf('Image Size: %d x %d', Im1Data.Width, Im1Data.Height); sprintf('Image Bit Depth: %d', Im1Data.BitDepth)};
    set(handles.ImageDataBox, 'String', Im1DataString, 'Value', 1);
    figure(1);
   %Display image 1 and scale according to the image scale in the GUI
    imagesc(ImOffsetX:Im1Data.Width*ImScale, ImOffsetY:Im1Data.Height*ImScale,a);
    colormap gray;
    %axis([0 Im1Data.Width*imageScale 0 Im1Data.Height*imageScale]);
    %set the image axes depending on the image scale
    if imageScale == 1
        xlabel('{\itx} (pixels)');
        ylabel('{\ity} (pixels)');
    else
        xlabel('{\itx} (mm)');
        ylabel('{\ity} (mm)');
    end

end
