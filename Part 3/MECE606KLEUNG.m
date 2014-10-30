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
h.fig = figure('position',[150 150 350 620]);

%Create a button that can be used later to toggle the images also w/ handle
%From MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.togglebutton = uicontrol('style','pushbutton','position',...
                            [125 560 100 20],'string','Toggle Image');

%Create two buttons to prompt the user to upload images
%Idea from MATLAB Central
%<http://blogs.mathworks.com/pick/2007/12/28/matlab-basics-guis-without-guide/>
h.imageload1 = uicontrol('style','pushbutton','position',...
                            [250 580 50 20],'string','...');
%h.imageload2 = uicontrol('style','pushbutton','position',[75 520 250 20],'string','Select Image 2');
h.imagename = uicontrol('style','edit','position',[50 580 200 20],...
                            'string','','BackgroundColor','White');

%Create uicontrol to output the image details. This includes all
%the information required for this assignment. Set a constant that is
%header of row, the other is the dynamic changing for image information
figure(1);
h.imageinfoC = uicontrol('Style','text','string','Image Type:','Position',...  
                            [25 100 100 15],'BackgroundColor','White');
h.imageinfo = uicontrol('Style','text','string','','Position',...
                            [125 100 200 15],'BackgroundColor','White');
h.imagewidthC = uicontrol('Style','text','string','Width:','Position',...
                            [25 85 100 15],'BackgroundColor','White');
h.imagewidth = uicontrol('Style','text','string','','Position',...
                            [125 85 200 15],'BackgroundColor','White');
h.imageheightC = uicontrol('Style','text','string','Height:','Position',...
                            [25 70 100 15],'BackgroundColor','White');
h.imageheight = uicontrol('Style','text','string','','Position',...
                            [125 70 200 15],'BackgroundColor','White');
h.imagebdepthC = uicontrol('Style','text','string','Bit Depth:','Position',...
                            [25 55 100 15],'BackgroundColor','White');
h.imagebdepth = uicontrol('Style','text','string','','Position',...
                            [125 55 200 15],'BackgroundColor','White');
h.filenameC = uicontrol('style','text','string','Image Name:','Position',...
                            [25 40 100 15],'BackgroundColor','White');
h.filename = uicontrol('style','text','string','','Position',...
                            [125 40 200 15],'BackgroundColor','White');

%Insert Scale note
%Create textbox beside to display current scalar value
h.scalarbutton = uicontrol('style','text','position',[25 125 200 20],...
                            'string','Image Scale (mm/pixel): ',...
                            'FontSize',10,'HorizontalAlignment','Right');
h.scalardisplay = uicontrol('style','edit','string','1','position',...
                            [225 125 100 20],'BackgroundColor','White');

%Create offset windowss/text
h.offsettext = uicontrol('style','text','FontSize',20,'string',...
                            'Image Offset (pixels)',...
                            'Position',[25 195 300 35]);
h.offsetxC = uicontrol('style','text','FontSize',15,'string','X',...
                            'Position',[25 170 150 25]);
h.offsetyC = uicontrol('style','text','FontSize',15,'string','Y',...
                            'Position',[175 170 150 25]);
h.offsetx = uicontrol('style','edit','string','1','Position',...
                            [40 150 120 20],'BackgroundColor','White');
h.offsety = uicontrol('style','edit','string','1','Position',...
                            [190 150 120 20],'BackgroundColor','White');

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
h.windowsizetext = uicontrol('style','text','string','Cross Correlation Window Size',...
                                'FontSize',15,'Position',[25 520 300 30]);
h.widthC = uicontrol('style','text','string','Width','FontSize',10,...
                                'Position',[25 500 150 20]);
h.heightC = uicontrol('style','text','string','Height','FontSize',...
                                10,'Position',[175 500 150 20]);
h.winwidth = uicontrol('style','edit','string','40','Position',...
                                [25 480 150 20],'BackgroundColor','White');
h.winheight = uicontrol('style','edit','string','40','Position',...
                                [175 480 150 20],'BackgroundColor','White');

%Add option for window overlap
h.winoverC = uicontrol('style','text','string','Window Overlap (%):',...
                                'FontSize',12,'Position',[25 455 200 25]);
h.winover = uicontrol('style','edit','string','0','Position',...
                                [225 455 100 25],'BackgroundColor','White');

%Add location for the start of a subregion section in GUI
h.windowselecttext = uicontrol('style','text',...
                                'string','Window Starting Location',...
                                'FontSize',12,'Position',[25 435 300 20]);
h.windowselecttext1 = uicontrol('style','text',...
                                'string','(Single Sub Region)',...
                                'FontSize',12,'Position',[25 415 300 20]);
h.winselectxC = uicontrol('style','text','string','X location',...
                                'FontSize',12,'Position',[25 395 150 20]);
h.winselectyC = uicontrol('style','text','string','Y location',...
                                'FontSize',12,'Position',[175 395 150 20]);
h.winselectx = uicontrol('style','edit','string','',...
                                'Position',[25 375 150 20],...
                                'BackgroundColor','White');
h.winselecty = uicontrol('style','edit','string','',...
                                'Position',[175 375 150 20],...
                                'BackgroundColor','White');

%Set area for vector scaling and color choice
h.vectorscaleC = uicontrol('style','text','string','Vector Scale: ',...
                                'Position',[25 295 150 20],...
                                'FontSize',10,'HorizontalAlignment','Right');
h.vectorscale = uicontrol('style','edit','String','1',...
                                'Position',[175 295 150 20],...
                                'BackgroundColor','White');                              
%Set list for selection of color                             
h.vectorcolorC = uicontrol('style','text','String','Vector Color: ',...
                            'Position',[25 270 150 20],...
                            'FontSize',10,'HorizontalAlignment','Right');
h.fillerbecauseidontknowhowtoformat = uicontrol('style','text',...
                            'Position',[25 290 150 5]);
h.vectorcolor = uicontrol('style','popupmenu','String',...
                            {'Black';'Red';'Blue';'Yellow'},...
                            'FontSize',10,'Position',[175 275 150 20],...
                            'BackgroundColor','White');

%Create location to change color map (List control)
h.vectorcolmapC = uicontrol('style','text','String','Vector Color Map: ',...
                            'Position',[25 245 150 20],...
                            'FontSize',10,'HorizontalAlignment','Right');
h.fillerbecauseidontknowhowtoformat1 = uicontrol('style','text',...
                            'Position',[25 265 150 5]);
h.vectorcolmap = uicontrol('style','popupmenu','String',...
                            {'1','2','3','4'},...
                            'FontSize',10,'Position',[175 250 150 20],...
                            'BackgroundColor','White');
                        
%Add a new button to proceed with finding the correlation of a window size
%and subregion at the users input selection
h.crosscorrelatesub = uicontrol('style','pushbutton',...
                                'string','Cross Correlate (Sub-region)',...
                                'Position',[25 345 150 20]);
set(h.crosscorrelatesub,'callback',{@crosscorrelatesub,h});

%Set a new button to proceed with the correlation sweeping mode
h.crosscorrelatesweep = uicontrol('style','pushbutton',...
                                'string','Cross Correlate (Sweep)',...
                                'Position',[175 345 150 20]); 
set(h.crosscorrelatesweep,'callback',{@crosscorrelatesweep,h});

%Set new button for mouse correlation
h.crosscorrelatemouse = uicontrol('style','pushbutton',...
                                'string','Cross Correlate (Mouse Selection)',...
                                'Position',[75 325 200 20]);
set(h.crosscorrelatemouse,'callback',{@crosscorrelatemouse,h});         

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
set(2,'Position',[600 screensize(4)/2-100 screensize(3)/2 screensize(4)/2]);

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

function h = crosscorrelatesweep(hObject,eventdata,h)
%This function is set to cross correlate two images using the xcorr2
%function and output another graph depicting the calculated correlation in
%3D graph

global Image1
global Image2
global ImInfo1

%Read in user inputs from the windows
%Get winaverage from winwidth and winheight
winwidth = str2double(get(h.winwidth,'String'));
winheight = str2double(get(h.winheight,'String'));
winover = (str2double(get(h.winover,'String')))/100;

%Find number of windows (without overlap) that can fit into image
wincross = floor((ImInfo1.Width)/winwidth);
windown = floor((ImInfo1.Height)/winheight);

%Get scalar again and offsets
SCALAR = str2double(get(h.scalardisplay,'String'));
offsetx = str2double(get(h.offsetx,'String'));
offsety = str2double(get(h.offsety,'String'));

%Get vector scale and color
vecscale = str2double(get(h.vectorscale,'string'));
vecvalue = get(h.vectorcolor,'Value');

%Get screensize of computer to set sizes for window
screensize = get(0,'ScreenSize');

%Create zero matrix to store maximums of the correlation
if winover == 0
    
    VecMax = zeros(windown,wincross);
    VecX = zeros(windown,wincross);
    VecY = zeros(windown,wincross);
    
else
   
    VecMax = zeros(floor(windown/winover),floor(wincross/winover));
    VecX = zeros(floor(windown/winover),floor(wincross/winover));
    VecY = zeros(floor(windown/winover),floor(wincross/winover));
    
end

%Create a loop to scan throughout the image
for j = 1:1*(1-winover):windown

    for i = 1:1*(1-winover):wincross
        
        if ishandle(2) ==1 
            clf(2);
            figure(2);
            set(2,'Position',[600 screensize(4)/2+70 screensize(3)/3 screensize(4)/2-150]);
            imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
            colormap gray;
        else
            figure(2);
            set(2,'Position',[600 screensize(4)/2+70 screensize(3)/3 screensize(4)/2-150]);
            imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
            colormap gray;
        end
        
        %Take out sections of the images to cross correlate
        X1ij = Image1((1+((j-1)*winheight)):(j*winheight),(1+((i-1)*winwidth)):(i*winwidth));
        X2ij = Image2((1+((j-1)*winheight)):(j*winheight),(1+((i-1)*winwidth)):(i*winwidth));
        Cij = xcorr2(X1ij,X2ij);
        
        if winover == 0
            
            %Create row value in case winover is 0
            rowvalue = j;
            colvalue = i;
            
        else
            
            %Add values variables for x,y
            rowvalue = floor((j-1)/winover)+1;
            colvalue = floor((i-1)/winover)+1;
            
        end
        
        %Change the VecMax matrix to correct corresponding value
        VecMax(rowvalue,colvalue) = max(max(Cij));
        %[VecY(rowvalue,colvalue) VecX(rowvalue,colvalue)] = ...
            %find(Cij==max(max(Cij)),1);
        [VecY(rowvalue,colvalue) VecX(rowvalue,colvalue)] = ...
            ind2sub(size(Cij),find(Cij==VecMax(rowvalue,colvalue)));
            
        %Create a box on figure to indicate the location of the correlation
        rectangle('Position',...
            [(1+((i-1)*winwidth)) (1+((j-1)*winheight)) winwidth winheight],...
            'LineWidth',1,'EdgeColor','White');
        
        %Create new figure window for 3D viewing of function
        %figure(3);
        %set(3,'Position',[600 screensize(4)/2-450  screensize(3)/2.5 screensize(4)/2.5]);
        %mesh(Cij);
        %pause(1);
        
        %clf(3);
    end 
   
    
end

%Now after all the values have been calculated vectors should be drawn onto
%the figure with color and scaling Another for loop must be performed.

%Clear image figure (figure 2) and reupload a blank one to use
clf(2);
figure(2);
set(2,'Position',[600 screensize(4)/2-300 screensize(3)/3+350 screensize(4)/2+200]);
imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
colormap gray;
hold on;

%Change value into veccolor
switch vecvalue
    
    case 1
        
        veccolor = 'Black';
        
    case 2
        
        veccolor = 'Red';
        
    case 3
        
        veccolor = 'Blue';
        
    case 4
        
        veccolor = 'Yellow';
        
    otherwise
        
end

for j = 1:1*(1-winover):windown

    for i = 1:1*(1-winover):wincross
        
        %locate the center of the current box to start arrow
        Xij = ((1+((i-1)*winwidth))+(i*winwidth))/2;
        Yij = ((1+((j-1)*winheight))+(j*winheight))/2;
        
        if winover == 0
            
            %Create row value in case winover is 0
            rowvalue = j;
            colvalue = i;
            
        else
            
            %Add values variables for x,y
            rowvalue = floor((j-1)/winover)+1;
            colvalue = floor((i-1)/winover)+1;
            
        end
        
        %Draw vector using quiver
        quiver(Xij,Yij,VecX(rowvalue,colvalue),...
                VecY(rowvalue,colvalue),'Color',veccolor,...
                'AutoScaleFactor',vecscale)
                   
    end 
   
    
end

%Does a cross correlation of the two images as a whole without including
%window size and window overlap (or scanning function)
%C = xcorr2(Image1,Image2);

%[max, indices] = max(C);

%I need to find the vector of max correlation which involves taking from
%the maximums generated from above

end

function h = crosscorrelatesub(hObject,eventdata,h)
%This function is set to find a single cross correlation subregion
%indicated by the user via edit boxes. The cross correlation is then
%displayed in a new window under a ______ 3D figure

global Image1
global Image2
global ImInfo1

%Load in values from GUI
winwidth = str2double(get(h.winwidth,'String'));
winheight = str2double(get(h.winheight,'String'));
winselectx = str2double(get(h.winselectx,'String'));
winselecty = str2double(get(h.winselecty,'String'));
SCALAR = str2double(get(h.scalardisplay,'String'));
offsetx = str2double(get(h.offsetx,'String'));
offsety = str2double(get(h.offsety,'String'));
screensize = get(0,'ScreenSize');

%Create figure in case use does not toggle image first
if ishandle(2) == 1
    clf(2);
    figure(2);
    set(2,'Position',[600 screensize(4)/2-100 screensize(3)/2 screensize(4)/2]);
    imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
    colormap gray;
else
    figure(2);
    set(2,'Position',[600 screensize(4)/2-100 screensize(3)/2 screensize(4)/2]);
    imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
    colormap gray;
end
    
%Select area to be cross correlated
X1sub = Image1((1+winselecty):(1+winselecty+winheight),((1+winselectx):(1+winselectx+winwidth)));
X2sub = Image2((1+winselecty):(1+winselecty+winheight),((1+winselectx):(1+winselectx+winwidth)));
Csub = xcorr2(X1sub,X2sub);

%Indicate on the figure 
rectangle('Position',[(1+winselectx) (1+winselecty) winwidth winheight],'LineWidth',1,'EdgeColor','White');

%Create new figure for correlation
figure(3);
set(3,'Position',[600 screensize(4)/2-400  screensize(3)/2.5 screensize(4)/2.5]);
mesh(Csub);

end

function h = crosscorrelatemouse(hObject,eventdata,h)

global Image1
global Image2
global ImInfo1

%load in values
SCALAR = str2double(get(h.scalardisplay,'String'));
offsetx = str2double(get(h.offsetx,'String'));
offsety = str2double(get(h.offsety,'String'));
screensize = get(0,'ScreenSize');

%Cleans up or creates figure 2 depending if it exists or not
if ishandle(2) == 1
    clf(2);
    figure(2);
    set(2,'Position',[600 screensize(4)/2-100 screensize(3)/2 screensize(4)/2]);
    imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
    colormap gray;
else
    figure(2);
    set(2,'Position',[600 screensize(4)/2-100 screensize(3)/2 screensize(4)/2]);
    imagesc(offsetx:ImInfo1.Width*SCALAR, offsety:ImInfo1.Height*SCALAR,Image1);
    colormap gray;
end

%display some instructions
disp('Please select the top left corner of the desired window then the botton right corner of the window');
pause(2);

%Grab two points from user and set x,y, location as variables
[X,Y] = ginput(2);
xstart = X(1);
xend = X(2);
ystart = Y(1);
yend = Y(2);

%Select matrix to correlate
X1mouse = Image1(xstart:xend,ystart:yend);
X2mouse = Image2(xstart:xend,ystart:yend);
Cmouse = xcorr2(X1mouse,X2mouse);

%Indicate where the box for correlation occurs
rectangle('Position',[xstart ystart abs(xend-xstart) abs(ystart-yend)],'LineWidth',1,'EdgeColor','White');

%Create correlation graph
figure(3);
set(3,'Position',[600 screensize(4)/2-400  screensize(3)/2.5 screensize(4)/2.5]);
mesh(Cmouse);



end