include <Config.inc>
use <RoundedSquare.scad>
use <Pillars.scad>

$fn =64;

Top(is_printable = true);

module Top(
    is_printable = false
) {
    CHILD_INDEX_COMPONENTS = 0;
    
    if(is_printable) {
        rotate(180, [1, 0, 0]) {
            Top(is_printable = false);
        }
    } else {
        difference() {
            intersection() {
                union() {
                    translate([0,0,h_bottom+h_pcb_bottom+h_pcb+.1]) {
                        linear_extrude(20) Pillars();
                    }
                    difference() {
                        translate([0,0,1])linear_extrude(21) square(53, true);
                        TopShape([case_h-2.5,case_w-2.5], 1.5, 2.5, 19.5);
                    }
                }
                TopShape([case_h,case_w], 2.0, 3, 20.5);
            }
            difference() {
                union() {
                    linear_extrude(h_bottom_part) square(55, true);
                    linear_extrude(h_bottom_part+.6) {
                        RoundedSquare([case_h-1, case_w-1], 1.4, true);
                    }
                }
                linear_extrude(h_bottom_part+1) RoundedSquare([case_h-3, case_w-3], 1.5, true);
            }
            if ($children > CHILD_INDEX_COMPONENTS) {
                children(CHILD_INDEX_COMPONENTS);
            }
            
            for (p=[
                [inch( 0.75), inch( 0.75), mm(20)],
                [inch( 0.75), inch(-0.75), mm(20)],
                [inch(-0.75), inch(-0.75), mm(20)],
                [inch(-0.75), inch( 0.75), mm(20)]]
            ) translate(p) screwhole2();
        }
    }
    
    module TopShape(dim, r1, r2, h) {
        hull() {
            linear_extrude(h-r2) RoundedSquare(dim, r1, true);
            linear_extrude(h) RoundedSquare([dim[0]-2*r2, dim[1]-2*r2], r1, true);
        }
    }
    
    module screwhole2() {
        rotate_extrude() polygon([
            [0, 4], [2.8, 4],[2.8, 0], [1.6, 1.6-2.8], [1.6, -20], [0, -20]]);
    }
}