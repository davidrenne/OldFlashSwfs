#!/usr/bin/perl
use CGI;

use Config;
$query = new CGI;
$Filename = 'record2';

$Database = '/home/sites/www.oplossen.nl/cgi-bin/agenda/';

print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";


dbmopen(%users,'users',0666);     #opens database


$usr = $query->param('usr');      #takes input from "usr" textbox 
$pwd = $query->param('pwd');        #takes input from "pwd" textbox

$_ = $users{$usr};
@data = split(/&/);   #splits up profile


if ($pwd eq $data[0])  #looks to see if the user name and password match the info in the 
{
	print "statein=done&fullname=$data[2]&address=$data[3]&city=$data[4]&zip=$data[6]&email=$data[7]";
	exit 0;
}
else
{
	# Print the contents of the file to Flash 4.
print "statein=fout";
exit 0;
}

dbmclose(%users);   #closes database

