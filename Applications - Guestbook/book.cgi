#!/usr/bin/perl

###############################################################
#
#    Created by Matthias Kannengiesser
#    Free to use for your own projects
#    Made in Feb. 1998
#    Modified for Flash in Nov. 1999
#    Posted by http://www.flashkit.com
#
#    This script is a modified training version from the great
#    authors Selena Sol and Matthew M. Wright. Thanx for the
#    inspiration. I saw many other CGI based guestbook, but
#    I think these  modfified functions are good, too !
#
###############################################################

#### Set the Variables ##############################

$basedir="d:/webs/WebSites/flashkit.com/cgi-bin/guest";
$listfile="kitbook.txt";
@referers = ('www.flashkit.com');

#### Referer Check ##################################

&check_url;

sub check_url {
    
    local($check_referer) = 0;    

    if ($ENV{'HTTP_REFERER'}) {
        foreach $referer (@referers) {
            if ($ENV{'HTTP_REFERER'} =~ m|https?://([^/]*)$referer|i) {
                $check_referer = 1;
                last;
            }
        }
    }
    else {
        $check_referer = 1;
    }
    
    if ($check_referer != 1) { print "Error!\n"; }
}

###################################################


if (!$ARGV[0]) {
	if($ENV{'REQUEST_METHOD'} eq 'GET')
	{ $ARGV[0] = $ENV{'QUERY_STRING'};
   	}
	else 
	{ read(STDIN, $ARGV[0], $ENV{'CONTENT_LENGTH'});
	}
}
if ($ARGV[0]) {
	%FORM;
	&get_arg;
		
	if ($FORM{'todo'} eq 'read' ) {
		&read_book;
	}

	if ($FORM{'todo'} eq 'sign' ) {
		&sign_book;
	}
}
else {
	print "no parameters!\n";
}	

#### Initialize Arguments ##################################

sub get_arg {
 @pairs = split(/&/, $ARGV[0]);
 foreach $pair (@pairs) {
      ($name, $value) = split(/=/, $pair);
       $value =~ tr/+/ /;
       $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
       $value =~ s/<!--(.|\n)*-->//g;      
       $FORM{$name} = $value;
  } #foreach
} #end get_arg


#### Read Book ##################################

sub read_book {
open (LISTE,"<$basedir/$listfile") || die $!;
@liste = <LISTE>;
close (LISTE);
$ccount=0;
print "Content-type: text/html\n\n";
	foreach $zeile (@liste){
		#print "coeof=true&";
		print $zeile;
		print "&";
		$ccount++;
	} #foreach
print "&count=$ccount&eof=true";
}

#### Sign Book ##################################

sub sign_book {
$ccount=1;
	&datum;
	open (LISTE,"<$basedir/$listfile") || die $!;
	@liste = <LISTE>;
	close (LISTE);
	foreach $zeile (@liste){ $ccount++; }

	open (BOOK,">>$basedir/$listfile") || die $!;
	print BOOK "aname$ccount=$FORM{'name'}&acomment$ccount=$FORM{'comment'}&aurl$ccount=$FORM{'url'}&adate$ccount=$long_date&aemail$ccount=$FORM{'email'}\n";
	close (BOOK);

	print "Content-type: text/html\n\n";
	print "eof=true";
} #end sign_book

#### Get Date and Time ##################################
#### y2k Fix    ##################################

sub datum {
    @days   = ('Sunday','Monday','Tuesday','Wednesday',
	       'Thursday','Friday','Saturday');
    @months = ('January','February','March','April','May','June','July',
		 'August','September','October','November','December');

    
    ($sec,$min,$hour,$mday,$mon,$year,$wday) = (localtime(time))[0,1,2,3,4,5,6];
    $time = sprintf("%02d.%02d",$hour,$min);
    if ($mday < 10) { $mday = "0$mday"; }
    # $time = sprintf("%02d:%02d:%02d",$hour,$min,$sec);
    $year += 1900;                                              
    $long_date = "$mday\. $months[$mon] $year ($time Clock)";             
    # $long_date = "$days[$wday], $months[$mon] $mday, $year at $time";   
}

exit;




