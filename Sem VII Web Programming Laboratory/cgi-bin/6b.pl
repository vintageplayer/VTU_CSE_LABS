#!/usr/bin/perl

use CGI ':standard';

print "content-type: text/html\n\n";
open(file,"< count.dat");
$count = <file>;
$count = $count + 1;
print "Total visits : $count";
close(file);

open(file, "> count.dat");
print file $count;
close(file);
