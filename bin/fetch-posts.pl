use strict;
use warnings;
use feature qw( say );

package Redditor;

use Moo;
use MooX::Options;

use Data::Printer;
use List::AllUtils qw( none );
use LWP::ConsoleLogger::Easy qw( debug_ua );
use Types::Standard qw( InstanceOf );
use WWW::Mechanize::Cached ();
use WebService::Reddit     ();

my @required = (
    'access_token', 'app_key', 'app_secret', 'refresh_token',
);

option $_ => (
    is       => 'ro',
    format   => 's',
    required => 1,
) for @required;

option $_ => (
    is => 'ro',
) for 'cache_requests', 'debug';

has client => (
    is      => 'ro',
    isa     => InstanceOf ['WebService::Reddit'],
    lazy    => 1,
    builder => '_build_client',
);

sub _build_client {
    my $self = shift;
    my $ua;
    if ( $self->debug || $self->cache_requests ) {
        my $class
            = $self->cache_requests
            ? 'WWW::Mechanize::Cached'
            : 'WWW::Mechanize';
        $ua = $class->new( autocheck => 0 );
        debug_ua( $ua, 4 ) if $self->debug;
    }

    return WebService::Reddit->new(
        access_token  => $self->access_token,
        app_key       => $self->app_key,
        app_secret    => $self->app_secret,
        refresh_token => $self->refresh_token,
        $ua ? ( ua => $ua ) : (),
    );
}
package main;

use Path::Tiny qw( path );
use URI::FromHash qw( uri );

my $client = Redditor->new_with_options->client;

sub get_me {
    my $me_url = 'https://oauth.reddit.com/api/v1/me';
    my $me     = $client->get($me_url);

    say "comment karma " . $me->{comment_karma};
    say "link karma " . $me->{link_karma};
}

sub get_subreddit {
    my $subreddit
        = $client->get('https://oauth.reddit.com/r/exmormon/about')->content;
    say $subreddit->{data}->{accounts_active};
    say $subreddit->{data}->{subscribers};
}

sub get_selfies {
    my $limit   = 100;
    my $fetches = 0;
    my @filtered;
    my $after;

    while (1) {
        $fetches++;

        my $uri = uri(
            scheme => 'https',
            host   => 'oauth.reddit.com',
            path   => '/r/exmormon/new',
            query  => { limit => $limit, $after ? ( after => $after ) : () },
        );
        my $new = $client->get($uri);

        my $rows = scalar @{ $new->content->{data}->{children} };
        $after = $new->content->{data}->{children}->[-1]->{data}->{name};

        my @selfies = grep {
            exists $_->{data}->{preview}->{images}->[0]->{resolutions}
                && scalar
                @{ $_->{data}->{preview}->{images}->[0]->{resolutions} } > 1
        } @{ $new->content->{data}->{children} };
        my @keys = (
            'author',  'created_utc', 'name',      'over_18', 'permalink',
            'preview', 'subreddit',   'thumbnail', 'title',   'url',
        );
        foreach my $post (@selfies) {
            my $data = $post->{data};
            my %post = map { $_ => $data->{$_} }
                grep { defined $data->{$_} } @keys;
            push @filtered, \%post if keys %post;
            die "nothing" if !keys %post;
        }
        say "fetches $fetches rows $rows limit $limit";
        last if $fetches == 15 || $rows < $limit;
    }
    return @filtered;
}

my @selfies = get_selfies();

my $json = Cpanel::JSON::XS->new->pretty->encode( \@selfies );
path('posts.json')->spew_utf8($json);

say $client->access_token;
say "selfies found: " . scalar @selfies;
