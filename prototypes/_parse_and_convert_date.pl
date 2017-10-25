#!/usr/bin/env perl

use strict;
use warnings;

use Time::Local; # timelocal

my $localtime_epoch = '1185746400';

my $converted_date = _parse_and_convert_date('20070630');

if ($localtime_epoch != $converted_date) {
    print STDERR "WTHelicopter\n";
} else {
    print "WOHOO! ON TIME!\n";
}

exit 0;

sub _parse_and_convert_date {
    my ($date) = @_;

    my ($year, $month, $day) = $date =~ m/\A(\d{4})(\d{2})(\d{2})\z/x;

    my $epoch = timelocal( 0, 0, 0, $day, $month, $year );

    if ($epoch) {
        return $epoch;
    } else {
        die "Unable to parse the provided date";
    }
}