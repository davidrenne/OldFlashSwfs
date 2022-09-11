#!/usr/bin/perl

use CGI;
$query = new CGI;

print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";


$dteller = $query->param('dteller');                    #sets username 
$wteller = $query->param('wteller');
$d800 = $query->param('d800');               #sets 1st password entry
$d900 = $query->param('d900');                 #sets 2nd password entry
$d1000 = $query->param('d1000');       #sets fullname
$d1100 = $query->param('d1100');               #sets 1st password entry
$d1200 = $query->param('d1200');                 #sets 2nd password entry
$d1300 = $query->param('d1300');       #sets fullname
$d1400 = $query->param('d1400');               #sets 1st password entry
$d1500 = $query->param('d1500');                 #sets 2nd password entry
$d1600 = $query->param('d1600');       #sets fullname
$d1700 = $query->param('d1700');               #sets 1st password entry
$d1800 = $query->param('d1800');                 #sets 2nd password entry
$d1900 = $query->param('d1900');       #sets fullname
$d2000 = $query->param('d2000');               #sets 1st password entry
$d2100 = $query->param('d2100');                 #sets 2nd password entry
$loginnaam = $query->param('loginnaam');          #sets users address
$jaar = $query->param('jaar');                         #sets users city
$taken = $query->param('taken'); 
$extra1 = $query->param('extra1'); 
$extra2 = $query->param('extra2');
$dagnummer = $query->param('dagnummer'); 

$fn = $loginnaam . $jaar;
dbmopen(%afspraak,$fn,0666);    #opens database

$aantalrec = keys (%afspraak);


      		$profile = $dteller.'&'.$wteller.'&'.$d800.'&'.$d900.'&'.$d1000.'&'.$d1100.'&'.$d1200.'&'.$d1300.'&'.$d1400.'&'.$d1500.'&'.$d1600.'&'.$d1700.'&'.$d1800.'&'.$d1900.'&'.$d2000.'&'.$d2100.'&'.$taken.'&'.$extra1.'&'.$extra2.'&'.$dagnummer;     #sets the properties of the profile
	
		$afspraak{$dteller} = $profile;             #sets the profile in database
	
	 print "statein=gedaan";
	exit 0;

dbmclose(%afspraak);
