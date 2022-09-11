#!/usr/bin/perl
use CGI;
$query = new CGI;

$loginnaam = $query->param('loginnaam');          #sets users address
$jaar = $query->param('jaar'); 
dbmopen(%nieuw,'nieuw',0666);    #opens database

print "Content-Type: text/html\n\n";     #gives command to print in a new html page

foreach $_ (values %nieuw)         
{
	@data = split(/&/);                            #Splits up profile
	print "dteller: $data[0]<br>";       #prints username
	print "wteller: $data[1]<br>"; 
	print "d800: $data[2]<br>";         #prints user's password
	print "d900: $data[3]<br>";       #Prints users real name
	print "d1000: $data[4]<br>";
	print "d1100: $data[5]<br>";         #prints user's password
	print "d1200: $data[6]<br>";       #Prints users real name
	print "d1300: $data[7]<br>";
	print "d1400: $data[8]<br>";         #prints user's password
	print "d1500: $data[9]<br>";       #Prints users real name
	print "d1600: $data[10]<br>";
	print "d1700: $data[11]<br>";         #prints user's password
	print "d1800: $data[12]<br>";       #Prints users real name
	print "d1900: $data[13]<br>";
	print "d2000: $data[14]<br>";         #prints user's password
	print "d2100: $data[15]<br>";       #Prints users real name
	print "taken: $data[16]<br>";         #prints user's password
	print "extra1: $data[17]<br>";         #prints user's password
	print "extra2: $data[18]<br>";         #prints user's password
	print "dagnummer: $data[19]<br>";         #prints user's password
	print "<br><br>";
}

dbmclose(%nieuw);    #closes database
