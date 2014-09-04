package Twilt::Perl;
use Dancer ':syntax';
use Dancer::Plugin::Auth::Twitter;

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

auth_twitter_init();

before sub {
    return if request->path =~ m{/auth/twitter/callback};

    if (not session('twitter_user')) {
        redirect auth_twitter_authorize_url();
    }
};

get '/' => sub {
  template 'landing.tt';
};

true;
