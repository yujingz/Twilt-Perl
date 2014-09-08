package Twilt::Perl;
use Net::Twitter;
use Dancer ':syntax';
use Dancer::Plugin::Auth::Twitter;
use Data::Dumper;

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

auth_twitter_init();

before sub {
  return if request->path eq "/" or request->path =~ m{/auth/twitter/callback};

  if (not session('twitter_user')) {
    redirect auth_twitter_authorize_url();
  }
};

get '/' => sub {
  template 'landing.tt'
};

get '/home' => sub {
  template 'home.tt' => {
    name => session('twitter_user')->{"name"}
  };
};

get '/twilt' => sub {
  my $tweet_count = 20;

  if (length(params->{'solo_twitter_username'})) {
    my @results = ();
    my $timeline = twitter->user_timeline({screen_name => params->{'solo_twitter_username'}, include_rts => 1, count => $tweet_count});

    for my $tweet ( @$timeline ) {
      my @item = ();
      if ( $tweet->{retweeted_status} ) {
        @item = ($tweet->{entities}{user_mentions}[0]->{screen_name},
                 $tweet->{retweeted_status}{text},
                 $tweet->{retweeted_status}{created_at});
      } else {
        @item = ($tweet->{user}{screen_name},
                 $tweet->{text},
                 $tweet->{created_at});
      }

      push @results, \@item;
    }

    template 'solo_results.tt' => {
      tweets => \@results,
      name => params->{'solo_twitter_username'}
    };
  } elsif (length(params->{'common_twitter_username_a'}) && length(params->{'common_twitter_username_b'})){
    return "Hello Common";
  } else {
    return 'Nothing';
  }
};

true;
