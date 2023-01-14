include <Config.inc>
use <RoundedSquare.scad>
use <Pillars.scad>

$fn = 64;

Bottom();

module Bottom() {
    CHILD_INDEX_COMPONENTS = 0;
    
    difference() {
        union() {
            h= h_bottom_part;
            linear_extrude(h)RoundedSquare([case_h, case_w], 2, true);
            linear_extrude(h+h_rim)RoundedSquare([case_h-1.4, case_w-1.4], 1.5, true);
            translate([ 31, 20.75,0]) rotate( 90) ScrewHole1();
            translate([ 31,-20.75,0]) rotate( 90) ScrewHole1();
            translate([-31, 20.75,0]) rotate(-90) ScrewHole1();
            translate([-31,-20.75,0]) rotate(-90) ScrewHole1();
        }
        translate([0,0,h_bottom]) difference() {
            linear_extrude(10) square([case_h-2.5, case_w-2.5], center=true);
            linear_extrude(h_pcb_bottom*2, center=true) Pillars();
        }
        ScrewHoles();
        if ($children > CHILD_INDEX_COMPONENTS) {
            children(CHILD_INDEX_COMPONENTS);
        }
    }
    module ScrewHoles() {
        for (p=[
            [inch( 0.75), inch( 0.75)],
            [inch( 0.75), inch(-0.75)],
            [inch(-0.75), inch(-0.75)],
            [inch(-0.75), inch( 0.75)]]
        ) translate(p) ScrewHole2();
    }
    
    module ScrewHole1() {
        difference() {
            hull() {
                translate([-11/2,-11/2])cube([11,20, 2]);
                translate([-11/2,11/2])cube([11,8, 6]);
            }
            translate([-8/2,-21/2,2]) cube([8, 21,4]);
            translate([0,0,-.5]) cylinder(d=4,h=4);
            translate([0,0,-1]) cylinder(d1=0, d2=8,h=3.1);
        }
    }
    module ScrewHole2() {
        hull() {
            linear_extrude(2.3*2, center=true) Hex(5.6);
            cylinder(d=3.1, h=3.3);
        }
        cylinder(d=3.1, h=10);
    }
    
    module Hex(size) {
        intersection_for(a=[0:120:240]) rotate(a) square([size, size*2], true);
    }
    
}