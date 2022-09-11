#!/usr/bin/perl

use CGI;
$query = new CGI;

print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";

dbmopen(%users,'users',0666);    #opens database

$aantalrec = keys (%users);

$usr = $query->param('usr');                    #sets username 
$pwd1 = $query->param('pwd1');               #sets 1st password entry
$pwd2 = $query->param('pwd2');                 #sets 2nd password entry
$fullname = $query->param('fullname');       #sets fullname
$address = $query->param('address');          #sets users address
$city = $query->param('city');                         #sets users city
$state = $query->param('state');                       #sets users state
$zip = $query->param('zip');      	        #sets users zip
$email = $query->param('email');	          #sets users email address 
$id = $aantalrec +1;
$titel = $query->param('titel');
$info = $query->param('info');

if ($users{$usr})                  #checks to see if the username is already taken
{
	print "statein=bezet";
	exit 0;
}
else
{

	if ($pwd1 eq $pwd2)           #checks to make sure that the 2 password entry's are the same
	{
      		$profile = $pwd1.'&'.$usr.'&'.$fullname.'&'.$address.'&'.$city.'&'.$state.'&'.$zip.'&'.$email.'&'.$id.'&'.$titel.'&'.$info;     #sets the properties of the profile
	
		$users{$usr} = $profile;             #sets the profile in database
	
	 print "statein=done";
	exit 0;
	}
	else
	{
      	print "statein=wachtwoord";            #passwords in the two files did not match, redirects to d
	exit 0;

}
}
dbmclose(%users);
