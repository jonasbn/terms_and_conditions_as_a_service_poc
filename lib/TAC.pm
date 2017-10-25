package TAC;

use Mojo::Base 'Mojolicious';
use POSIX qw(tzset);

our $VERSION = '0.0.1';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Setting proper timezone , please refer to the documentation
    # We interpret our start dates for given revision of the
    # general terms and conditions based on local time in Copenhagen
    $ENV{TZ} = 'Europe/Copenhagen';
    tzset;

    # Configuration
    my $config = $self->plugin('Config') // {};

    # Localization
    $self->plugin(
        'Mojolicious::Plugin::I18N' => {
            namespace         => 'TAC::I18N',
            support_url_langs => [qw(da en)],
            default           => 'da'
        }
    );

    # Router
    my $r = $self->routes;

    # Route to current terms and conditions, defaulting to danish
    $r->get('/terms_and_conditions')
        ->to('controller#terms_and_conditions_by_date');

    # Route to current terms and conditions, with language label
    $r->get('/:language/terms_and_conditions')
        ->to('controller#terms_and_conditions_by_date');

    # Route to terms and conditions by date, defaulting to danish
    $r->get( '/terms_and_conditions/:date' => [ date => qr/\d{8}/ ] )
        ->to('controller#terms_and_conditions_by_date');

    # Route to terms and conditions by date, with language label
    $r->get(
        '/:language/terms_and_conditions/:date' => [ date => qr/\d{8}/ ] )
        ->to('controller#terms_and_conditions_by_date');

    # Route to terms and conditions by revision, defaulting to danish
    $r->get(
        '/terms_and_conditions/revision/:revision' => [ revision => qr/\d+/ ]
    )->to('controller#terms_and_conditions_by_revision');

    # Route to terms and conditions by revision, with language label
    $r->get( '/:language/terms_and_conditions/revision/:revision' =>
            [ revision => qr/\d+/ ] )
        ->to('controller#terms_and_conditions_by_revision');

        # Default route to controller, defaulting to danish
        $r->get('/')->to('controller#default');

        # Default route with language label
        $r->get('/:language')->to('controller#default');

}

1;
