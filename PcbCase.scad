use <Top.scad>
use <Bottom.scad>

translate([0, 0,  10]) Top();
translate([0, 0, -10]) Bottom();

module components() {
    z_components= h_bottom+h_pcb_bottom+h_pcb;
    translate([18,-25.6/2-0.05*INCH, z_components])cube([12,25.6,8.4]);
    translate([-18-12,-10.5/2+0.35*INCH, z_components])cube([12,10.5,8.4]);
    translate([-18-12,-0.55*INCH/2-0.25*INCH, z_components+h_pcb_sig_connector-0.15*INCH/2])cube([12,0.55*INCH,0.15*INCH]);
}
