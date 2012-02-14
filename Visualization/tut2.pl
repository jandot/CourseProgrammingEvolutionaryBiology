#!/usr/bin/perl
use strict;
use warnings;
use SVG;

my $svg = SVG->new(width=>200,height=>200);

my %group_style = (
	'opacity' => 1,
	'fill' => 'red',
	'stroke' => 'green',
	'fill-opacity' => 0.4,
	'stroke-opacity' => '1');

$svg->comment('Define a child of $svg called $gp1');
my $gp1 = $svg->group(id=>'group_1',style=>\%group_style);
my $a1 = $gp1->anchor(-href=>'http://www.w3c.org');
$a1->circle(id=>'this_circle',cx=>170,cy=>100,r=>20);
$a1->circle(id=>'that_circle',cx=>100,cy=>170,r=>20);
$a1->circle(id=>'the_other_circle',cx=>180,cy=>160,r=>20,style=>{stroke=>'cyan'});

my $gp2 = $svg->group(id=>'group_2');
$svg->comment('here is one way to define text');
my $t1 = $gp2->text(x=>80,y=>20);
$t1->cdata('Tutorial');
$svg->comment('Here is another way to define text');
$gp2->text(x=>120,y=>20)->cdata('Two');
$gp2->anchor(-href=>'/SVG.html')
	->text(x=>20,y=>40,fill=>'rgb(200,30,100)')
	->cdata('Brought to you bt the letters SVG and pm');

my $out = $svg->xmlify;
print $out;