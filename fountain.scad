//Fountain & RetroPi Case
//justin Lowe 20201123

//make island for imported models
//import gargoyle x4 (52mm wide 39mm deep, 50mm tall)
//import spout/coumn (22mm square, 70.8mm tall)
//make basin
//make base

//fan 30mm square, 7mm deep
//pi is 90mm, 58mm, 21mm high]

//difference on stls is fucked
//difference(){

//TODO TODO
//screw holes and inset heads on bottom of base
//material for heat set inserts to go into
//fan vents
//check hemispherical boss clearance

draftingFNs = 36;
renderFNs = 180;
$fn = draftingFNs;

islandRadius = 53;

gutterRadius = 75-islandRadius;
gutterHeight = 15;

wallMinThickness = 2;
wallUprightsThickness = 4;
wallHeight = 45;

//not needed :-(
wholeRadius = (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
wholeCircumf = wholeRadius*2*PI;
partsCircum = wholeCircumf/(wallHeight-wallUprightsThickness*2);
echo(floor(wholeRadius));

baseHeight = 2;
mountingPegHeight = 5;
mountingPegRadius = 2.7/2;
mountingPegBaseHeight = 5;
mountingPegBaseRadius = 5/2;
fanHolderWallThickness = 1;
fanThickness = 7.8;
fanWidth = 30.5;

//58mm between center long side moutning holes
//49mm between center short side moutning holes
//2.7mm inner diam mounting hole
//6mm outerdiam mounting hole copper
//3.5mm mounting hole center is away from edge of board (with microsd holder)
//9mm center usb1 from edge of board
//27mm center usb2 from edge of board
//so, 18mm diff, so 9mm + 9mm=18mm is center between usb1 & 2
//board 56mm wide, 85mm long



gargoyleOffset = -45;
columnScaling = 1.6;
statueHeight = wallHeight-5;

//TODO make posts larger??
module frictionFitPosts(){
//column friction fit post
translate([0,0,5/2+statueHeight]){
    cube([5,5,5],true);
}
//gargoyle friction fit post
translate([0,gargoyleOffset+10,5/2+statueHeight]){
    cube([5,5,5],true);
}

//gargoyle friction fit post
rotate([0,0,90]){
    translate([0,gargoyleOffset+10,5/2+statueHeight]){
        cube([5,5,5],true);
    }
}
//gargoyle friction fit post
rotate([0,0,180]){
    translate([0,gargoyleOffset+10,5/2+statueHeight]){
        cube([5,5,5],true);
    }
}
//gargoyle friction fit post
rotate([0,0,-90]){
    translate([0,gargoyleOffset+10,5/2+statueHeight]){
        cube([5,5,5],true);
    }
}
}
//whitespace



islandWidth = 28;
islandLength = (abs(gargoyleOffset)+12)*2;
piClearance = 16+1+5+3; //16 for usb, 1 for board, 5 for friction fit peg bases, some for slack
//piClearance = fanWidth;
islandCircleHeight = 3;
islandCircleZ = piClearance + baseHeight;
minkRad = 3;

module island(){
difference(){
    union(){
        color("LightBlue")
        //TODO minkowski??
        //island cubes
        minkowski(){
            translate([0,0,statueHeight/2]){
                cube([islandLength,islandWidth,statueHeight],true);
            }
            translate([0,0,0-minkRad]){
                sphere(minkRad);
            }
        }
        
        color("LightBlue")
        minkowski(){
            translate([0,0,statueHeight/2]){
                cube([islandWidth,islandLength,statueHeight],true);
            }
            translate([0,0,0-minkRad]){
                sphere(minkRad);
            }
        }
    }//end union
    
    translate([0,0,-minkRad*2]){
        cylinder(islandCircleZ+minkRad*2, gutterRadius+islandRadius, gutterRadius+islandRadius); 
    }
} //end difference

difference(){
    translate([0,0,islandCircleZ]){
    color("Blue")
    cylinder(islandCircleHeight, gutterRadius+islandRadius, gutterRadius+islandRadius); 
    }
    //no plinths
    //translate([0,0,islandCircleZ]){
    //color("Blue")
    //cylinder(statueHeight-islandCircleZ, gutterRadius+islandRadius, gutterRadius+islandRadius); 
    //}

    translate([33,33,islandCircleZ]){
        color("Green")
        cylinder(islandCircleHeight, 14, 14);
    }
}

        //28.25 inner diameter fan ring
        //29.8 length swaure of fan
        //2 width of fan central bars, so use 3

//fan outflow vent supports
translate([33,33,islandCircleZ]){
    color("DarkSlateGray")
    cylinder(islandCircleHeight, 17.5/2, 17.5/2);
}
translate([33,33,islandCircleZ]){
    rotate([0,0,180]){
        translate([0,-3/2,0]){
            cube([15,3,islandCircleHeight]);
        }
    }
    rotate([0,0,180+120]){
        translate([0,-3/2,0]){
            cube([15,3,islandCircleHeight]);
        }
    }
    rotate([0,0,180+240]){
        translate([0,-4/2,0]){
            cube([15,4,islandCircleHeight]);
        }
    }
}

}
//whitespace





module showStatues(){
rotate([0,0,0]){
    translate([0,0,statueHeight]){
        scale([columnScaling,columnScaling,columnScaling]){
            translate([-24.32,-28.92,0]){
                import("/home/justin/code/raspi-fountain/Gargoyle_Fountain-spout_tall.stl");
            }
        }
    }
}

translate([0,gargoyleOffset,statueHeight]){
    import("/home/justin/code/raspi-fountain/Gargoyle.stl");
}

rotate([0,0,90]){
    translate([0,gargoyleOffset,statueHeight]){
    import("/home/justin/code/raspi-fountain/Gargoyle.stl");
    }
}

rotate([0,0,180]){
    translate([0,gargoyleOffset,statueHeight]){
    import("/home/justin/code/raspi-fountain/Gargoyle.stl");
    }
}

rotate([0,0,-90]){
    translate([0,gargoyleOffset,statueHeight]){
    import("/home/justin/code/raspi-fountain/Gargoyle.stl");
    }
}


//
//translate([24.32,28.92,5/2]){
//    color("Red")
////    cube([22.1,22.1,70.8],true); //true size
//    cube([5,5,5],true); //true size
//}
//}
}
//whitespace


            
module basin(){
difference(){ //outer donut to chop off vertical slabs  
    difference(){ //main outside wall
        union(){
            //main wall
            cylinder(wallHeight, wallMinThickness+gutterRadius+islandRadius, wallMinThickness+gutterRadius+islandRadius);
            //bottom ridge
            cylinder(wallUprightsThickness, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
            //top ridge
            translate([0,0,wallHeight-wallUprightsThickness]){
                cylinder(wallUprightsThickness, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
            }
            
            //iterate and create vertical upright walls with cube/slabs - extend beyond outer wall and chop them off below.
            //outer wall suprights ar spaced according to cicumference / height (wallHeight - wallUprightsThickness*2) so they make squares (ish)
            for (i = [0:9]){
                rotate([0,0,36*i]){
                    translate([0,-wallUprightsThickness/2,0]){
                        cube([wholeRadius*1.1,wallUprightsThickness,wallHeight]);
                    }
                }
            }
            
            //iterate and create spheres inside center of these squares to create boss effect (done in code here, so the part of sphere inside the fountain basin is differenced away)
            
//            for (i = [0:9]){
//                rotate([0,0,36*i+36/2+2]){
//                    translate([wallMinThickness+gutterRadius+islandRadius-wallHeight/4+wallUprightsThickness-0.2,-wallUprightsThickness/2,wallHeight/2]){
//                        sphere(wallHeight/4);
//                    }
//                }
//            }
            
        }//end union
        
        //main interior void
        cylinder(wallHeight+1, gutterRadius+islandRadius, gutterRadius+islandRadius);
    } //end difference - main outside wall
    
    //create donut that interior void starts at outside of outside uprgihts - this will chop off extensions of verical uprights that are not circular
    difference(){
        //outer wall of donut, with room to spare
        cylinder(wallHeight+2,(wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius)*1.2, (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius)*1.2);
        //inner wall of donut ie the outer wall of basin
        cylinder(wallHeight+2,(wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius), (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius));
    }
}//end difference - outer donut to chop off vertical slabs
} //end module basin
//whitespace





module base(){
//base
color("Grey")
cylinder(baseHeight, gutterRadius+islandRadius, gutterRadius+islandRadius); 
    
//difference(){
//    wallStandinHeight = 2;
//    //wall stand in
//    color("Blue")
//    cylinder(baseHeight+wallStandinHeight, (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius), (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius)); 
//    translate([0,0,baseHeight]){
//        cylinder(wallStandinHeight, gutterRadius+islandRadius, gutterRadius+islandRadius);
//    }
//}
   
//gpio/sd card corner mounting peg 
translate([-14.5,-3,baseHeight]){
    color("Green")
    cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
    translate([0,0,mountingPegBaseHeight]){
        color("Green")
        cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
    }
}
//power/sd card corner mounting peg
translate([34.5,-3,baseHeight]){
    color("Green")
    cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
    translate([0,0,mountingPegBaseHeight]){
        color("Green")
        cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
    }
}
//usb/audio corner mounting peg
translate([34.5,55,baseHeight]){
    color("Green")
    cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
    translate([0,0,mountingPegBaseHeight]){
        color("Green")
        cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
    }
}
//ethernet/gpio corner mounting peg
translate([-14.5,55,baseHeight]){
    color("Green")
    cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
    translate([0,0,mountingPegBaseHeight]){
        color("Green")
        cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
    }
}

//fan holder
translate([-(fanWidth+fanHolderWallThickness*2)/2,63,baseHeight]){
    difference(){
        color("Grey")
        //outer holder
        cube([fanWidth+fanHolderWallThickness*2,fanThickness+fanHolderWallThickness*2,5]);
        
        translate([fanHolderWallThickness,fanHolderWallThickness,0]){
            //corners void
            cube([fanWidth,fanThickness,5]);
        }
        
        translate([fanWidth/2-10,0,0]){
            //central void
            cube([fanWidth-10,fanThickness+fanHolderWallThickness*2,5]);
            
        }
    }
}
    

}// end module base
//whitespace




//base();
basin();
        
island();
frictionFitPosts();

//showStatues();
 

