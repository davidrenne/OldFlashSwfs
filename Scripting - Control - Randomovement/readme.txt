-------------------------------------------------------
Random_movement_3.fla
-------------------------------------------------------
© 2000 dan mcfarland || dan@sinch.net || http://www.sinch.net

This file can be configured many different ways by changing a few variables.  THis requires at least a general knowledge of actionscripting and a good working knowledge of the Flash 4 interface.

You can control the number of objects created, the range of sizes, the range of transparency, the range of speed, and the appearance of the objects themselves.

1. To change the NUMBER OF OBJECTS created, you will be changing the values for "n" and "c" in the 2 buttons instances "square(toggle)" and "circle (toggle)" on the bottom of the main stage.   When you first open the file the values are all set to "16."  You can change them to any number you like, but always make sure that they are all set to the SAME NUMBER or else you will encounter some problems.  It is recommended that you choose a number between 1 and 30.  Anything higher than that and the performance will start to noticeablly slow down.

2. To change the appearance of the objects you will need to edit "square button" and/or "circle/button."  Remember to change the appearance on all 4 frames of the button.  Iit is possible to add different states for Up, Over, and Down, but when you first open the file they are all the same.  Keep in mind that the movie resets the size of each object to a square value, meaning that the height and width are the same.  If you use an irregular shape you will either have to play around with the "height" and "width" variables or just let the movie do what it wants to do.

3. All other variables are configured within the "square" and "circle" movie clips on the main stage.  You will be editing the actions on FRAME ONE, layer "a" of each clip.  All variables are generated randomly when they are created and each time you roll over an instance.

	SPEED - The variables "x_move" and "y_move" determine the speed of each object and are generated randomly.  At first use, they are set to "Random(20) - Random(20)."  Basically this generates a random number between 20 and negative 20.  (positive numbers are up and right movements and negative numbers are left and down, so you need a range of both positive and negative numbers.)  
                              To increase the speed use higher numbers.  To decrease speed, use lower numbers.  I like to use the same number to give a nice even range, but it is not necessary.  You can really use any 2 numbers you want.

	SIZE - The variables "height" and "width" determine the size of each object.  These are also generated randomly using "a number + Random(100)" or something similar.  This takes a starting number (so the size is always at least large enough to see the object) and adds to it a random number.  
                           To increase the size range, increase the random number [ Random(thisnumber) ] and to decrease the range, decrease the number.
                           Note:  This action determines the width and then just sets the "height" to equal whatever the "width" is.  You can replace that with the same formula used for the "width" to generate a more random shape.
	
	TRANSPARENCY - The variable "alphastate" controls the transparency range.  Increase or decrease the Random(number) to increase or decrease the range.

