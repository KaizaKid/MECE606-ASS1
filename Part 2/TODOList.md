Assignment 2 TODO List
=======================

List of things that need to be done.
If anything, talk to professor to see a demo of the solution.


Part 1: Getting your code ready
------------------------------
Figure out how to do image cropping, and put it into your solution.
  * Refer to the solution from professor.
  * If this step takes too much time, use his code.
  * (As long as it works)

Part 2: Understanding what to code
-------------------------------
1. Find out how to use the `<xcorr>` function:
  * What inputs does it take in?
  * What are its outputs?
2. Find out how to make a 3D Vector Graph.
  * What inputs does it take in?
  * Does the graph automatically show in a new window?
3. Find out how to draw a box in the windows that contain a photo.
  * You should be able to calculate the size of the box.
4. Find out what "Scanning Mode" or "Sweeping" looks like.
  * If possible, ask the professor for a demo of a solution of Part 2.
  * Your professor might be murdering the English language.
  * **ANYTHING YOU DON'T UNDERSTAND SHOULD BE ASKED.**


Part 3: Planning the Code
---------------------------------

1. Write the GUI parts for user input:
  * Window Size
      * Ask the user for 2 measurements (height and width), in pixels
      * If professor can show you what it should look like, do it his way
  * Where to Crop
      * Ideally it is a coordinate (x,y)
      * You would use that coordinate as one of the corners of your box
2. Running the Cross-Correlation
  * Single Mode:
    * Provide a button that the user can click to start the cross-correlation.
  * Scanning Mode:
    * Until your professor actually tells you (or better, shows you) what on Earth he is talking about, I have no idea how to help you here.
3. Cross-Correlation Function
  * Use the `<xcorr>` function to calculate the correlation vectors.
4. Plot the 3D Graph
  * Hopefully, the `<xcorr>` function will give you sufficient data to run a graphing function, like `<plot>`

Part 4: Write the Code
---------------------------------
You're done planning!  Write it!
