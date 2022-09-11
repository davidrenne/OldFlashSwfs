#!/usr/bin/perl

####Most likely you will not have to change the above line. Check with host for path to Perl.

$SENDMAIL = '/usr/sbin/sendmail'; ####Path to sendmail (try this but yours may be different, check with your host)
$to       = 'you@yourdomain.com'; ####Target email address for orders
$subject  = 'MERCHANT ORDER';     ####E-MAIL subject

print "Content-type: text/html\n\n";
&get_date;
%FORM;
&get_arg;
&send_email;
print "&error=sent the email successfully";
exit();

sub get_date 
{
   	@days = ('Sun','Mon','Tue','Wed','Thu','Fri','Sat');
   	@months = ('Janurary','February','March','April','May','June','July','August','September','October','November','December');
   	($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
   	if ($hour < 10) { $hour = "0$hour"; }
   	if ($min < 10) 	{ $min = "0$min"; }
   	if ($sec < 10) 	{ $sec = "0$sec"; }
   	if ($year < 10)	{ $year = "0$year"; }
 	if ($year < 90)	{ $cent = "20"; }
	else { $cent = "19"; }
   	$date = "$days[$wday], $months[$mon] $mday, $cent$year at $hour\:$min\:$sec";
}

sub get_arg{
	if ($ENV{'REQUEST_METHOD'} eq 'POST') {
      		read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
      		@pairs = split(/&/, $buffer);
   	}else {
      	print "error=wrong method";
		exit;
   	}
	foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		$name =~ tr/+/ /;
		$name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ tr/+/ /;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ s/<!--(.|\n)*-->//g;
		$FORM{$name} = $value;
	}
}


############### Order format below ... You may want to customize.

sub send_email{
	$from_name=($FORM{'name'} . " <" . $FORM{'email'} . "> ");
	open(MAIL,"|$SENDMAIL -t") || die "error=Can't open $mailprog!\n";
	print MAIL "To: $to\r\n";
   	print MAIL "From: $from_name\r\n";
	print MAIL "Reply-To: $from_name\r\n";
	print MAIL "Subject: $subject\r\n\n";  
	print MAIL "---------------------------------------------------------------\n\n";
	print MAIL "   ORDER SUBMITTED BY: \n";
	print MAIL "   $FORM{'name'} on $date\n\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "MERCHANDISE ORDER\n";
	print MAIL "---------------------------------------------------------------\n\n";
	print MAIL " $FORM{'comments'}\n\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "CARD INFORMATION\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "TYPE : $FORM{'cardtype'}\n";
	print MAIL "NAME ON CARD : $FORM{'cardname'}\n";
	print MAIL "CARD NUMBER : $FORM{'cardnum'}\n";
	print MAIL "CARD EXPIRATION : $FORM{'cardexp'}\n\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "BILLING INFO\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "FIRST NAME : $FORM{'bfirstname'}\n";
	print MAIL "LAST NAME : $FORM{'blastname'}\n";
	print MAIL "EMAIL : $FORM{'bemail'}\n";
	print MAIL "ADDRESS : $FORM{'baddress'}\n";
	print MAIL "CITY : $FORM{'bcity'}\n";
	print MAIL "STATE : $FORM{'bstate'}\n";
	print MAIL "ZIP : $FORM{'bzip'}\n";
	print MAIL "PHONE : $FORM{'bphone'}\n";
	print MAIL "COMMENTS : $FORM{'bcomments'}\n\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "SHIPPING INFO\n";
	print MAIL "---------------------------------------------------------------\n";
	print MAIL "NAME : $FORM{'sname'}\n";
	print MAIL "ADDRESS : $FORM{'saddress'}\n";
	print MAIL "CITY : $FORM{'scity'}\n";
	print MAIL "STATE : $FORM{'sstate'}\n";
	print MAIL "ZIP : $FORM{'szip'}\n\n";
	print MAIL "---------------------------------------------------------------\n\n";
	print MAIL "<REMOTE HOST>     $ENV{'REMOTE_HOST'}\n";
	print MAIL "<REMOTE ADDRESS>  $ENV{'REMOTE_ADDR'}\n";
	print MAIL "<USER AGENT>      $ENV{'HTTP_USER_AGENT'}\r\n";
	close(MAIL);
}