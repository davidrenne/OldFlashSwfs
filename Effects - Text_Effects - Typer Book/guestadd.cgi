#!/usr/bin/perl
#############################################################################

# path to your guestbook datafile, make sure set right permissions to it
$guestsrc='gb.txt';

# put your email here to receive notifications.
@from=('your@email.com');

# path to your email program
$mail='/usr/lib/sendmail';

#############################################################################

require 5;

&form_data;

#print result page
        open (GBK, $guestsrc);
        @DATA1=<GBK>;
        close (GBK);

	#### page count function ####
	# count the total number of pages
	$count=0;
	foreach $rec (@DATA1){
        	if ($rec =~ /&me=me&/){
                	$count++;
        	}
	}

print "Content-type: text/html\n\n";
print "test=test&add=okey&\n";

	#write to guestbook database
	open (GBK, $guestsrc);
        @DATA1=<GBK>;
	close (GBK);

	open (GBK, ">$guestsrc");


        print GBK "totalrec=$count&";

	print GBK "msg$count=$DATA{'msg'}&";
	print GBK "name$count=$DATA{'name'}&";
	print GBK "email$count=$DATA{'email'}&";
	print GBK "place$count=$DATA{'place'}&";
	$Date=localtime();
        print GBK "url$count=$DATA{'url'}&www$count=$DATA{'www'}";
	print GBK "&\n&me=me&\n&";

        foreach $item (@DATA1){
          $item =~ s/totalrec=/a=/g;
	  print GBK $item;
	}
	close (GBK);


	#send notification message
		foreach $fm (@from){
			open (MAIL, "|$mail $fm");
                	print MAIL "From: LunarBook \n";
			print MAIL "To: $fm\n";
			print MAIL "Subject: $DATA{'name'}\n\n";
			print MAIL "You have a new book entry!!\n\n";
			print MAIL "From: $DATA{'name'}\n";
			print MAIL "Mail: $DATA{'email'}\n";
			print MAIL "Site: $DATA{'www'}\n";
			print MAIL "URL : $DATA{'url'}\n\n";
			print MAIL "MSG : $DATA{'msg'}\n\n";
			print MAIL "Guest Info:\n";
			print MAIL "-------------------------------------\n";
			print MAIL "Server protocol  : $ENV{'SERVER_PROTOCOL'}\n";
			print MAIL "Remote host      : $ENV{'REMOTE_HOST'}\n";
			print MAIL "Remote IP address: $ENV{'REMOTE_ADDR'}\n";
			print MAIL "User agent       : $ENV{'HTTP_USER_AGENT'}\n";
			close (MAIL);
		}

	

sub form_data {

    if ($ENV{'REQUEST_METHOD'} eq 'GET') {
        # Split the name-value pairs
        @pairs = split(/&/, $ENV{'QUERY_STRING'});
    }
    elsif ($ENV{'REQUEST_METHOD'} eq 'POST') {
        # Get the input
        read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
 
        # Split the name-value pairs
        @pairs = split(/&/, $buffer);
    }
    else {
print "Content-type: text/html\n\n";
print "add=nope&\n";


    }

  foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);

      $name =~ tr/+/ /;
      $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

      $value =~ tr/+/ /;
      $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
      $value =~ s/<!--(.|\n)*-->//g;
      $DATA{$name} = $value;

  }
} 


