#!/usr/bin/perl

###########################################
########### MorrisMole.Com ################
####### This script is copyright ##########
###### MorrisMole.Com and may not be ######
### sold on without writen permission.  ###
### It may be used for personal use only ##
######## It may also be edited as ######### 
############### required ################## 
############## Good Luck ##################
###########################################

print "Content-type:text/html\n\n";

# Test for method and collect all the variables
if ($ENV{'REQUEST_METHOD'} eq "GET"){
	$flashData=$ENV{'QUERY_STRING'};
}
elsif ($ENV{'REQUEST_METHOD'} eq "POST"){
	read(STDIN, $flashData, $ENV{'CONTENT_LENGTH'});
	}

# Split string into individual variables
@variables = split(/&/, $flashData);
    foreach $pair (@variables) {
    ($name, $value) = split(/=/, $pair);
    $value =~ tr/+/ /; 
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
    $DATA{$name} = $value;
}

# Define perl variables from flash variables
$newwords = $DATA{'newwords'};

# Rewrite hit counter file
open (wordtxt, ">../editor.txt");
print wordtxt "words=$newwords";
close (wordtxt);

exit;
