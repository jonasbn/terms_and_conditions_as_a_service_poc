requires 'Mojolicious';
requires 'Time::Local';
requires 'Try::Tiny';
requires 'Mojolicious::Plugin::Config';
requires 'Mojolicious::Plugin::I18N';
requires 'HTTP::Status';

on test => sub {
    requires 'Test::More';
    requires 'Test::Mojo';
    requires 'File::Find';
    requires 'File::Spec';
};

on 'develop' => sub {
    recommends 'App::Prove::Watch';
};
