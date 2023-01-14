use <Units.scad>

case_h              = mm(51.0);
case_w              = mm(52.5);

h_bottom            = mm(1.0);
h_pcb_bottom        = mm(3.0);
h_pcb               = mm(1.5);
h_pcb_sig_connector = mm(4.0);
h_rim               = mm(0.5);

/* Derived */
h_bottom_part       = (
    h_bottom+h_pcb_bottom+h_pcb+h_pcb_sig_connector
);