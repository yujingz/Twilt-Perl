use strict;
use warnings;
use ExtUtils::MakeMaker;

# Normalize version strings like 6.30_02 to 6.3002,
# so that we can do numerical comparisons on it.
my $eumm_version = $ExtUtils::MakeMaker::VERSION;
$eumm_version =~ s/_//;

WriteMakefile(
    NAME                => 'Twilt::Perl',
    AUTHOR              => q{YOUR NAME <yujingz@me.com>},
    VERSION_FROM        => '0.1',
    ($eumm_version >= 6.3001
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'                    => 0,
        'YAML'                          => 0,
        'Dancer'                        => 1.3126,
        'Net::Twitter'                  => 4.01005,
        'Dancer::Plugin::Auth::Twitter' => 0.06,
        'Template'                      => 2.25,
        'Dancer::Session::Cookie'       => 0.25,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Twilt-Perl-*' },
);
