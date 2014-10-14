function MECE606KLEUNG
%A function that generates a GUI that uploads and displays 
%two images where a button is present to toggle a switch
%between the two images
%Made by Kaiser Leung, CCID: kleung, ID#: 1234886

%Closes all windows and clear command windows
close all;
clc;

%Create toggler variable
%assignin('base','toggler',1);

%Create a scalar variable
%assignin('base','SCALAR',1);

%Creates a figure and store its structure in a handle so it can be called 
%later (indirectly). 
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.fig = figure('position',[150 150 350 600]);

%Create a button that can be used later to toggle the images also w/ handle
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.togglebutton = uicontrol('style','pushbutton','position',[125 520 100 20],'string','Toggle Image');

%Create two buttons to prompt the user to upload images
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.imageload1 = uicontrol('style','pushbutton','position',[250 540 50 20],'string','...');
%h.imageload2 = uicontrol('style','pushbutton','position',[75 520 250 20],'string','Select Image 2');
h.imagename = uicontrol('style','edit','position', [50 540 200 20],'string','','BackgroundColor','White');

%Create uicontrol to output the image details. This includes all
%the information required for this assignment. Set a constant that is
%header of row, the other is the dynamic changing for image information
figure(1);
h.imageinfoC = uicontrol('Style','text','string','Image Type:','Position',[25 100 100 15],'BackgroundColor','White');
h.imageinfo = uicontrol('Style','text','string','','Position',[125 100 200 15],'BackgroundColor','White');
h.imagewidthC = uicontrol('Style','text','string','Width:','Position',[25 85 100 15],'BackgroundColor','White');
h.imagewidth = uicontrol('Style','text','string','','Position',[125 85 200 15],'BackgroundColor','White');
h.imageheightC = uicontrol('Style','text','string','Height:','Position',[25 70 100 15],'BackgroundColor','White');
h.imageheight = uicontrol('Style','text','string','','Position',[125 70 200 15],'BackgroundColor','White');
h.imagebdepthC = uicontrol('Style','text','string','Bit Depth:','Position',[25 55 100 15],'BackgroundColor','White');
h.imagebdepth = uicontrol('Style','text','string','','Position',[125 55 200 15],'BackgroundColor','White');
h.filenameC = uicontrol('style','text','string','Image Name:','Position',[25 40 100 15],'BackgroundColor','White');
h.filename = uicontrol('style','text','string','','Position',[125 40 200 15],'BackgroundColor','White');

%Insert Scale note
%Create textbox beside to display current scalar value
h.scalarbutton = uicontrol('style','text','position',[25 125 200 20],'string','Image Scale (mm/pixel)','FontSize',10);
h.scalardisplay = uicontrol('style','edit','string','1','position',[225 125 100 20],'BackgroundColor','White');

%Create offset windowss/text
h.offsettext = uicontrol('style','text','FontSize',20,'string','Image Offset (pixels)','Position',[25 195 300 35]);
h.offsetxC = uicontrol('style','text','FontSize',15,'string','X','Position',[25 170 150 25]);
h.offsetyC = uicontrol('style','text','FontSize',15,'string','Y','Position',[175 170 150 25]);
h.offsetx = uicontrol('style','edit','string','1','Position',[40 150 120 20],'BackgroundColor','White');
h.offsety = uicontrol('style','edit','string','1','Position',[190 150 120 20],'BackgroundColor','White');

%The 'Toggle Image' button currently doesn't do anything. The below is a callback to
%set the button to toggle the image that will be uploaded
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
set(h.togglebutton,'callback',{@toggleimage,h});

%The below sets the 'Select Image 1' button to prompt an image upload
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
set(h.imageload1,'callback',{@uploadimage1,h});

%Set a window size option button
%Include edit textbox to grab users input
h.windowsizetext = uicontrol('style','text','string','Cross Correlation Window Size','FontSize',15,'Position',[25 480 300 30]);
h.widthC = uicontrol('style','text','string','Width','FontSize',10,'Position',[25 460 150 20]);
h.heightC = uicontrol('style','text','string','Height','FontSize',10,'Position',[175 460 150 20]);
h.winwidth = uicontrol('style','edit','string','','Position',[25 440 150 20],'BackgroundColor','White');
h.winheight = uicontrol('style','edit','string','','Position',[175 440 150 20],'BackgroundColor','White');

%Add option for window overlap
h.winoverC = uicontrol('style','text','string','Window Overlap (%):','FontSize',12,'Position',[25 415 200 25]);
h.winover = uicontrol('style','edit','string','','Position',[225 415 100 25],'BackgroundColor','White');

%Set a new button to proceed with the correlation
h.crosscorrelate = uicontrol('style','pushbutton','string','Cross Correlate','Position',[125 390 100 20]); 


end


function h = toggleimage(hObject,eventdata,h)
%This function is the action that the button 'toggleimage' will perform 
%eventdata is a filler that doesn't do anything right now.
%It brings in a toggler variable which tells it which image to bring up to
%the screen. There is an if/else loop below to change images.
%Idea taken from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
%Toggler Idea from consulting Clinton Wong (Friend)

%Create new figure window to display the images
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
%h.fig1 = figure('position',[650 100 700 700]);

%Using the indexed image and its corresponding color map
%Information of the function from MathWorks
%<http://www.mathworks.com/help/images/ref/ind2rgb.html>
%I1 = evalin('base','I1');

%Using the indexed image and its corresponding color map
%Information of the function from MathWorks
%<http://www.mathworks.com/help/images/ref/ind2rgb.html>
%I2 = evalin('base','I2');

global Image1
global ImInfo1
global Image2
global ImInfo2
global ImageName
global toggler

%Get screensize of computer to set sizes for window
screensize = get(0,'ScreenSize');

%Set the figure that this section of code will produce images on. In this
%case it produces on figure 2 (image figure). Along with location
figure(2);
set(2,'Position',[600 screensize(4)/2-250 screensize(3)/2 screensize(4)/2]);

%Clear figure 2 so that next image can be displayed
clf(2);

%Gets the variable that is used in the if/else statement
togval = toggler;

%Get the scalar variable into this function
SCALAR = str2double(get(h.scalardisplay,'String'));

%Get offsets
offsetx = str2double(get(h.offsetx,'String'));
offsety = str2double(get(h.offsety,'String'));

%Set names used in if loop below
index3 = strfind(ImageName,'.');
ImageName1 = strcat(ImageName(1:index3-1),'_01',ImageName(index3:end));
ImageName2 = strcat(ImageName(1:index3-1),'_02',ImageName(index3:end));

%If/else that will change images based on the number value of toggle
if togval == 1
    %Show first image
    %imshow(Image1,'InitialMagnification',100*SCALAR);
    imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
    colormap gray;
    
    %If else loop taken from solution 1. It labels the axis
    if SCALAR == 1
        xlabel('{\itx} (pixels)');
        ylabel('{\ity} (pixels)');
    else
        xlabel('{\itx} (mm)');
        ylabel('{\ity} (mm)');
    end
   
    %Set toggler to other image
    %assignin('base','toggler',2);
    toggler = 2;
    
    %Grab image info structure and set each strings accordingly
    %INFO1 = evalin('base','INFO1');
    format_str1 = getfield(ImInfo1,'Format');
    width_str1 = getfield(ImInfo1,'Width');
    height_str1 = getfield(ImInfo1,'Height');
    bdepth_str1 = getfield(ImInfo1,'BitDepth');
    
    %Set strings to display correct information
    set(h.imageinfo,'String',format_str1);
    set(h.imagewidth,'String',width_str1);
    set(h.imageheight,'String',height_str1);
    set(h.imagebdepth,'String',bdepth_str1);
    set(h.filename,'String',ImageName1);
    return
else
    %Show second image
    %imshow(Image2,'InitialMagnification',100*SCALAR);
    imagesc(offsetx:ImInfo2.Width*SCALAR, offsety:ImInfo2.Height*SCALAR,Image2);
    colormap gray;
    
    %If else loop taken from solution 1. Places label on the axis
    if SCALAR == 1
        xlabel('{\itx} (pixels)');
        ylabel('{\ity} (pixels)');
    else
        xlabel('{\itx} (mm)');
        ylabel('{\ity} (mm)');
    end
  
    %Set toggler to other image
    %assignin('base','toggler',1);
    toggler = 1;
    
    %Grab image info structure and set each strings accordingly
    %INFO2 = evalin('base','INFO2');
    format_str2 = getfield(ImInfo2,'Format');
    width_str2 = getfield(ImInfo2,'Width');
    height_str2 = getfield(ImInfo2,'Height');
    bdepth_str2 = getfield(ImInfo2,'BitDepth');
    
    %Set strings to display correct information
    set(h.imageinfo,'String',format_str2);
    set(h.imagewidth,'String',width_str2);
    set(h.imageheight,'String',height_str2);
    set(h.imagebdepth,'String',bdepth_str2);
    set(h.filename,'String',ImageName2);
    return
end

end

function h = uploadimage1(hObject,eventdata,h)
%This function is the action that the button 'Select Image 1' will perform 
%eventdata is a filler that doesn't do anything right now.
%Idea taken from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>

%Below reads instruction for the user to follow
%disp('Select Image Button Pressed. Please select the first image.');

%Take and make Image1 the global variable for one image
%At the same time set ImPath1 to global
global Image1
global ImInfo1
global Image2
global ImInfo2
global ImageName
global ImPath1

%Prompt user to select image while prompting user with instructions
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
[ImageName, ImPath1] = uigetfile({'*.*';'*.bmp';'*.tif';'*.jpeg';'*.gif'},'Choose Image File');
    %if user_canceled
    %display('User Pressed Cancel')
    %else
    %display(['User Selected', filename])
    %end
    
%Take the image loaded and place it into variables. It takes the image and
%stores the information of the image in one variable and colormap in another.
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>    
%[I1,map1] = imread(filename);
Image1 = imread(ImageName);

%Take the information of the image and place it into a variable
%Line taken from MathWorks
%<http://www.mathworks.com/help/images/ref/imageinfo.html>
ImInfo1 = imfinfo(ImageName);

if ImageName ~=0    
    %Find the period (.) before the file extension and remove the _ and the
    %number from the filename. Display only the roote file name in the
    %interface. Taken from Solution #1 of Program #1
    index1 = strfind(ImageName,'.');
    index2 = index1;
    while strcmp(ImageName(index2),'_') ~= 1
        index2 = index2 -1;
    end
    ImageName = strcat(ImageName(1:index2-1),ImageName(index1:end));
    set(h.imagename,'String',ImageName);
    
else
    set(h.imagename,'String','');
end
    
%Find the image
index3 = strfind(ImageName,'.');
ImageName2 = strcat(ImageName(1:index3-1),'_02',ImageName(index3:end));
Image2 = imread(ImageName2);
ImInfo2 = imfinfo(ImageName2);

%From the loaded image the values of the image and the colormap must be
%placed as variables onto MATLAB workspace. This also includes the image
%details that are collected from "iminfo(filename)"
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
%assignin('base','I1',I1);
%assignin('base','INFO1',INFO1);

%set(h.imageload1,'string',ImageName);

end

function h = crosscorrelate(hObject,eventdata,h)
%This function is set to cross correlate two images using the xcorr2
%function and output another graph depicting the calculated correlation in
%3D graph

global Image1
global Image2
global ImInfo1
%global ImInfo2

%Read in user inputs from the windows
winwidth = str2double(get(h.winwidth,'String'));
winheight = str2double(get(h.winheight,'String'));
winover = (str2double(get(h.winover,'String')))/100;

%Find number of windows (without overlap) that can fit into image
wincross = (ImInfo1.Width)/winwidth;
windown = (ImInfo1.Height)/winheight;

for i = 1:wincross-(wincross*winover):ImInfo1.Width;


    
   
    
end

%Does a cross correlation of the two images as a whole without including
%window size and window overlap (or scanning function)
%C = xcorr2(Image1,Image2);

%[max, indices] = max(C);

%I need to find the vector of max correlation which involves taking from
%the maximums generated from above

end