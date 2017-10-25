#!/usr/bin/env perl

use strict;
use warnings;
use POSIX qw(strftime);

#print (localtime(time))[5];

#print strftime "%a %b %e %H:%M:%S %Y", localtime;

print strftime "%Y%m%e", localtime;

exit 0;
