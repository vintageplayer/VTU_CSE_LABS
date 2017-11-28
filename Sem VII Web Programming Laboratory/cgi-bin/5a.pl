#!/usr/bin/perl

use CGI ':standard';

print "content-type: text/html\n\n";

foreach $key (sort (keys %ENV)) {
	print "$key : $ENV{$key} <br>";
}
