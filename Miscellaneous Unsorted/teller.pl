#!/usr/bin/perl

use CGI;
$query = new CGI;

print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";


$tell = 'a';
$counter = $query->param('counter');
$extra1 = $query->param('extra1'); 
$extra2 = $query->param('extra2');

dbmopen(%teller,'teller',0666);    #opens database
foreach $_ (values %teller)
{
	@data = split(/&/);

if ($tell eq $data[0])                  #checks to see if the username is taken
{
	$counter = $data[1];               #sets 1st password entry
			
	}
}
$counter++;
      		$profile = $tell.'&'.$counter.'&'.$extra1.'&'.$extra2;     #sets the properties of the profile
	
		$teller{$tell} = $profile;             #sets the profile in database
	
	 print "counter=$counter&statein=gedaan";
	exit 0;

dbmclose(%teller);
print "statein=nietgevonden";