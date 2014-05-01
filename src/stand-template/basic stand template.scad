
sheet=2.96;
height=200;
width=160;

laser_kerf=.16;


number_of_grabs=2;


hang_width=6;

front_perimeter_side=15;
front_perimeter_top=15;

grab_length=66.65;
grab_width=4;


module grab(){
	difference(){ 
		square([grab_width,grab_length]);
		polygon(points=[[grab_width-.6,0],[grab_width,7],[grab_width,0]],paths=[[0,1,2]]);
	}
}
module grab_line(){
	for (i=[0:grab_length*2:(number_of_grabs-1)*grab_length*2]){
		translate([0,-i]){
			translate([-(sheet-laser_kerf)-grab_width,-grab_length]){
				grab();
			}
			translate([-(sheet-laser_kerf),-grab_length/2]) square([sheet-laser_kerf,grab_length/2]);
		}	
	}
}


module front(){
	difference(){
		square([width,height]);
		//translate([front_perimeter_side,0]) square([width-front_perimeter_side*2,height-front_perimeter_top]);
	}
	//translate([0,height]) grab_line();
	//translate([width,height]) mirror([1,0,0]) grab_line();
	translate([0,height]) square([width,sheet*2.5]);
	//translate([width/2-grab_width/2,height+sheet*2.5]) square([grab_width,sheet]);
}
module back(){
	difference(){
		union(){
			square([width,height]);
			//translate([0,height]) grab_line();
			//translate([width,height]) mirror([1,0,0]) grab_line();
			translate([0,height]) square([width,sheet*2.5]);
			//translate([width/2-grab_width/2,height+sheet*2.5]) square([grab_width,sheet]);

		}
		//translate([front_perimeter_side,0]) square([width-front_perimeter_side*2,height-front_perimeter_top]);
		
	}	

}

module side(notch=false){
	difference(){
		union(){
			square([width,height]);
			//translate([0,height-(number_of_grabs-1)*grab_length*2-grab_length]) mirror([0,1,0]) grab_line();
			//translate([width,height-(number_of_grabs-1)*grab_length*2-grab_length]) mirror([1,0,0]) mirror([0,1,0]) grab_line();
	
			translate([0,height]) hang_notch();
			
		}
		translate([width*9.5/10-4,0]) square([8,4]);
		translate([width*9.5/10,4]) circle(4);
		if (notch==true){
			translate([35,height-10]) square([3.5,10+sheet*2.5]);
		}
		//translate([front_perimeter_side,0]) square([width-front_perimeter_side*2,height-front_perimeter_top]);
	}

}


module hang_notch(){
	difference(){
		square([width,sheet*2.5]);
		translate([width/2-hang_width*1.5+27,0]) square([hang_width,sheet*2.5]);
		translate([width/2+hang_width*0.5+27,0]) square([hang_width,sheet*2.5]);
	}
	translate([width/2-hang_width/2+27,sheet]) square([hang_width,sheet*2.5]);
}

module top(){
	difference(){
		translate([-sheet,-sheet])square(width+grab_width*2+sheet*2);
		rotate(90)mirror([0,1,0]) translate([grab_width+width/2-hang_width/2+27,grab_width-sheet]) square([hang_width-laser_kerf,sheet-laser_kerf]);
		translate([width+grab_width*2,0]) rotate(90) translate([grab_width+width/2-hang_width/2+27,grab_width-sheet]) square([hang_width-laser_kerf,sheet-laser_kerf]);
		//translate([10+grab_width,10+grab_width]) square([width/2-20,width/2-20]);
		//translate([10+grab_width+width/2,10+grab_width]) square([width/2-20,width/2-20]);
		//translate([10+grab_width,10+grab_width+width/2]) square([width/2-20,width/2-20]);
		//translate([10+grab_width+width/2,10+grab_width+width/2]) square([width/2-20,width/2-20]);
		//translate([grab_width+width/2-hang_width/2,grab_width-sheet]) square([hang_width-laser_kerf,sheet-laser_kerf]);
		//translate([grab_width+width/2-hang_width/2,width+grab_width]) square([hang_width-laser_kerf,sheet-laser_kerf]);
	}
}
module hanger(){
	difference(){
		translate([-(sheet-laser_kerf),0]) square([width+grab_width*2+(sheet-laser_kerf)*2,hang_width*5-laser_kerf]);
		//left:
		translate([grab_width-sheet,hang_width*2]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([grab_width-sheet,0]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([grab_width-sheet,hang_width*4]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([grab_width*2.3,hang_width*2.5]) circle(2,$fn=20);
		//right:
		translate([width+grab_width,hang_width*2]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([width+grab_width,0]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([width+grab_width,hang_width*4]) square([sheet-laser_kerf,hang_width-laser_kerf]);
		translate([width-grab_width*0.3,hang_width*2.5]) circle(2,$fn=20);
		//centre:
		translate([45,hang_width*2.5-4]) square([sheet-laser_kerf,8-.14-laser_kerf]);
		translate([72,hang_width*2.5-4]) square([sheet-laser_kerf,8-.14-laser_kerf]);
		translate([grab_width*3,0]) square([width-grab_width*4,hang_width*1.3]);
		translate([grab_width*3,hang_width*3.7]) square([width-grab_width*4,hang_width*1.3]);
	}
	translate([0,hang_width*5.5]) square([160,2]);
}


front();
translate([width*1.2,0]) side(true);
translate([width*2.4,0]) back();
translate([width*4.6,0]) mirror ([1,0,0]) side(true);
translate([-grab_width,height*1.1]) top();
//translate([width*1.2-grab_width,height*1.1]) hanger();