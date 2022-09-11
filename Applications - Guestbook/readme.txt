-------------------------------------------------
README FILE FOR FLASH GUESTBOOK
-------------------------------------------------

Author: Matthias Kannengiesser 1999
Released from Flash Kit
http://www.flashkit.com

If you use this guestbook, please link back to flashkit,
at http://www.flashkit.com, even a tiny link is cool.

---------------------------------------------------------
BRIEF GUIDE
---------------------------------------------------------

Upload the script book.cgi and testbook.txt to your CGI-BIN directory

book.cgi (chmod 755) upload it as an ASCII file
testbook.txt (chmod 777 or 666 - it's your choice) upload it as an ASCII file

The script is a freeware one authored by Selena Sol and Matthew M. Wright. Modified 
by Matthias Kannengiesser 1999

Update the paths in the cgi script

	$basedir="/your/directory";
	$listfile="kitbook.txt";
	@referers = ('www.flashkit.com');

IN the fla

Change the Actionscripts in the first Frame of the "Actions" layer.
There you will find a command line that says:
Load Variables ("http://www.yoursite.com/cgi-bin/book.cgi", "", vars=POST)
Change the location to your book.cgi !
You will find the same entry in the actionscript of the submit button - change
it, too. That's it !

--------------------------------------------------------------------------

For Perl help, check out www.flashkit.com/links
