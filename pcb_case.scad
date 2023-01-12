INCH = 25.4; // to mm

$fn=64;

case_h=51.0;
case_w=52.5;

h_bottom=1;
h_pcb_bottom=3;
h_pcb=1.5;
h_pcb_sig_connector=4;
h_rim=0.5;
h_bottom_part=h_bottom+h_pcb_bottom+h_pcb+h_pcb_sig_connector;

top();
bottom();
module top() {
    difference() {
        intersection() {
            union() {
                translate([0,0,h_bottom+h_pcb_bottom+h_pcb+.1]) {
                    linear_extrude(20) pilars();
                }
                difference() {
                    translate([0,0,1])linear_extrude(21) square(53, true);
                    top_shape([case_h-2.5,case_w-2.5], 1.5, 2.5, 19.5);
                }
            }
            top_shape([case_h,case_w], 2.0, 3, 20.5);
        }
        difference() {
            union() {
                linear_extrude(h_bottom_part) square(55, true);
                linear_extrude(h_bottom_part+.6) {
                    rounded_square([case_h-1, case_w-1], 1.4, true);
                }
            }
            linear_extrude(h_bottom_part+1) rounded_square([case_h-3, case_w-3], 1.5, true);
        }
        components();
        
        for (p=[
            [ 0.75*INCH,  0.75*INCH, 20],
            [ 0.75*INCH, -0.75*INCH, 20],
            [-0.75*INCH, -0.75*INCH, 20],
            [-0.75*INCH,  0.75*INCH, 20]]
        ) translate(p) screwhole2();
    }
}

module screwhole2() {
    rotate_extrude() polygon([
        [0, 4], [2.8, 4],[2.8, 0], [1.6, 1.6-2.8], [1.6, -20], [0, -20]]);
}

module top_shape(dim, r1, r2, h) {
    hull() {
        linear_extrude(h-r2) rounded_square(dim, r1, true);
        linear_extrude(h) rounded_square([dim[0]-2*r2, dim[1]-2*r2], r1, true);
    }
}

module screwhole() {
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


module bottom() {
    difference() {
        union() {
            h= h_bottom_part;
            linear_extrude(h)rounded_square([case_h, case_w], 2, true);
            linear_extrude(h+h_rim)rounded_square([case_h-1.4, case_w-1.4], 1.5, true);
            translate([ 31, 20.75,0]) rotate( 90) screwhole();
            translate([ 31,-20.75,0]) rotate( 90) screwhole();
            translate([-31, 20.75,0]) rotate(-90) screwhole();
            translate([-31,-20.75,0]) rotate(-90) screwhole();
        }
        translate([0,0,h_bottom]) difference() {
            linear_extrude(10) square([case_h-2.5, case_w-2.5], center=true);
            linear_extrude(h_pcb_bottom*2, center=true) pilars();
        }
        screw_holes();
        components();
    }
}

module pilars() {
    for(a=[0:90:270]) rotate(a) {
        translate([-0.75*INCH, -.75*INCH]) minkowski() {
            translate([-10,-10]) square(10);
            intersection() {
                square(0.15*INCH);
                circle(0.15*INCH);
            }
        }
    }
}

module components() {
    z_components= h_bottom+h_pcb_bottom+h_pcb;
    translate([18,-25.6/2-0.05*INCH, z_components])cube([12,25.6,8.4]);
    translate([-18-12,-10.5/2+0.35*INCH, z_components])cube([12,10.5,8.4]);
    translate([-18-12,-0.55*INCH/2-0.25*INCH, z_components+h_pcb_sig_connector-0.15*INCH/2])cube([12,0.55*INCH,0.15*INCH]);
}

module screw_holes() {
    for (p=[
        [ 0.75*INCH,  0.75*INCH],
        [ 0.75*INCH, -0.75*INCH],
        [-0.75*INCH, -0.75*INCH],
        [-0.75*INCH,  0.75*INCH]]
    ) translate(p) screw_hole();
}

module screw_hole() {
    hull() {
        linear_extrude(2.3*2, center=true) hex(5.6);
        cylinder(d=3.1, h=3.3);
    }
    cylinder(d=3.1, h=10);
}



//rounded_square([25, 25], 3, true);

//case([30, 20, 10], 3);



module rounded_square(dim, r, center=undef) {
    minkowski() {
        circle(r=r);
        square([dim[0]-2*r, dim[1]-2*r], center);
    }
}

module hex(size) {
    intersection_for(a=[0:120:240]) rotate(a) square([size, size*2], true);
}

module case(dim, bevel, center=undef) {
    minkowski() {
        cylinder(h=bevel, r1=bevel, r2=0);
        cube([dim[0] - 2*bevel, dim[1] - 2*bevel, dim[2] - bevel], center);
    }
}


