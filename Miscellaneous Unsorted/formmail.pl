#!/usr/bin/perl
##############################################################################
# FormMail			Version 1.5				     #
# Copyright 1996 Matt Wright	mattw@worldwidemart.com			     #
# Created 6/9/95                Last Modified 2/5/96			     #
# Scripts Archive at:		http://www.worldwidemart.com/scripts/	     #
##############################################################################
# COPYRIGHT NOTICE                                                           #
# Copyright 1996 Matthew M. Wright  All Rights Reserved.                     #
#                                                                            #
# FormMail may be used and modified free of charge by anyone so long as this #
# copyright notice and the comments above remain intact.  By using this      #
# code you agree to indemnify Matthew M. Wright from any liability that      #  
# might arise from it's use.                                                 #  
#									     #
# Selling the code for this program without prior written consent is         #
# expressly forbidden.  In other words, please ask first before you try and  #
# make money off of my program.						     #
#                                                                            #
# Obtain permission before redistributing this software over the Internet or #
# in any other medium.	In all cases copyright and header must remain intact #
##############################################################################
# Define Variables 
#	 Detailed Information Found In README File.

# $mailprog defines the location of the sendmail program on your system.
$mailprog = '/usr/sbin/sendmail';

# @referers allows forms to be located only on servers which are defined 
# in this field.  This fixes a security hole in the last version which 
# allowed anyone on any server to use your FormMail script.

@referers = ('www.oplossen.nl','worldwidemart.com','213.46.145.135');
#@referers = ('macros','milamber');

# SERVER_OS defines the server Operating System if other that UNIX

# $SERVER_OS="WIN";

# WIN_TEMPFILE is needed to store the mail as it's built.
# this is only required if SERVER_OS is set to "WIN"

# $WIN_TEMPFILE="c:/windows/temp/formmail.$$";

# Done
#############################################################################

# Check Referring URL
&check_url;

# Retrieve Date
&get_date;

# Parse Form Contents
&parse_form;

# Check Required Fields
&check_required;

# Return HTML Page or Redirect User
&return_html;

# Send E-Mail
&send_mail;

sub check_url {

   if ($ENV{'HTTP_REFERER'}) {
      foreach $referer (@referers) {
         if ($ENV{'HTTP_REFERER'} =~ /$referer/i) {
            $check_referer = '1';
	    last;
         }
      }
   }
   else {
      $check_referer = '1';
   }

   if ($check_referer != 1) {
      &error('bad_referer');
   }

}

sub get_date {

   @days = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
   @months = ('January','February','March','April','May','June','July',
	      'August','September','October','November','December');

   ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
   if ($hour < 10) { $hour = "0$hour"; }
   if ($min < 10) { $min = "0$min"; }
   if ($sec < 10) { $sec = "0$sec"; }

   $date = "$days[$wday], $months[$mon] $mday, 19$year at $hour\:$min\:$sec";

}

sub parse_form {

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
      &error('request_method');
   }

   foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);
 
      $name =~ tr/+/ /;
      $name =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

      $value =~ tr/+/ /;
      $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;

      # If they try to include server side includes, erase them, so they
      # arent a security risk if the html gets returned.  Another 
      # security hole plugged up.

      $value =~ s/<!--(.|\n)*-->//g;

      # Create two associative arrays here.  One is a configuration array
      # which includes all fields that this form recognizes.  The other
      # is for fields which the form does not recognize and will report 
      # back to the user in the html return page and the e-mail message.
      # Also determine required fields.

      if ($name eq 'recipient' ||
	  $name eq 'subject' ||
	  $name eq 'email' ||
	  $name eq 'realname' ||
	  $name eq 'redirect' ||
	  $name eq 'bgcolor' ||
	  $name eq 'background' ||
	  $name eq 'link_color' ||
	  $name eq 'vlink_color' ||
          $name eq 'text_color' ||
   	  $name eq 'alink_color' ||
	  $name eq 'title' ||
	  $name eq 'sort' ||
	  $name eq 'print_config' ||
	  $name eq 'return_link_title' ||
	  $name eq 'return_link_url' && ($value)) {
         
	 $CONFIG{$name} = $value;
      }
      elsif ($name eq 'required') {
         @required = split(/,/,$value);
      }
      elsif ($name eq 'env_report') {
         @env_report = split(/,/,$value);
      }
      else {
         if ($FORM{$name} && ($value)) {
	    $FORM{$name} = "$FORM{$name}, $value";
	 }
         elsif ($value) {
            $FORM{$name} = $value;
         }
      }
   }
}

sub check_required {

   foreach $require (@required) {
      if ($require eq 'recipient' ||
          $require eq 'subject' ||
          $require eq 'email' ||
          $require eq 'realname' ||
          $require eq 'redirect' ||
          $require eq 'bgcolor' ||
          $require eq 'background' ||
          $require eq 'link_color' ||
          $require eq 'vlink_color' ||
          $require eq 'alink_color' ||
          $require eq 'text_color' ||
	  $require eq 'sort' ||
          $require eq 'title' ||
          $require eq 'print_config' ||
          $require eq 'return_link_title' ||
          $require eq 'return_link_url') {

         if (!($CONFIG{$require}) || $CONFIG{$require} eq ' ') {
            push(@ERROR,$require);
         }
      }
      elsif (!($FORM{$require}) || $FORM{$require} eq ' ') {
         push(@ERROR,$require);
      }
   }

   if (@ERROR) {
      &error('missing_fields', @ERROR);
   }

}

sub return_html {

   if ($CONFIG{'redirect'} =~ /http\:\/\/.*\..*/) {

      # If the redirect option of the form contains a valid url,
      # print the redirectional location header.

      print "Location: $CONFIG{'redirect'}\n\n";
   }
   else {

      print "Content-type: text/html\n\n";
      print "<html>\n <head>\n";

      # Print out title of page
      if ($CONFIG{'title'}) {
	 print "  <title>$CONFIG{'title'}</title>\n";
      }
      else {
         print "  <title>Thank You</title>\n";
      }

      print " </head>\n <body";

      # Get Body Tag Attributes
      &body_attributes;

      # Close Body Tag
      print ">\n  <center>\n";

      if ($CONFIG{'title'}) {
         print "   <h1>$CONFIG{'title'}</h1>\n";
      }
      else {
         print "   <h1>Thank You For Filling Out This Form</h1>\n";
      }
      print "</center>\n";

      print "Below is what you submitted to $CONFIG{'recipient'} on ";
      print "$date<p><hr size=7 width=75\%><p>\n";

      if ($CONFIG{'sort'} eq 'alphabetic') {
         foreach $key (sort keys %FORM) {
            # Print the name and value pairs in FORM array to html.
            print "<b>$key:</b> $FORM{$key}<p>\n";
         }
      }
      elsif ($CONFIG{'sort'} =~ /^order:.*,.*/) {
         $sort_order = $CONFIG{'sort'};
         $sort_order =~ s/order://;
         @sorted_fields = split(/,/, $sort_order);
         foreach $sorted_field (@sorted_fields) {
            # Print the name and value pairs in FORM array to html.
            if ($FORM{$sorted_field}) {
               print "<b>$sorted_field:</b> $FORM{$sorted_field}<p>\n";
 	    }
         }
      }
      else {
         foreach $key (keys %FORM) {
            # Print the name and value pairs in FORM array to html.
            print "<b>$key:</b> $FORM{$key}<p>\n";
         }
      }

      print "<p><hr size=7 width=75%><p>\n";

      # Check for a Return Link
      if ($CONFIG{'return_link_url'} =~ /http\:\/\/.*\..*/ && $CONFIG{'return_link_title'}) {
         print "<ul>\n";
         print "<li><a href=\"$CONFIG{'return_link_url'}\">$CONFIG{'return_link_title'}</a>\n";
         print "</ul>\n";
      }
      print "<a href=\"http://www.worldwidemart.com/scripts/formmail.shtml\">FormMail</a> Created by Matt Wright and can be found at <a href=\"http://www.worldwidemart.com/scripts/\">Matt's Script Archive</a>.\n";
      print "</body>\n</html>";
   }
}


sub send_mail {
   # Open The Mail Program
   if ($SERVER_OS eq "WIN") {
     open(MAIL,">$WIN_TEMPFILE");
     local($BLAT_ARGS);
   } else {
     open(MAIL,"|$mailprog -t");
   }

   # Windows (blat) needs these on the command line, so we'll skip them here
   if ($SERVER_OS ne "WIN") {
     print MAIL "To: $CONFIG{'recipient'}\n";
     print MAIL "From: $CONFIG{'email'} ($CONFIG{'realname'})\n";
   }

   # Check for Message Subject
   if ($CONFIG{'subject'}) {
      print MAIL "Subject: $CONFIG{'subject'}\n\n";
   }
   else {
      print MAIL "Subject: WWW Form Submission\n\n";
   }

   print MAIL "Below is the result of your feedback form.  It was ";
   print MAIL "submitted by $CONFIG{'realname'} ($CONFIG{'email'}) on ";
   print MAIL "$date\n";
   print MAIL "---------------------------------------------------------------------------\n\n";

   if ($CONFIG{'print_config'}) {
      @print_config = split(/,/,$CONFIG{'print_config'});
      foreach $print_config (@print_config) {
         if ($CONFIG{$print_config}) {
            print MAIL "$print_config: $CONFIG{$print_config}\n\n";
         }
      }
   }

   if ($CONFIG{'sort'} eq 'alphabetic') {
      foreach $key (sort keys %FORM) {
         # Print the name and value pairs in FORM array to mail.
         print MAIL "$key: $FORM{$key}\n\n";
      }
   }
   elsif ($CONFIG{'sort'} =~ /^order:.*,.*/) {
      $CONFIG{'sort'} =~ s/order://;
      @sorted_fields = split(/,/, $CONFIG{'sort'});
      foreach $sorted_field (@sorted_fields) {
         # Print the name and value pairs in FORM array to mail.
         if ($FORM{$sorted_field}) {
            print MAIL "$sorted_field: $FORM{$sorted_field}\n\n";
         }
      }
   }
   else {
      foreach $key (keys %FORM) {
         # Print the name and value pairs in FORM array to html.
            print MAIL "$key: $FORM{$key}\n\n";
      }
   }

   print MAIL "---------------------------------------------------------------------------\n";

   # Send Any Environment Variables To Recipient.
   foreach $env_report (@env_report) {
      print MAIL "$env_report: $ENV{$env_report}\n";
   }

   close (MAIL);

   # If we're running under Windows, we actually send mail here...
   if ($SERVER_OS eq "WIN") {
     $WIN_TEMPFILE =~ s/\//\\/g;
     $mailprog =~ s/\//\\/g;
     $BLAT_ARGS = "$WIN_TEMPFILE -t $CONFIG{'recipient'} -penguin ";
     $BLAT_ARGS .= "-f $CONFIG{'email'} " if defined($CONFIG{'email'});
     $BLAT_ARGS .= "-q";
     system "$mailprog $BLAT_ARGS";
     unlink $WIN_TEMPFILE;
   }
}

sub error {

   ($error,@error_fields) = @_;

   print "Content-type: text/html\n\n";

   if ($error eq 'bad_referer') {
      print "<html>\n <head>\n  <title>Bad Referrer - Access Denied</title>\n </head>\n";
      print " <body>\n  <center>\n   <h1>Bad Referrer - Access Denied</h1>\n  </center>\n";
      print "The form that is trying to use this <a href=\"http://www.worldwidemart.com/scripts/\">FormMail Program</a>\n";
      print "resides at: $ENV{'HTTP_REFERER'}, which is not allowed to access this cgi script.<p>\n";
      print "Sorry!\n";
      print "</body></html>\n";
   }

   elsif ($error eq 'request_method') {
      print "<html>\n <head>\n  <title>Error: Request Method</title>\n </head>\n";
      print "</head>\n <body";

      # Get Body Tag Attributes
      &body_attributes;

      # Close Body Tag
      print ">\n <center>\n\n";

      print "   <h1>Error: Request Method</h1>\n  </center>\n\n";
      print "The Request Method of the Form you submitted did not match\n";
      print "either GET or POST.  Please check the form, and make sure the\n";
      print "method= statement is in upper case and matches GET or POST.\n";
      print "<p><hr size=7 width=75%><p>\n";
      print "<ul>\n";
      print "<li><a href=\"$ENV{'HTTP_REFERER'}\">Back to the Submission Form</a>\n";
      print "</ul>\n";
      print "</body></html>\n";
   }

   elsif ($error eq 'missing_fields') {

      print "<html>\n <head>\n  <title>Error: Blank Fields</title>\n </head>\n";
      print " </head>\n <body";
      
      # Get Body Tag Attributes
      &body_attributes;
         
      # Close Body Tag
      print ">\n  <center>\n";

      print "   <h1>Error: Blank Fields</h1>\n\n";
      print "The following fields were left blank in your submission form:<p>\n";

      # Print Out Missing Fields in a List.
      print "<ul>\n";
      foreach $missing_field (@error_fields) {
         print "<li>$missing_field\n";
      }
      print "</ul>\n";

      # Provide Explanation for Error and Offer Link Back to Form.
      print "<p><hr size=7 width=75\%><p>\n";
      print "These fields must be filled out before you can successfully submit\n";
      print "the form.  Please return to the <a href=\"$ENV{'HTTP_REFERER'}\">Fill Out Form</a> and try again.\n";
      print "</body></html>\n";
   }
   exit;
}

sub body_attributes {
   # Check for Background Color
   if ($CONFIG{'bgcolor'}) {
      print " bgcolor=\"$CONFIG{'bgcolor'}\"";
   }

   # Check for Background Image
   if ($CONFIG{'background'} =~ /http\:\/\/.*\..*/) {
      print " background=\"$CONFIG{'background'}\"";
   }

   # Check for Link Color
   if ($CONFIG{'link_color'}) {
      print " link=\"$CONFIG{'link_color'}\"";
   }

   # Check for Visited Link Color
   if ($CONFIG{'vlink_color'}) {   
      print " vlink=\"$CONFIG{'vlink_color'}\"";
   }

   # Check for Active Link Color
   if ($CONFIG{'alink_color'}) {
      print " alink=\"$CONFIG{'alink_color'}\"";
   }

   # Check for Body Text Color
   if ($CONFIG{'text_color'}) {
      print " text=\"$CONFIG{'text_color'}\"";
   }
}
