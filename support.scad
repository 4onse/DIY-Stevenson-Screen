use <./openscad-arc/arc.scad>;
use <./utils/fillet.scad>;
use <./utils/shapes.scad>;

$fn=100;

pt=0.15;

rod_d=4;

l=38;

module rodholes()
{
    for(x=[0:90:360])
    {
        rotate([0,0,x])translate([35.5,0,6])difference()
        {
            cylinder(h=80,d=rod_d+pt,center=true);
        }
    }
}        

module host_holes()
{
    for(x=[0:90:360])
    {
        rotate([0,0,x])translate([35.5,0,l/2])difference()
        {
            // hexagon(7,4);
            cylinder(h=5,d=8,center=false);

        }
    }
}

// cylinder(h=60,d=rod_d+pt,center=true);
// scale([50,1,1]) sphere(r=100); 
// 3D_arc(w=20, r=20, deg=45, fn=200, h=1);


module support1 ()
{
    difference () {
        union() {
            fillet(r=10,steps=20) {
                difference() {
                    translate([0,-120,0]) cube([l,l,180],center=true);
                    translate([0,-30,90]) rotate([0,90,0]) cylinder(h=100, r1=100, r2=100, center=true,$fn=300);
                    translate([0,-30,-90]) rotate([0,90,0]) cylinder(h=100, r1=100, r2=100, center=true,$fn=300);
                }
                translate([0,-100,0]) cube([l,20,l],center=true);
            }
            translate([0,-65,0]) cube([l,70,l],center=true);
            
        }
        union () {
            translate([0,20,0])rodholes();
            cylinder(h=60, r1=4, r2=4, center=true);
            translate([0,-130,0])cube([60,5,10],center=true);
            translate([0,-130,45])cube([60,5,10],center=true);
            translate([0,-130,-45])cube([60,5,10],center=true);
        }
        translate([0,-32,0]) cube([21,100,21], center=true);
        
    }
    
}


module support2() {
    difference() {
        union () {
            translate([0,45,0]) cube([l,150,l],center=true);
            translate([0,-20,0]) cube([20,120,20], center=true);
        }
        union () {
            translate([0,20,0])rodholes();
            cylinder(h=60, r1=4, r2=4, center=true);
            translate([0,-130,0])cube([60,5,10],center=true);
            translate([0,-130,45])cube([60,5,10],center=true);
            translate([0,-130,-45])cube([60,5,10],center=true);
        }
        translate([0,20,-3]) host_holes();
        translate([0,0,-l/2+3]) hexagon(15,7);
        translate([0,95,0]) cube([40,60,40], center=true);
    }
}


// module support_ () {
//     translate([0,0,0]) {
//         translate([-150,85,18]) rotate([0,90,90]) support1();
//         // rotate([0,0,0]) translate([-20,-20,18]) support2();
//     }
// }

module support_ () {
    union() {
        translate([0,10,0]) {
            support1();
            
        }
        support2();
    }
}

support_();
// host_holes();


