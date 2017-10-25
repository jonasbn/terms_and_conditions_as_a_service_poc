use Mojo::Base -strict;

use Test::More;
use Test::Mojo;
use Env qw($MOJO_MODE);
use HTTP::Status qw(HTTP_OK HTTP_NOT_FOUND);

my $url = '';
my $host = '';

my $t = Test::Mojo->new('TAC');

# We default to danish
$url = $host.'/';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/English/i, 'We default to danish');

# When asking for english, want to be able to switch to danish
$url = $host.'/en';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/Dansk/i, 'When asking for english, want to be able to switch to danish');

# When asking for danish, want to be able to switch to english
$url = $host.'/da';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/English/i, 'When asking for danish, want to be able to switch to english');

# We choose the default when requesting bad language parameter
$url = $host.'/badlanguage';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/English/i, 'When asking for unsupported language, we go to the default (da)');

# We choose the default when requesting an unsupported language
$url = $host.'/ru';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/English/i, 'When asking for unsupported language, we go to the default (da)');

# When not specifying a date want the current english revision
$url = $host.'/en/terms_and_conditions';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When not specifying a date want the current revision');

# When not specifying a date want the current danish revision
$url = $host.'/da/terms_and_conditions';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When not specifying a date want the current revision');

# Future revision 8 english
$url = $host.'/en/terms_and_conditions/20601025';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/9/i, 'When specifying a date in the future we might get a revision from the future');

# Future revision 8 danish
$url = $host.'/da/terms_and_conditions/20601025';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/9/i, 'When specifying a date in the future we might get a revision from the future');

# Revision 8 english
$url = $host.'/en/terms_and_conditions/20160828';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When specifying a date we want the relevant revision: 08');

# Revision 8 danish
$url = $host.'/da/terms_and_conditions/20160828';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When specifying a date we want the relevant revision: 08');

# Revision 7 english
$url = $host.'/en/terms_and_conditions/20150302';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/7/i, 'When specifying a date we want the relevant revision: 07');

# Revision 7 danish
$url = $host.'/da/terms_and_conditions/20150302';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/7/i, 'When specifying a date we want the relevant revision: 07');

# Revision 6 english
$url = $host.'/en/terms_and_conditions/20130102';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/6/i, 'When specifying a date we want the relevant revision: 06');

# Revision 6 danish
$url = $host.'/da/terms_and_conditions/20130102';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/6/i, 'When specifying a date we want the relevant revision: 06');

# Revision 5 english
$url = $host.'/en/terms_and_conditions/20100702';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/5/i, 'When specifying a date we want the relevant revision: 05');

# Revision 5 danish
$url = $host.'/da/terms_and_conditions/20100702';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/5/i, 'When specifying a date we want the relevant revision: 05');

# Revision 4 english
$url = $host.'/en/terms_and_conditions/20080302';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/4/i, 'When specifying a date we want the relevant revision: 04');

# Revision 4 danish
$url = $host.'/da/terms_and_conditions/20080302';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/4/i, 'When specifying a date we want the relevant revision: 04');

# Revision 3 english
$url = $host.'/en/terms_and_conditions/20070702';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/3/i, 'When specifying a date we want the relevant revision: 03');

# Revision 3 danish
$url = $host.'/da/terms_and_conditions/20070702';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/3/i, 'When specifying a date we want the relevant revision: 03');

# Non-supported revision by date english
$url = $host.'/en/terms_and_conditions/20000101';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a date before the last recorded revision, we error');

# Non-supported revision by date danish
$url = $host.'/da/terms_and_conditions/20000101';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a date before the last recorded revision, we error');

# Malformed date english
$url = $host.'/en/terms_and_conditions/abe';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a malformed date, we error');

# Malformed date danish
$url = $host.'/da/terms_and_conditions/abe';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a malformed date, we error');

# Illegal date english
$url = $host.'/en/terms_and_conditions/20160231';
$t->get_ok($url)->status_is(HTTP_OK); #->content_like(qr/Illegal/i, 'When specifying an illegal date, we error');

# Illegal date danish
$url = $host.'/en/terms_and_conditions/20160231';
$t->get_ok($url)->status_is(HTTP_OK); #->content_like(qr/Illegal/i, 'When specifying an illegal date, we error');

# Revision 8 english
$url = $host.'/en/terms_and_conditions/revision/8';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When specifying a revision we want the relevant revision: 08');

# Revision 8 danish
$url = $host.'/da/terms_and_conditions/revision/8';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/8/i, 'When specifying a revision we want the relevant revision: 08');

# Revision 7 english
$url = $host.'/en/terms_and_conditions/revision/7';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/7/i, 'When specifying a revision we want the relevant revision: 07');

# Revision 7 danish
$url = $host.'/da/terms_and_conditions/revision/7';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/7/i, 'When specifying a revision we want the relevant revision: 07');

# Revision 6 english
$url = $host.'/en/terms_and_conditions/revision/6';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/6/i, 'When specifying a revision we want the relevant revision: 06');

# Revision 6 danish
$url = $host.'/da/terms_and_conditions/revision/6';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/6/i, 'When specifying a revision we want the relevant revision: 06');

# Revision 5 english
$url = $host.'/en/terms_and_conditions/revision/5';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/5/i, 'When specifying a revision we want the relevant revision: 05');

# Revision 5 danish
$url = $host.'/da/terms_and_conditions/revision/5';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/5/i, 'When specifying a revision we want the relevant revision: 05');

# Revision 4 english
$url = $host.'/en/terms_and_conditions/revision/4';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/4/i, 'When specifying a revision we want the relevant revision: 04');

# Revision 4 danish
$url = $host.'/da/terms_and_conditions/revision/4';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/4/i, 'When specifying a revision we want the relevant revision: 04');

# Revision 3 english
$url = $host.'/en/terms_and_conditions/revision/3';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/3/i, 'When specifying a revision we want the relevant revision: 03');

# Revision 3 danish
$url = $host.'/da/terms_and_conditions/revision/3';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/3/i, 'When specifying a revision we want the relevant revision: 03');

# Revision 9 english
$url = $host.'/en/terms_and_conditions/revision/9';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/9/i, 'When specifying a future revision we might get a document from the future');

# Revision 9 danish
$url = $host.'/da/terms_and_conditions/revision/9';
$t->get_ok($url)->status_is(HTTP_OK)->content_like(qr/9/i, 'When specifying a future revision we might get a document from the future');


# Non-supported revision english
$url = $host.'/en/terms_and_conditions/revision/2';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a revision before the last recorded revision, we error');

# Non-supported revision danish
$url = $host.'/da/terms_and_conditions/revision/2';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a revision before the last recorded revision, we error');

# Malformed revision english
$url = $host.'/en/terms_and_conditions/revision/abe';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a malformed revision, we error');

# Malformed revision danish
$url = $host.'/da/terms_and_conditions/revision/abe';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When specifying a malformed revision, we error');

# Unspecified revision english
$url = $host.'/en/terms_and_conditions/revision/';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When not specifying a revision, we error');

# Unspecified revision danish
$url = $host.'/da/terms_and_conditions/revision/';
$t->get_ok($url)->status_is(HTTP_NOT_FOUND, 'When not specifying a revision, we error');

done_testing();
