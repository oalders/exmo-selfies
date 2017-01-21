use strict;
use warnings;
use feature qw( say );

use Cpanel::JSON::XS qw( decode_json );
use Path::Tiny qw(path);

my $posts = decode_json( path('posts.json')->slurp );
my %posts = map { $_->{name} => $_ } @{$posts};
my @posts
    = sort { $a->{created_utc} <=> $b->{created_utc} } values %posts;

sub escape_html {
    my $text = shift;
    $text =~ s{"}{&quot;}g;
    return $text;
}

my @html;
foreach my $post (@posts) {
    my $img = $post->{preview}->{images}->[0]->{resolutions}->[0];
    push @html, sprintf(
        qq{<div class="Image_Wrapper" data-caption="%s"><a href="https://www.reddit.com%s"><img src="%s" width="%s" height="%s"></a></div>\n},
        escape_html( $post->{title} ), $post->{permalink}, $img->{url},
        $img->{width},
        $img->{height}
    );
}

path('hrefs.txt')->spew_utf8(@html);

say scalar @posts . ' posts found';

# PODNAME: process-posts.pl
# ABSTRACT: Extract selfies from raw JSON posts
