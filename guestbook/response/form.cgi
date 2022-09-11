#!/usr/bin/perl
##############################################################################
# Willem's Form Mailer with autoresponse Version 1.0                         # 
# Copyright 1999 Flashproductions                                            #
# Created 8/7/99                                                             #
# Available at http://www.flashproductions.nl                                #
##############################################################################
# COPYRIGHT NOTICE                                                           #
# Copyright 1999 Flashroductions All Rights Reserved.                        #
#                                                                            #
# This script can be used\modified free of charge.                           #
#                                                                            #
# If you really need to remove this part, go to                              #
# http://www.Flashproductions.nl .  By using this script                     #
# you agree to indemnifyme from any liability that might arise from its use. #
# In simple English, if this script somehow makes your computer run amuck    #
# and kill the pope, it's not my fault.                                      #
#                                                                            #
# This script can redder used for Flashforms and plain Html forms.           #
#                                                                            #
# In Flash use the Load variable to go to the cgi url.                       #
# Also don't forget to load the variable response.txt,                       #
#                                                                            #
# In plain HTML the script writes html documents if you send the form.       #
##############################################################################

# Enter the location of sendmail.  
$mailprogram = "/bin/sendmail -t";

# Enter the fields that are required.  They should each be in quotes and
# separated by a comma.  If no fields are required, change the next line
# to @required = ();
@required = ('email','subject');

# Enter your e-mail address.  Be sure to put a \ in front of the @.
# (user@domain.com becomes user\@domain.com)
$youremail = "you\@yoursite.com";

##############################################################################
# Congratulations!  You've finished defining the variables.  If you want to, #
# you can continue screwing with the script, but it isn't necessary.         #
##############################################################################

# Put the posted data into variables

read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
@pairs = split(/&/, $buffer);
foreach $pair (@pairs) {
        ($name, $value) = split(/=/, $pair);
        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        $FORM{$name} = $value;
}

# Check for all required fields

foreach $check(@required) {
        unless ($FORM{$check}) {
                print "Content-type: text/html\n\n";
                print "<html><head><title>Wrong input</title></head>\n";
                print "<body><h1>Wrong input</h1><br>\n";
                print "Sorry you forgot\n";
                print "to fill in the $check field!\n";
                print "Go back and try again\n";
                print "</body></html>\n";
                exit;
        }
}

# Check the senders email

if ($FORM{'email'}) {
        unless ($FORM{'email'} =~ /\w+@\w+.\w+/) {
                print "Content-type: text/html\n\n";
                print "<html><head><title>Wrong e-mail adress</title></head>\n";
                print "<body><h1>Wrong e-mail adress</h1><br>The e-mail adress is\n";
                print "not, $FORM{'email'}, valid.  Go back to the  form\n";
                print "and try again\n";
                exit;
        }
}

open (MAIL,"|$mailprogram");
print MAIL "To: $youremail\n";
print MAIL "From: $FORM{'email'}\n";
print MAIL "Subject: $FORM{'subject'}\n";
print MAIL "Following is the information submitted by a visitor\n";
foreach $pair (@pairs) {
        ($name, $value) = split(/=/, $pair);
        $value =~ tr/+/ /;
        $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
        unless ($name eq "response" || $name eq "email" || $name eq "subject") { 
                print MAIL "$name: $value\n";
        }
}
close MAIL;

if ($FORM{'response'} && $FORM{'email'}) {
        open (RESPONSE, $FORM{'response'});
        @response = <RESPONSE>;
        close(RESPONSE);
        open (MAIL,"|$mailprogram");
        print MAIL "To: $FORM{'email'}\n";
        print MAIL "From: $youremail\n";
        print MAIL "Subject: $FORM{'subject'} -- Autoresponse\n";
        foreach $line (@response) {
                print MAIL "$line";
        }
        print MAIL "\n";
        print MAIL "\n";
        print MAIL "\n";
        print MAIL "\n";
        close MAIL;
}

print "Content-type: text/html\n\n";
print "<html><head><title>Dank u wel!</title></head>\n";
print "<body><h1>thanks!</h1><br>\n";
print"<body><h3> thanks</h3><br>\n";
if ($FORM{'response'} && $FORM{'email'}) {
        print "this form has sent a autoreply to your emailadress<p>\n";
}
print "Have a nice day.\n";

