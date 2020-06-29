#!/usr/bin/env perl

use strict;
use warnings;

use Try::Tiny;
use Time::Local; # timelocal

my $localtime_epoch = '1185746401';

my $converted_date = _parse_and_convert_date('20070630');

if ($localtime_epoch != $converted_date) {
    print STDERR "WTHelicopter\n";
} else {
    print "WOHOO! ON TIME!\n";
}

exit 0;

sub _parse_and_convert_date {
    my ($date) = @_;

    my ($year, $month, $day) = $date =~ m/
        \A # beginning of string
        (\d{4}) # year eg. 2016
        (\d{2}) # month 01-12
        (\d{2}) # day 01-31
        \z # end of string
    /x;

    my $epoch;

    # Time::Local's timelocal dies when unsuccessful
    try {
        # We ignore time
        $epoch = timelocal( 0, 0, 0, $day, $month, $year );

    } catch  {
        warn('Unable to parse and convert the provided date', $_);

        return undef;
    };
}
