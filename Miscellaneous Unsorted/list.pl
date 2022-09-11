#!/usr/bin/perl
dbmopen(%users, 'users', 0666);    #open's database

print "Content-Type: text/html\n\n";     #gives command to print in a new html page

foreach $_ (values %users)         
{
	@data = split(/&/);                            #Splits up profile
	print "User Name: $data[1]<br>";       #prints username
	print "Password: $data[0]<br>";         #prints user's password
	print "Real Name: $data[2]<br>";       #Prints users real name
	print "Address: $data[3]<br>";           #Prints users's address
	print "City: $data[4]<br>";                  #Prints users city
	print "State: $data[5]<br>";                #prints users state
	print "Zip: $data[6]<br>"; 	
	print "Email: $data[7]<br>";  #prints users email address
	print "Laatste: $data[8]<br>";
	print "id: $data[9]<br>";
	print "Titel: $data[10]<br>";
	print "Info: $data[11]<br><br><br>";

}

dbmclose(%users);    #closes database
