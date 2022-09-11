#!/usr/bin/perl 

#1. setting perl path #####################################################
#chage the above according to your perl script path 
#must be /usr/bin/perl or /usr/local/bin/perl 
#ask your server admin..or type 'whereis perl' on your console window.. 
#-------------------------------------------------------------------------
#펄경로를 서버에 맞추어서 바꾸어야 합니다. 대부분 !/urr/bin/per/이나 
#!/user/local/bin/perl입니다. 텔넷으로 접속하셔서 whereis perl 하심 
#경로를 확인하실 수 있습니다.
###########################################################################

#############################################################################
# the following code is wirtten by choosh at http://tangible.new21.org
# sorry for the ugly coding..but, it's done for the study...don't blame me
# feel free to change or modify it.
#############################################################################

#2.create data file #########################################################
# you should create empty datafile
# if you name it diffrently from "flashmemo.txt", change the following
#############################################################################
$datafile = "flashmemo.txt";			

#3.chage file permission#####################################################
# chmod 766 "flashmemo.txt"
# chmod 755 "flashmemo.cgi"
#############################################################################

#4.set basedir################################################################
#basedir is the absolute path or relative path of the directiory 
#where "flashmemo.txt" is
#if the datafile is located in the same directory of this cgi file. 
#you don't have change the following line
#----------------------------------------------------------------------------
#경우에 따라 절대 경로나 상대경로..로..바꾸어주어야 합니다.
#cgi파일과 datafile이 같은 위치에 있으면, 아래는 수정하실 필요가 업슷ㅂ니다.
#############################################################################
$basedir=".";			
						

#5. no change required #######################################################
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
	   if ($FORM{'mode'} eq 'read' ) {
         &get_message;
		  		   }
	  if ($FORM{'mode'} eq 'write' ) {
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
	 print "&write=success1";
     open (MESSAGES,"<$basedir/$datafile") || die $!;
	 @text = <MESSAGES>;
	  close (MESSAGES);
	  print "&write=success";
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
