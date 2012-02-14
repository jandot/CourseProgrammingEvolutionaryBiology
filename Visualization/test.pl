#!/usr/bin/perl -w
use strict;
use SVG;
my $svg  = SVG->new(width=>"600px", height=>"600px", onload=>"init(evt)");
$svg->script()->CDATA(qq%
        var SVGDoc;
        var groups = new Array();
        var last_group;
        
        /*****
        *
        *   init
        *
        *   Find this SVG's document element
        *   Define members of each group by id
        *
        *****/
        function init(e) {
            SVGDoc = e.getTarget().getOwnerDocument();
            append_group(§.int(rand(6)).','.int(rand(6)).','.int(rand(6)).qq§); // group 0
            append_group(§.int(rand(6)).','.int(rand(6)).','.int(rand(6)).qq§); // group 1
            append_group(§.int(rand(6)).','.int(rand(6)).qq§); // group 2
            append_group(§.int(rand(6)).qq§); // group 3
        }
        /*****
        *
        *   append_group
        *
        *   Build an array of elements and append to
        *   group array
        *
        *****/
        function append_group() {
            var roads = new Array();
            for (var i = 0; i < arguments.length; i++) {
                var index = arguments[i];
                var road  = SVGDoc.getElementById("road" + index);
                roads[roads.length] = road;
            }
            groups[groups.length] = roads;
        }
        /*****
        *
        *   set_group_color
        *
        *   Set last group elements to default color
        *   Set all elements in new group to specified color
        *
        *****/
        function set_group_color(group_index, color) {
            if ( last_group != null ) {
                _set_group_color(last_group, "black");
            }
            _set_group_color(group_index, color);
            last_group = group_index;
        }
        
        /*****
        *
        *   _set_group_color
        *
        *   Loop through all elements in group and set
        *   stroke to specified color.
        *   Each element in the group is brought to the
        *   top of the drawing order to clean up
        *   intersections
        *
        *****/
        function _set_group_color(group_index, color) {
            var roads = groups[group_index];
            for (var i = 0; i < roads.length; i++) {
                var road = roads[i];
                
                road.setAttribute("stroke", color);
                road.getParentNode.appendChild(road);
            }
        }
        %);

my $g1 = $svg->group(stroke=>"black", 'stroke-width'=>"4pt", 'stroke-linecap'=>"square");

my $items = int(rand(3))+6;

foreach my $id (0..$items) {
  my @x = (int(rand(200)));
  my @y = (int(rand(200)));
  foreach my $i (0..int(rand(5))) {
    my $xi = int(rand(400));
    my $yi = int(rand(400));
    push @x,$xi;
    push @y,$yi;
  }
  my $path = $svg->get_path(-type=>'polyline',x=>\@x,y=>\@y);
  $g1->polyline(id=>'road'.$id,%$path,'fill-opacity'=>'0');
}
my $ty = 10;
foreach my $i (0..3) {
  my $j = $i+1;
  my $color = 'rgb('.int(rand(255)).','.int(rand(250)).','.int(rand(255)).')';
  my $g = $svg->group(onmousedown=>"set_group_color($i, '$color')");
  $g->circle(cx=>"400", cy=>$ty, r=>"5", fill=>"$color");
  $g->text( x=>"410", y=>$ty+4 )->cdata("Group $j");
  $ty += 15;
}

print "Content-Type: image/svg+xml\n\n";

print $svg->xmlify;