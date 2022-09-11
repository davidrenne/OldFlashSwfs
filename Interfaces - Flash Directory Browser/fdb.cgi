#!/usr/local/bin/perl
# use CGI qw(:standard);



    # We only support a get request
    if ($ENV{'REQUEST_METHOD'} eq "GET") {
        $buffer = $ENV{QUERY_STRING};
    } else {
        select(STDOUT);
        print STDOUT "Content-Type: text/plain\n\n";
        print STDOUT "Invalid REQUEST METHOD!\n";
        exit(0);
    }

    # Translate the www-url-encoding into something we can use
    # This really shows Perl off... (and it doesn't even suck too
    # badly for speed either).

    @pairs = split(/&/, $buffer);
    
    foreach $pair (@pairs) {
	($name, $value) = split(/=/, $pair);
	
	# Un-Webify plus signs and %-encoding
	$value =~ tr/+/ /;
	$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	
	$value =~ tr/\n/ /;
	$value =~ tr/\r/ /;
	
	$FORM{lc $name} = $value;
    }


# customize the paths for your own server

# where is this program
$mypath = "/cgi/fdb.cgi";
$default_path = "/www/htdocs/domains/domain1/00265/www.cyberrodent.com/webdocs/";
$docroot = "www\/htdocs\/domains\/domain1\/00265\/www\.cyberrodent\.com\/webdocs\/";
@files = "";
@dirs = "";
$outstring = "";

print STDOUT "Content-type: text/html\n\n";
#$p = `pwd`;
#print $p;

$this_path = $FORM{'newpath'};
# $this_path = param("newpath");
if (!$this_path) {
	$this_path = $default_path;
}

# print header();    #  , start_html("directory reader");
#foreach $key (sort keys %ENV) {
#	print "$key=$ENV{$key}<BR>\n";
#}
# NOTE: maybe some way to add some security  by checking ENV keys

chdir{$this_path};

$dcount = 0; # these can be replaced by using the length of the 2 arrays
$fcount = 0;

opendir (THISDIR, "$this_path") || die "no such directory: $this_path";
	
	foreach $name (sort readdir (THISDIR)) {
		$foo = $this_path .  $name;

		
		
		if (-d $foo) {

			if ($name =~ /^[\._]/) {
				#$name = "<h3>this directory:<BR> $this_path</h3>";
				#print "$name\r";
			} else {
				$dcount++;
				$link = urlencode($foo);
				print "&dir" . $dcount . "=" . urlencode($name) . "&dlink" . $dcount . "=" . $link ."/";
				# print "<a href=\"$mypath?newpath=$foo/\">$name</a> <BR>\r";
			}	
		} else {
			# get the filesize
			$fs = ((-s $foo) / 1024);
			if ($fs < 1) { $fs =1.00; }
			$fs = substr($fs, 0,8);
			$fcount++;
			$link = $foo;
			$link =~ s/$docroot//;			
			$link = urlencode($link);
			
			push (files,"&file" . $fcount . "=" . $name . "&flink" . $fcount . "=" . $link);
		}
	
	}
closedir (THISDIR);


print "@files";
print "&path=$this_path";

$parent = $this_path;
$parent =~ /(.*)\/(.*)?\//;
$parent = $1;
print "&parent=$parent/";
print "&doneloading=1&";


sub urlencode {
	my $input_url = $_[0];
	# URL encode
	$input_url =~ s/&/%26/g;
	$input_url =~ s/=/%3D/g;
	$input_url =~ s/\?/%3F/g;
	$input_url =~ s/\ /+/g;
	return $input_url;	
}


