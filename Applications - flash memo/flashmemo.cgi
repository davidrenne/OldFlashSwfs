#!C:/perl/bin/perl
#!/usr/bin/perl 
#chage the above according to your perl script path
#must beb/usr/bin/perl or /usr/local/bin/perl 
#ask your server admin..or type 'whereis perl' on your console window.. 

#############################################################################
# the following code is wirtten by choosh at http://tangible.new21.org
# sorry for the ugly coding..but, it's done for the study...don't blame me
# feel free to change or modify it.
#############################################################################

########### setup the varialbes #############################################
# if your servers allow you to execute perl script anywhere, you don't 
# have to change these, just change the folder permission where 
# the flash file is placed to 777 or whatever that allow users to write data
#############################################################################

# you should create empty datafile named the below you set
$datafile = "flashmemo.txt";			#file to write data
$basedir=".";							#path for datafile

############ no change required if you aren't going to change or add certain features
print "Content-type: text/plain\n\n";
if (!$ARGV[0]) {
     if($ENV{'REQUEST_METHOD'} eq 'GET') {
          $ARGV[0] = $ENV{'QUERY_STRING'};
     } else {
          read(STDIN, $ARGV[0], $ENV{'CONTENT_LENGTH'});
     }
}

if ($ARGV[0]) {
     %FORM;
     &get_arg;
	   if ($FORM{'todo'} eq 'read' ) {
         &get_message;
		  		   }
	  if ($FORM{'todo'} eq 'write' ) {
         &post_message;
	     &get_message;
	   }
		  print "&eof=true";
} else {
     print "&error=noparameter"; #I didn't implement anything for this ,Dont' worry about that.
}	

#read message
sub get_message {
     open (MESSAGES,"<$basedir/$datafile") || die $!;          #full path..or relative path of the datafile
	 @text = <MESSAGES>;
	  close (MESSAGES);
	  $message_num=0;
	  foreach $pair (@text) {
							 ($linecount,$date,$name,$message)=split(/\|\|/,$pair);
							  chop($message);
					          print "&date$linecount=$date";
							  print "&name$linecount=$name";
							  print "&message$linecount=$message";
					          $line =~ s/ /+/g;
					          $line =~ s/%/%25/g;
					          $line =~ s/&/%26/g;
					          $message_num++;
							  }
		print "&total=$message_num";  #send variable total to flash movie.
  }

#write new message
  sub post_message {
     open (MESSAGES,"<$basedir/$datafile") || die $!;
	 @text = <MESSAGES>;
	  close (MESSAGES);
	  $linecount=0;
	  foreach $pair (@text) {
         $linecount++;
     }
     open (MESSAGES,">>$basedir/$datafile") || die $!;
     &getDate;
	 print MESSAGES "$linecount||$write_date||$FORM{'name'}||$FORM{'message'}\n";
     close (MESSAGES);
    }

#Parse data
sub get_arg {
     @pairs = split(/&/, $ARGV[0]);
     foreach $pair (@pairs) {
          ($name, $value) = split(/=/, $pair);
          $value =~ tr/+/ /;
          $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
          $value =~ s/<!--(.|\n)*-->//g;      
          $FORM{$name} = $value;
     }
}
#get Date
sub getDate {     
    @week = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $word_0="";
	if($min < 10) {
        $min = "0$min";
    }
    if($hour < 10) {
        $hour = "0$hour";
    }
    $mon++;
    if($mon < 10) {
        $mon = "0$mon";
    }
    if($mday < 10) {
        $mday = "0$mday";
    }
    $write_date = "$mon/$mday($week[$wday]) $hour:$min";
}  
