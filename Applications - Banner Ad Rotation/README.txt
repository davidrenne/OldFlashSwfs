************************
****AdRotator widget****
************************

Author:Brian Weil
Email:Brian@SkunkBros.com

You may use or alter this software free of any royalties. 
I only ask that you let me know if you are using it.


************************
****  Description   **** 

This widget is designed to rotate sponsors advertisements through your flash movies in a controlled manner.
Once it is installed you do not need to edit your .fla files to change/add/modify your banners, or the rotation time.
You simply edit the vars.txt file located in the same directory as your movie.
The movie first displays a random banner from your banner directory, then rotates through them numerically.


*************************
**** How-To / Set-up ****

1.Create one .swf file for each banner, you can have as many banners as you need.

2.Name each banner with a sequential number starting with 1 ...   b(number).swf
	ex.(b1.swf,b2.swf,b3.swf,etc...)

3.Edit vars.txt like so:
	change the value of timeout to equal the amount of seconds each banner should be displayed
	change the value of numBanners to equal how many banners you have
	change the value of banner1URL to equal the location that b1.swf should link to
	add a new banner(number)URL variable/value pair for each new banner you've added
	result=okay should always be the last variable/value pair (this tells the movie when all variables are loaded)
	the file must be in a URLencoded format

4.All of your files must be in the same directory (yourMovieName.swf,vars.txt,b1.swf,b2.swf,b3.swf,etc...)

5.In your movie place the movieclip named "banner" where you would like the banners to appear.
	("banner" contains three other symbols that it will carry with it)

*************************
****   URLencoding   ****

The URLencoded vars.txt file must be one string with no blank spaces.
The string consists of varible/value pairs separated by the ampersand character.
Blank spaces can be replaced by %20
	ex.(firstName=Brian&lastName=Weil&Email%20Address=Brian@SkunkBros.com)


I have included the script from the adRotator actionclip in a text file so it is easier to read.
If I forgot anything I'm sure you can figure it out from here!