#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Time::Local;

use POSIX qw (tzset);
use Env qw($TZ);

print STDERR "gmtime: ", Dumper gmtime(time);
print STDERR "\n";
print STDERR "localtime: ", Dumper localtime(time);
print STDERR "\n";

$TZ = 'Europe/Copenhagen';
tzset;

print STDERR "gmtime: ", Dumper gmtime(time);
print STDERR "\n";
print STDERR "localtime: ", Dumper localtime(time);
print STDERR "\n";

print STDERR "time: ", time;
print STDERR "\n";

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) =
                                                localtime(time);

my $localtime = timelocal( $sec, $min, $hour, $mday, $mon, $year );
my $gmtime = timegm( $sec, $min, $hour, $mday, $mon, $year );

print STDERR "gmtime: ", $gmtime, "\n";
print STDERR "localtime: ", $localtime, "\n";
