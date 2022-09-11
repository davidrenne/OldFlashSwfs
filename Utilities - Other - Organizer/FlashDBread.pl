#!/usr/bin/perl
#
# FlashDB v1.4  -  Database front/end for Flash 4.
#
# See instructions at: http://www.kessels.com/FlashDB
#
# (C) 1999 J.C. Kessels
# http://www.kessels.com/
# jeroen@kessels.com



#################################################################################
# Configuration section.

# Database-directory
# Change this into your database-directory, the directory on the harddisk of your
# webserver that will hold the data. It must be an absolute path, do not use
# constructions like ".." or "$USER", and do not enter an URL. The directory
# should be outside the document-tree of your webserver, and have proper
# read/write permissions so that FlashDB can read/write files in it.
# This setting must be exactly the same in both the FlashDB scripts.
# Windows-NT users: use forward-slashes "/", not back-slashes "\".
$Database = '/home/sites/www.oplossen.nl/cgi-bin/agenda/';

# End of configuration.
#################################################################################

# Initialize.
use Config;
$Filename = 'record2';                  # There is no default filename.

# Send the standard HTTP header. Make sure output is not cached in the
# user's browser.
print "Content-type: text/html\n";
print "Expires: Thu, 01 Dec 1994 16:00:00 GMT\n";
print "Cache-Control: no-cache, must-revalidate\n";
print "Pragma: no-cache\n";
print "\n";

# Get the Filename from the parameters. Special characters in the filename such
# as '/' and '\' are translated into spaces, and '..' is removed altogether, as
# security against hackers.
if ($ENV{'REQUEST_METHOD'} eq 'POST') {
    binmode(STDIN);
    read(STDIN,$in,$ENV{'CONTENT_LENGTH'});
  } else {
    $in = $ENV{'QUERY_STRING'};
    }
@args = split(/[&;]/,$in);
foreach $i (0 .. $#args) {
  $args[$i] =~ s/\+/ /g;
  ($key, $val) = split(/=/,$args[$i],2);
  $key =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;
  $val =~ s/%([A-Fa-f0-9]{2})/pack("c",hex($1))/ge;
  $val =~ s/[^a-zA-Z0-9]//g;
  if (($key eq 'filename') && ($val ne '')) {
    if ($val =~ /^([\w]+)$/) { $Filename = $1; }
    }
  }
if ($Filename eq '') {
  print "state=no_filename_specified";
  exit 0;
  }

# Open and lock the file. If the file could not be opened then exit.
$fn = $Filename . ".txt";
if (!open(FILE,"<$fn")) {
  print "state=cannot_open_file";
  exit 0;
  }
# if ($Config{'d_flock'} eq "define") { flock(FILE,2); }
binmode(FILE);

# Print the contents of the file to Flash 4.
print "state=done&";
print <FILE>;

# Close and unlock the file on disk.
if ($Config{'d_flock'} eq "define") { flock(FILE,8); }
close(FILE);
