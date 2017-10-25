requires 'Mojolicious';
requires 'Time::Local';
requires 'TryCatch';
requires 'Mojolicious::Plugin::Config';
requires 'Mojolicious::Plugin::I18N';
requires 'HTTP::Status';
requires 'App::Prove::Watch';

on test => sub {
    requires 'Test::More';
    requires 'Test::Mojo';
    requires 'File::Find';
    requires 'File::Spec';
};
