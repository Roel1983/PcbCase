
RoundedSquare([100, 200], 30, center = true);

module RoundedSquare(dim, r, center=undef) {
    minkowski() {
        circle(r=r);
        square([dim[0]-2*r, dim[1]-2*r], center);
    }
}