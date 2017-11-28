#!/usr/bin/perl

use CGI ':standard';

print "Refresh: 1\n";
print "content-type: text/html\n\n";

($s,$m,$h) = localtime(time);

print "Current System Time is $h:$m:$s";
