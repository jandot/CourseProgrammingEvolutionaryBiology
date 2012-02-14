#!/usr/bin/perl
use strict;
use warnings;
use SVG;

#create an SVG object
my $svg = SVG->new(width => 200, height => 200);

$svg->circle(id=>'this_circle',cx=>100,cy=>100,r=>50);

my $out = $svg->xmlify;
print $out;