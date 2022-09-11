#!/usr/bin/perl

print "Content-type:text/html\n\n";

$logfile = "counter.txt"; 


if ( open (READ_HITS, "$logfile") )

{

$line = <READ_HITS>;

close READ_HITS;

chop($line) if $line =~ /\n$/;

($temp,$hits) = split(/\=/,$line);

if ( open (WRITE_HITS, ">$logfile") )

{

print WRITE_HITS "hits=",++$hits;

close WRITE_HITS;

}

print "hits=$hits";

} else {$hits = "[Shit Happens]";} 

#This script is modified by JERRY[http://beachhead.hk.st] from www.hkflash.com's
#original flash counter script