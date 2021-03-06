package TAC::Controller;

use Mojo::Base 'Mojolicious::Controller';
use Data::Dumper;
use Time::Local;
use POSIX qw(locale_h strftime);
use Try::Tiny;
use HTTP::Status qw(HTTP_NOT_FOUND);

use constant LATEST_REVISION    => 9;
use constant OLDEST_DATE_SERVED => 1183240800; # revision 3, see tac.conf

# This action will render a template
sub default {
    my $self = shift;

    my $terms_and_conditions = $self->config('terms_and_conditions');

    $self->render('controller/default',
        terms_and_conditions => $self->app->config->{terms_and_conditions},
    );
}

sub terms_and_conditions_by_revision {
    my $self = shift;

    my $language = $self->stash('i18n')->{language};
    my $revision_parameter = $self->stash('revision');

    $self->app->log->debug("Called with language: »$language«");
    $self->app->log->debug("Called with revision: »$revision_parameter«");

    my $terms_and_conditions = $self->config('terms_and_conditions');

    my $asset;

    foreach my $agreement (values %{$terms_and_conditions}) {
        if ($revision_parameter == $agreement->{revision}) {
            $asset = $agreement;
        }
    }

    if ($asset->{files}->{$language}) {
        $self->res->headers->content_type('application/pdf');
        return $self->reply->static($asset->{files}->{$language});

    } else {
        $self->app->log->error('Unable to locate specified revision');

        $self->render(
            status => HTTP_NOT_FOUND,
        );
    }
}

sub terms_and_conditions_by_date {
    my $self = shift;

    my $language = $self->stash('i18n')->{language};
    my $date = $self->stash('date') || '';

    $self->app->log->debug("Called with language: »$language«");
    $self->app->log->debug("Called with date: »$date«");

    # We default to today
    if (not $date) {
        $date = strftime "%Y%m%e", localtime;
    }

    my $date_epoch;
    my $terms_and_conditions = $self->config('terms_and_conditions');

    if ($date) {
        $self->app->log->info("Attempting to parse date: $date");

        $date_epoch = $self->_parse_and_convert_date($date);

        if (not $date_epoch) {
            $self->app->log->error("Illegal date provided: $date");

            $self->render('controller/default',
                msg        => "Illegal date provided: $date",
                terms_and_conditions => $terms_and_conditions,
            );
        }
    }

    # We do not service general terms and conditions prior to revision 03 from 20070701
    if ($date_epoch and $date_epoch < OLDEST_DATE_SERVED) {
        $self->app->log->error("Date: $date, is in the past");
        $self->render(
            status => HTTP_NOT_FOUND,
        );

        return;
    }

    my $asset;

    foreach my $revision_start_date ( keys %{$terms_and_conditions}) {
        $self->app->log->debug('Evaluating the revision start date: '. $revision_start_date);
        if ($asset) {
            $self->app->log->debug('We have an asset');
            if ($date_epoch and $revision_start_date > $date_epoch) {
                $self->app->log->debug('Our date parameter is below the revision start date');
                next;
            } elsif ($date_epoch and $revision_start_date < $date_epoch
                     and $asset->{startdate} > $date_epoch ) {

                $self->app->log->debug('Setting asset to start date: '. $revision_start_date);
                $asset = $terms_and_conditions->{$revision_start_date};

            } elsif ($asset->{startdate} > $revision_start_date) {
                $self->app->log->debug('Asset start date higher than revision start date');
                next;
            } else {
                $self->app->log->debug('Setting asset to start date: '. $revision_start_date);
                $asset = $terms_and_conditions->{$revision_start_date};
            }
        } else {
            $self->app->log->debug('Setting asset to start date: '. $revision_start_date);
            $asset = $terms_and_conditions->{$revision_start_date}; # first run
        }
    }

    if ($asset->{files}->{$language}) {
        $self->res->headers->content_type('application/pdf');
        $self->reply->static($asset->{files}->{$language});

    } else {
        $self->app->log->error('Unable to locate revision specified by date');

        $self->render(
            status => HTTP_NOT_FOUND,
        );
    }
 }

sub _parse_and_convert_date {
    my ($self, $date) = @_;

    $self->app->log->info("Received date parameter: $date");

    my ($year, $month, $day) = $date =~ m/
        \A # beginning of string
        (\d{4}) # year eg. 2016
        (\d{2}) # month 01-12
        (\d{2}) # day 01-31
        \z # end of string
    /x;

    $self->app->log->debug("Parsed date parameter to: year: $year month: $month, day: $day");

    # Month has to be decreased by one, since it mimicks the parameters from
    # localtime where month is 0 to 11, so the human readable equivalent provided
    # via the API would possibly be 1 to 12
    # Ref: http://perldoc.perl.org/Time/Local.html
    # Ref: http://perldoc.perl.org/functions/localtime.html
    $month--;

    my $epoch;

    # Time::Local's timelocal dies when unsuccessful
    try {
        # We ignore time
        $epoch = timelocal( 0, 0, 0, $day, $month, $year );

    } catch  {
        $self->app->log->error('Unable to parse and convert the provided date', $_);

        return undef;
    };

    $self->app->log->debug("Converted parsed date to epoch: $epoch");

    return $epoch;
}

1;
