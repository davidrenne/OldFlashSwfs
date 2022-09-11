#!/usr/bin/perl

use CGI;
$query = new CGI;

print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";


$dteller = $query->param('dteller');                    #sets username 
$loginnaam = $query->param('loginnaam');          #sets users address
$jaar = $query->param('jaar');                         #sets users city

$fn = $loginnaam . $jaar;
dbmopen(%afspraak,$fn,0666);    #opens database

foreach $_ (values %afspraak)
{
	@data = split(/&/);

if ($dteller eq $data[0])                  #checks to see if the username is taken
{
	$d800 = $data[2];               #sets 1st password entry
	$d900 = $data[3];       #sets fullname
	$d1000 = $data[4];    	        #sets users zip
	$d1100 = $data[5];               #sets 1st password entry
	$d1200 = $data[6];       #sets fullname
	$d1300 = $data[7];    	        #sets users zip
	$d1400 = $data[8];               #sets 1st password entry
	$d1500 = $data[9];       #sets fullname
	$d1600 = $data[10];    	        #sets users zip
	$d1700 = $data[11];               #sets 1st password entry
	$d1800 = $data[12];       #sets fullname
	$d1900 = $data[13];    	        #sets users zip
	$d2000 = $data[14];               #sets 1st password entry
	$d2100 = $data[15];       #sets fullname
	$taken = $data[16];
	$extra1 = $data[17];
	$extra2 = $data[18];
		
	print "d800=$d800&d900=$d900&d1000=$d1000&d1100=$d1100&d1200=$d1200&d1300=$d1300&d1400=$d1400&d1500=$d1500&d1600=$d1600&d1700=$d1700&d1800=$d1800&d1900=$d1900&d2000=$d2000&d2100=$d2100&taken=$taken&extra1=$extra1&extra2=$extra2&statein=oke";   
	exit 0; #sends user to a page stateing that the name is already taken
}
}
dbmclose(%afspraak);
print "statein=nietgevonden";