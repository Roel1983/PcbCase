use <Units.scad>

Pillars();

module Pillars() {
    for(a=[0:90:270]) rotate(a) {
        translate([inch(-0.75), inch(-.75)]) minkowski() {
            translate([-10,-10]) square(10);
            intersection() {
                square(inch(0.15));
                circle(inch(0.15));
            }
        }
    }
}