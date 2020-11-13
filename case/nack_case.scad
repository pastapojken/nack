/*
 * Excuse this mess, work-in-progress
*/
keyWidth=19.05;
holeSize=14;

cutoutHeight = 3;
cutoutWidth = 1;

paddingTop = -1.75;
paddingRight = 1.25; // distance between keys is 2.5mm + compensation for padding left
paddingBottom = 0;
paddingLeft = 1;

kbWidth=13*keyWidth;
kbHeight=4*keyWidth;
kbThickness=4.2;

nack = [
    //start column 0
	[[0,0],1],
	[[0,1],1],
	[[0,2],1],
	[[0,3],1],
    //start column 1
	[[1,0],1],
	[[1,1],1],
	[[1,2],1],
	[[1,3],1],
    //start column 2
	[[2,0],1],
	[[2,1],1],
	[[2,2],1],
	[[2,3],1],
    //start column 3
	[[3,0],1],
	[[3,1],1],
	[[3,2],1],
	[[3,3],1],
    //start column 4
	[[4,0],1],
	[[4,1],1],
	[[4,2],1],
	[[4,3],1],
    //start column 5
	[[5,0],1],
	[[5,1],1],
	[[5,2],1],
	[[5,3],1],
    //start column 6
	[[6,0],1],
	[[6,1],1],
	[[6,2],1],
	[[6,3],1],
    //start column 7
	[[7,0],1],
	[[7,1],1],
	[[7,2],1],
	[[7,3],1],
    //start column 8
	[[8,0],1],
	[[8,1],1],
	[[8,2],1],
	[[8,3],1],
    //start column 9
	[[9,0],1],
	[[9,1],1],
	[[9,2],1],
	[[9,3],1],
    //start column 10
	[[10,0],1],
	[[10,1],1],
	[[10,2],1],
	[[10,3],1],
    //start column 11
	[[11,0],1],
	[[11,1],1],
	[[11,2],1],
	[[11,3],1],
    //start column 12
	[[12,0],1],
	[[12,1],1],
	[[12,2],1],
	[[12,3],1],    
];


module holematrix(holes,startx,starty){
    startx=startx+paddingLeft;
    starty=starty+paddingBottom;
	for (key = holes){
		translate([startx+keyWidth*key[0][0], starty-keyWidth*key[0][1], -0.05])
		translate([(keyWidth*key[1]-holeSize)/2,(keyWidth - holeSize)/2, -0.05])
		union(){
            cube([holeSize,holeSize,kbThickness+1]);

            translate([-cutoutWidth,1,-0.05])
            cube([holeSize+2*cutoutWidth,cutoutHeight,kbThickness+1]);

            translate([-cutoutWidth,holeSize-cutoutWidth-cutoutHeight,-0.05])
            cube([holeSize+2*cutoutWidth,cutoutHeight,kbThickness+1]);
        }
	}
}

module top_plate(){
    union() {
        difference() {
            union (){
                difference(){
                    cube([kbWidth+paddingRight,kbHeight+paddingTop, kbThickness]);
                    holematrix(nack,0,kbHeight-keyWidth);
                }
                translate([0,kbHeight+paddingTop-0.5,0]){
                    difference(){     
                        cube([kbWidth+paddingRight, 11, kbThickness]); // TOP lip
                        translate([10,0,-0.05]) 
                        cube([20, 10.5, kbThickness-1.5]);
                        translate([95,0,-0.05]) 
                        cube([50, 10.5, kbThickness-1.5]); // speaker "insert"
                        // speaker "grill"        
                        // reset button
                        translate([21,7,-0.05])
                        cylinder(h=5,d=2.5,center=false,$fn=20); 
                    }
                }
            }            
        
            translate([keyWidth*2.55,keyWidth,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20);
            translate([keyWidth*2.55,keyWidth*3,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20);    
            
            translate([keyWidth*5.05,keyWidth*1.9,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20);
            translate([keyWidth*8.05,keyWidth*1.9,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20);
            
            translate([keyWidth*10.55,keyWidth,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20);
            translate([keyWidth*10.55,keyWidth*3,-0.05])
            cylinder(h=2.5,d=1.8,center=false,$fn=20); 
        }        
    }
    translate([-1.2,0,-6])
    cube([1.2, kbHeight+paddingTop+11, kbThickness+6]);  // RIGHT wall
    translate([-1.2,-1.2,-6])
    cube([kbWidth+paddingRight+2.4, 1.2, kbThickness+6]); // BOT wall
    translate([kbWidth+paddingRight,0,-6]) 
    cube([1.2, kbHeight+paddingTop+11, kbThickness+6]); // LEFT wall
    
    difference() { // "USB hole"
        translate([-1.2,kbHeight+paddingTop+10,-6]) 
        cube([kbWidth+paddingRight+1.2+1.2, 1.2, kbThickness+6]); // TOP wall        

        hull(){ 
            translate([7,kbHeight+paddingTop+11-2,-6])
            cube([6, 5, 4.6]); 
            
            translate([7,kbHeight+paddingTop+11-2,-2.4]) 
            rotate([270,0,0]) cylinder(h=5,d=2,center=false,$fn=50);
            translate([14,kbHeight+paddingTop+11-2,-2.4]) 
            rotate([270,0,0]) cylinder(h=5,d=2,center=false,$fn=50);
            translate([7,kbHeight+paddingTop+11-2,-5.8]) 
            rotate([270,0,0]) cylinder(h=5,d=2,center=false,$fn=50);
            translate([14,kbHeight+paddingTop+11-2,-5.8]) 
            rotate([270,0,0]) cylinder(h=5,d=2,center=false,$fn=50);
            
        }
    }    
}


module bot_plate(){
    difference(){    
        screw_post_height=4;
        union(){
            translate([keyWidth*2.55,keyWidth,1]){
                cylinder(h=screw_post_height,d=5.2,center=false,$fn=20);
                cylinder(h=2,d1=8,d2=0,center=false,$fn=20);
            }
            translate([keyWidth*2.55,keyWidth*3,1]){
                cylinder(h=screw_post_height,d=5.2,center=false,$fn=20);
                cylinder(h=2,d1=8,d2=0,center=false,$fn=20);
            }
            translate([keyWidth*10.55,keyWidth,1]){
                cylinder(h=screw_post_height,d=5.2,center=false,$fn=20);
                cylinder(h=2,d1=8,d2=0,center=false,$fn=20);
            }
            translate([keyWidth*10.55,keyWidth*3,1]){
                cylinder(h=screw_post_height,d=5.2,center=false,$fn=20);
                cylinder(h=2,d1=8,d2=0,center=false,$fn=20);
            }
            cube([kbWidth+paddingRight+1,kbHeight+paddingTop, 1]); // body
            translate([0,kbHeight+paddingTop,0]){
                cube([kbWidth+paddingRight+1, 11, 1]); // top lip
            }
        }
        translate([keyWidth*2.55,keyWidth,-0.05]){
            cylinder(h=screw_post_height+0.8,d=3.6,center=false,$fn=20);
            cylinder(h=screw_post_height+1.6,d=1.8,center=false,$fn=20);
        }
        translate([keyWidth*2.55,keyWidth*3,-0.05]){
            cylinder(h=screw_post_height+0.8,d=3.6,center=false,$fn=20);
            cylinder(h=screw_post_height+1.6,d=1.8,center=false,$fn=20);
        }
        translate([keyWidth*10.55,keyWidth,-0.05]){
            cylinder(h=screw_post_height+0.8,d=3.6,center=false,$fn=20);
            cylinder(h=screw_post_height+1.6,d=1.8,center=false,$fn=20);
        }
        translate([keyWidth*10.55,keyWidth*3,-0.05]){
            cylinder(h=screw_post_height+0.8,d=3.6,center=false,$fn=20);
            cylinder(h=screw_post_height+1.6,d=1.8,center=false,$fn=20);
        }
    }

    translate([0,-1,0])
    cube([kbWidth+paddingRight+1, 1, 1]); // bottom lip
    translate([-1,-1,0])
    cube([1, kbHeight+paddingTop+11+1, 1]); // bottom lip
}


bot_plate();
translate([0, 0, 10]) 
top_plate();