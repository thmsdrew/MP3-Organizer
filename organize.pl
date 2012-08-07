#!/usr/bin/perl
use strict;
use warnings;

use MP3::Tag;
use File::Copy::Recursive qw(fcopy);
use File::Path qw(mkpath);

foreach my $file (<*.mp3>) {
    my $mp3 = MP3::Tag->new($file);
    my ($song, $track, $artist, $album) = $mp3->autoinfo();
    $mp3->close();
    s/['\\/:*?"<>|']//g for $artist, $album;
    fcopy($file, "$artist/$album/$file") or die $!;
    unlink($file);
}
