//$fn=1000;
wood = 4;
poti_d = 6;

// paddle
paddle_length = 100;
paddle_height = 40;


module paddle(l, h, wood){
difference(){
	cube([paddle_length, paddle_height, wood]);
	difference(){
		
		translate([0,0,-5]) scale([2.5,1,1]) cylinder(h=10,r=h-10);
	// gives us a lower circle of about 40
	translate([-50,h-15,0])cube([200,100,100]);	
	}
	// steg
	translate( [10,paddle_height-7,-5]) cube([12,wood,10]);
	translate( [l-10-12,paddle_height-7,-5]) cube([12,wood,10]);
	translate( [l-10-12,7,-5]) cube([12,wood,10]);


}
}

module paddle_steg(wood, poti){
	difference(){
	union(){
		cube([12,2*wood+2+poti, wood]);
		translate([-wood,wood,0])cube([12+(2*wood), 2+poti, wood]);

}
		translate([6, (2*wood+2+poti)/2, -5]) cylinder(r=(poti-0.3)/2, h=10); 
	}

	
}

module top_plate(wood){
	difference(){
	union(){
		translate([-60,-60/sqrt(2),0])cube([120,60+(60/sqrt(2)),wood]);
		cylinder(r=60, h=wood);
	}
		translate([0,0,-10]) cylinder(r=3, h=20);

		//cube([(60/sqrt(2))*2,60,wood]);
		//translate([(60/sqrt(2)), 40, -5]) cylinder(r=3.05, h=100);	

	translate([-100, 20 ,-20])cube([200,200,200]);
		translate([-57,0-10])cube([wood,20, 20]);
		translate([57-wood,0-10])cube([wood,20, 20]);

	}
}

module bottom_plate(wood){
	difference(){
	union(){
		translate([-60,-20/sqrt(2),0]) cube([120,60+(20/sqrt(2)),wood]);
		cylinder(r=25, h=wood);
	
	}
	translate([-100, 20 ,-20])cube([200,200,200]);
		translate([-57,0-10])cube([wood,20, 20]);
		translate([57-wood,0-10])cube([wood,20, 20]);


}
}

module abstand(wood){
	union(){
		cube([20,15+(2*wood),wood]);
		translate([-wood,wood,0])cube([20+(2*wood), 15, wood]);
	}
}

module front_panel(wood){
	difference(){
		cube([120,60,wood]);
		
		// LCD Ausschnitt
		translate([60,40,-10]) cube([100,20,30], center=true);
		
		// Buttons
		translate([90, 15,-10]) cylinder(r=6, h=30, center=true);

		translate([30, 15,-10]) cylinder(r=6, h=30, center=true);

		// rotary encoder
translate([60, 15,-10]) cylinder(r=3, h=30, center=true);
	
		
		// TODO Löcher für Panel Montage
		// TODO halterungen für unten
	}
}


module 2d_paddle() {
projection(cut=true){
		paddle(paddle_length, paddle_height, wood);
		translate([0,50,0]) paddle(paddle_length, paddle_height, wood);
		translate([-20,0,0]){
		paddle_steg(wood, poti_d);
		translate([25,0,0])paddle_steg(wood, poti_d);
		translate([50,0,0])paddle_steg(wood, poti_d);}

		translate([0,-30,0]) top_plate(wood);
		translate([150,-30,0]) bottom_plate(wood);
	
		translate([-100,0,0]) abstand(wood);
		translate([-70,0,0]) abstand(wood);

		translate([-200,-70,0]) front_panel(wood);

}
}

module 3d_paddle(){
	translate([0,0,40])top_plate(wood);
	translate([0,0,25-wood]) bottom_plate(wood);
	
	translate([11,16,0]) rotate([90,0,-90]) paddle(paddle_length, paddle_height, wood);
	translate([-7,16,0]) rotate([90,0,-90]) paddle(paddle_length, paddle_height, wood);

	translate([-60,-60+20,40+wood]) rotate([90,0,0]) front_panel(wood);

}

2d_paddle();



// TODO

// * der poti sollte irgendwie gehalten werden
// * abrundungen wären nicht schlecht
