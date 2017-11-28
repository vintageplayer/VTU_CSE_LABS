#!/usr/bin/perl

use CGI ':standard';

@arr = ("Goodmorning! Have a nice day.","How are you doing?","Hope you are doing good.","Welcome to PESIT South campus.");

print "content-type: text/html\n\n";

$uname = param('uname');

print "<h1> Hi $uname!!</h1>";
print "<h2>$arr[rand @arr]</h2>";

