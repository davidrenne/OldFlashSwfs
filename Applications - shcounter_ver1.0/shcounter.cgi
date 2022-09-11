#!/usr/bin/perl 
# change the above line according to your perl script location on your web server

##########################################################################################
# Seungho Choo http://tangible.new21.org (don't remove this line if it doesn't matter)
# GNU public license 
##########################################################################################

# setting ################################################################################

$log_file = "f:/localhost/flash-bin/counter/shcounter.log";        #the absolute path of log_file (chmod 766)
$log_file_cookie       = 'shfcount';              #name unique one
$expire_cookie        = 90;                
$use_lock			  = 1;                    #(1 if use file lock else  0)

# no need to change below this line###########################################################
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
	 if ($FORM{'loaded'} eq 'true') {
	    &read_only; #the count will not be changed if once loaded in flash movie. 
	 }
}else{ 
		&read_write; #add count number and send the count data to flash movie.
		
}
exit(0);

sub read_only() {
	open(FILE, "<$log_file"); 
	$hit = <FILE>;
    ($hit_total,$hit_yesterday,$hit_today,$lastday) = split(/:/, $hit);
	close(FILE);
	print "Content-type: text/plain\n\n";
	print "&total=$hit_total&yesterday=$hit_yesterday&today=$hit_today";
	print "&eof=true&";
}

sub read_write(){
	open(FILE, "+<$log_file"); 
	if ($use_lock) {flock(FILE, 2);}
	seek(FILE, 0, 0);
	$hit = <FILE>;
	($hit_total,$hit_today,$hit_yesterday,$lastday) = split(/:/, $hit);
	$hit_total++;
	$hit_today++;
	$hit_you = &get_cookie + 1;

	#####The year, month, day of yesterday and today;
	($sec, $min, $hour, $day, $mon, $year)      = localtime(time);
	$mon++;
	$year += 1900;
	$today = "$year-$mon-$day\n";
	
	($sec, $min, $hour, $day, $mon, $year) = localtime(time-24*60*60);
	$mon++;
	$year += 1900;
	$yesterday = "$year-$mon-$day\n";

	##### check if the date has changed ( yesterday and today)
	# following lines will be executed at the first access on the day 
	if ($today ne $lastday) {
		 if ($yesterday ne $lastday) {
			 $hit_yesterday = 0; #for the first day of counting
		 } else {
			 $hit_yesterday = $hit_today; 
		 }
		 $hit_today = 1;
		 $lastday = $today;
	}
    seek(FILE, 0, 0);
	print FILE "$hit_total:$hit_today:$hit_yesterday:$lastday\n";
	if ($use_lock) { flock(FILE, 8);}
	close(FILE);

	#####print HTTP header
	print "Content-type: text/plain\n";
    &format_cookiedate;
	print "Set-Cookie: $log_file_cookie=$hit_you; expires=$cookiedate; \n";
	print "\n";
	#####print count data
	print "&total=$hit_total&today=$hit_today&yesterday=$hit_yesterday&you=$hit_you"; # send data
	print "&eof=true&"; #the end of data
	
}

#formate cookie date
sub format_cookiedate {
	($sec, $min, $hour, $day, $mon, $year, $dow )	= localtime(time + $expire_cookie*60*60*24);
	(@month) = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
	(@week) = qw(Sun Mon Tue Wed Thu Fri Sat);
	$cookiedate = sprintf("%s, %d-%s-%04d %02d:%02d:%02d GMT", $week[$dow],$day,$month[$mon+1],$year+1900,$hour,$min,$sec);
}

# get cookie
sub get_cookie {
	@pairs = split(/; /, $ENV{'HTTP_COOKIE'});
	foreach $pair (@pairs) {
		($key, $value) = split(/=/, $pair);
		if ($key eq $log_file_cookie) {
			return $value;
		}
	}
	return '';
}

#parse argument
sub get_arg {
     @pairs = split(/&/, $ARGV[0]);
     foreach $pair (@pairs) {
          ($key, $value) = split(/=/, $pair);
          $value =~ tr/+/ /;
          $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
          $value =~ s/<!--(.|\n)*-->//g;      
          $FORM{$key} = $value;
     }
}


