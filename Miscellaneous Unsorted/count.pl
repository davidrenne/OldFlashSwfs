#!/usr/local/bin/perl
open(NUMBER, "count.txt");
$number = <NUMBER>;
close(NUMBER);

if ($number == 99999) {
	$number = "1";
}
	else {
	$number++;
}

open(NUMBER,">count.txt");
print NUMBER "$number";
close(NUMBER);

print "Content-type: text/html\n\n";
print "count=$number\n";