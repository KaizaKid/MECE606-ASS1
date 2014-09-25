function MECE606KLEUNG
%A function that generates a GUI that uploads and displays 
%two images where a button is present to toggle a switch
%between the two images
%Made by Kaiser Leung, CCID: kleung, ID#: 1234886

%Closes all windows and clear command windows
close all;
clc;

%Create toggler variable
%h.toggler = 1;
assignin('base','toggler',1);

%Creates a figure and store its structure in a handle so it can be called 
%later (indirectly). 
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.fig = figure('position',[200 150 400 600]);

%Create a button that can be used later to toggle the images also w/ handle
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.togglebutton = uicontrol('style','pushbutton','position',[150 490 100 20],'string','Toggle Image');

%Create two buttons to prompt the user to upload images
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.imageload1 = uicontrol('style','pushbutton','position',[75 540 250 20],'string','Select Image 1');
h.imageload2 = uicontrol('style','pushbutton','position',[75 520 250 20],'string','Select Image 2');

%Create uicontrol to output the image details. This includes all
%the information required for this assignment. Set a constant that is
%header of row, the other is the dynamic changing for image information
figure(1);
h.imageinfoC = uicontrol('Style','text','string','Image Type:','Position',[25 100 100 15]);
h.imageinfo = uicontrol('Style','text','string','','Position',[125 100 100 15]);
h.imagewidthC = uicontrol('Style','text','string','Width:','Position',[25 85 100 15]);
h.imagewidth = uicontrol('Style','text','string','','Position',[125 85 100 15]);
h.imageheightC = uicontrol('Style','text','string','Height:','Position',[25 70 100 15]);
h.imageheight = uicontrol('Style','text','string','','Position',[125 70 100 15]);
h.imagebdepthC = uicontrol('Style','text','string','Bit Depth:','Position',[25 55 100 15]);
h.imagebdepth = uicontrol('Style','text','string','','Position',[125 55 100 15]);

%The 'Toggle Image' button currently doesn't do anything. The below is a callback to
%set the button to toggle the image that will be uploaded
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
set(h.togglebutton,'callback',{@toggleimage,h});

%The below sets the 'Select Image 1' button to prompt an image upload
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
set(h.imageload1,'callback',{@uploadimage1,h});

%The below sets the 'Select Image 1' button to prompt an image upload
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
set(h.imageload2,'callback',{@uploadimage2,h});

%Create new figure window to display the images
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.fig1 = figure('position',[650 100 700 700]);

%imresize
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
I1 = evalin('base','I1');

%Using the indexed image and its corresponding color map
%Information of the function from MathWorks
%<http://www.mathworks.com/help/images/ref/ind2rgb.html>
I2 = evalin('base','I2');

%Set the figure that this section of code will produce images on. In this
%case it produces on figure 2 (image figure)
figure(2);

%Clear figure 2 so that next image can be displayed
clf(2);

%Gets the variable that is used in the if/else statement
togval = evalin('base','toggler');

%If/else that will change images based on the number value of toggle
if togval == 1
    %Show first image
    imshow(I1,'InitialMagnification',100*SCALAR);
    %imresize(I1,
    %Set toggler to other image
    assignin('base','toggler',2);
    
    %Grab image info structure and set each strings accordingly
    INFO1 = evalin('base','INFO1');
    format_str1 = getfield(INFO1,'Format');
    width_str1 = getfield(INFO1,'Width');
    height_str1 = getfield(INFO1,'Height');
    bdepth_str1 = getfield(INFO1,'BitDepth');
    
    %Set strings to display correct information
    set(h.imageinfo,'String',format_str1);
    set(h.imagewidth,'String',width_str1);
    set(h.imageheight,'String',height_str1);
    set(h.imagebdepth,'String',bdepth_str1);
    return
else
    %Show second image
    imshow(I2,'InitialMagnification',100*SCALAR);
    
    %Set toggler to other image
    assignin('base','toggler',1);
    
    %Grab image info structure and set each strings accordingly
    INFO2 = evalin('base','INFO2');
    format_str2 = getfield(INFO2,'Format');
    width_str2 = getfield(INFO2,'Width');
    height_str2 = getfield(INFO2,'Height');
    bdepth_str2 = getfield(INFO2,'BitDepth');
    
    %Set strings to display correct information
    set(h.imageinfo,'String',format_str2);
    set(h.imagewidth,'String',width_str2);
    set(h.imageheight,'String',height_str2);
    set(h.imagebdepth,'String',bdepth_str2);
    return
end

end


function h = uploadimage1(hObject,eventdata,h)
%This function is the action that the button 'Select Image 1' will perform 
%eventdata is a filler that doesn't do anything right now.
%Idea taken from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>

%Below reads instruction for the user to follow
disp('Select Image Button Pressed. Please select the first image.');

%Prompt user to select image while prompting user with instructions
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
[filename, user_canceled] = imgetfile;
    if user_canceled
    display('User Pressed Cancel')
    else
    display(['User Selected', filename])
    end

%Take the image loaded and place it into variables. It takes the image and
%stores the information of the image in one variable and colormap in another.
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>    
%[I1,map1] = imread(filename);
I1 = imread(filename);

%Take the information of the image and place it into a variable
%Line taken from MathWorks
%<http://www.mathworks.com/help/images/ref/imageinfo.html>
INFO1 = imfinfo(filename);

%From the loaded image the values of the image and the colormap must be
%placed as variables onto MATLAB workspace. This also includes the image
%details that are collected from "iminfo(filename)"
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
assignin('base','I1',I1);
assignin('base','INFO1',INFO1);

set(h.imageload1,'string',filename);

end

function h = uploadimage2(hObject,eventdata,h)
%This function is the action that the button 'Select Image 2' will perform 
%eventdata is a filler that doesn't do anything right now.
%Idea taken from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>

%Below reads instruction for the user to follow
disp('Select Image Button Pressed. Please select the second image.');

%Prompt user to select image while prompting user with instructions
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
[filename, user_canceled] = imgetfile;
    if user_canceled
    display('User Pressed Cancel')
    else
    display(['User Selected', filename])
    end

%Take the image loaded and place it into variables. It takes the image and
%stores the information of the image in one variable and colormap in another.
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>    
I2 = imread(filename);    

%Take the information of the image and place it into a variable
%Line taken from MathWorks
%<http://www.mathworks.com/help/images/ref/imageinfo.html>
INFO2 = imfinfo(filename);

%From the loaded image the values of the image and the colormap must be
%placed as variables onto MATLAB workspace
%Idea taken from Stackoverflow Forum
%<http://stackoverflow.com/questions/9938267/how-to-select-a-file-through-a-gui-in-matlab>
assignin('base','I2',I2);
assignin('base','INFO2',INFO2');

set(h.imageload2,'string',filename);

end





