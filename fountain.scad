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
//test friction fit pegs
//screw holes and inset for screw heads on bottom of base
//material for heat set inserts to go into
//check hemispherical boss clearance on final render
//NOPE-fan holder under island opens towards the -y axis (towards the +x axis plinth)
//YEP-heat insert holes to hold fan in place

//maybe TODO
//more/bigger fan vents?
//make vents travel up to top of basin further?
//fan cable clip behind holder

//FIRST: test printing basin upside down with new filament. see if support marks marr the visible surface. If not, then we can print upside down and have outer wall be entireley attached to base. (base does not need to be that thick, but see if printing time is much saved for decrese in the inner part's height)
//    upside down: allows for straight top under edge of wall (not 45 degree angle). might be less support material & faster print (depends on height of inner circular platform from bottom vs from top). no bridging of passthroughs, but that seemed to go fine.
//possibly have inset track in base for inner wall width (not outer wall uprights)


draftingFNs = 36;
renderFNs = 180;
$fn = draftingFNs;

printHorizontalTolerance = 0.1;

islandRadius = 53;

gutterRadius = 75-islandRadius;
gutterHeight = 15;

wallMinThickness = 2;
wallUprightsThickness = 4;
wallHeight = 45;
wallInsetRingDepth = 2; //how deep of a trench to make in the base, for the basin to sit in?
wallInsetRingGap = 1; //how much shorter should the basin wall be, then the trench that it goes into?
wallInsetTolerance = 0.2; //how much bigger to make trench than the basin wall that goes into it - applied to RADIUS, so on each side remember

//not needed :-(
wholeRadius = (wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
wholeCircumf = wholeRadius*2*PI;
partsCircum = wholeCircumf/(wallHeight-wallUprightsThickness*2);
echo(floor(wholeRadius));

baseHeight = wallUprightsThickness;
mountingPegHeight = 5;
mountingPegRadius = 2.7/2;
mountingPegBaseHeight = 4;
mountingPegBaseRadius = 5/2;
fanHolderWallThickness = 2;
fanThickness = 7.8;
fanWidth = 30.5;
fanCornerWidth = 6;

//58mm between center long side moutning holes
//49mm between center short side moutning holes
//2.7mm inner diam mounting hole
//6mm outerdiam mounting hole copper
//3.5mm mounting hole center is away from edge of board (with microsd holder)
//9mm center usb1 from edge of board
//27mm center usb2 from edge of board
//so, 18mm diff, so 9mm + 9mm=18mm is center between usb1 & 2
//board 56mm wide, 85mm long



//heat insert mounts
voidInsertRadius = 5.3/2;
voidInsertHeight = 5;
voidInsertHeightBottomPadding = 2;
voidInsertWallThickness = 3;

rotHeat = 9.3; //how many degrees to rotate heat insert on basin walls to center them
gapBaseBasinFactor = 1.05; //factor to multiple base height by to get a small gap between heat set insert and actual base plate - not used.
gapBaseBasinSize = 0.24; //absolute size to add to get a small gap between heat set insert and actual base plate - about one printed layer

//test heat insert on basin wall
difference(){
    union(){
        translate([0,0,baseHeight+gapBaseBasinSize]){
        //        rotate([0,0,(0-5)/2]){
            rotate([0,0,-rotHeat/2]){
                rotate_extrude(angle = rotHeat){
                    translate([gutterRadius+islandRadius-6,0,0]){
                        square([6.1,7]);
                    }
                }
            }
        }
        translate([gutterRadius+islandRadius-4-voidInsertRadius-3+3.8,0,baseHeight+gapBaseBasinSize]){
        //        difference(){
            color("Green")
            cylinder(7, voidInsertRadius+3, voidInsertRadius+3);
        }
    } //end union
        
        
    //            translate([0,0,-2]){
    translate([gutterRadius+islandRadius-4-voidInsertRadius-3+3.8,0,baseHeight+gapBaseBasinSize]){
        color("Green")
        cylinder(7, voidInsertRadius, voidInsertRadius-0.1);
    }

}



//
//    translate([-14.5,55,baseHeight]){
//        difference(){
//            color("Green")
//            cylinder(5, voidInsertRadius+3, voidInsertRadius+3);
//            translate([0,0,-2]){
//                color("Green")
//                cylinder(7, voidInsertRadius-0.1, voidInsertRadius);
//            }
//        }
//    }







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
islandCircleHeight = 6;
islandCircleZ = piClearance + baseHeight;
minkRadPlinth = 3;
minkRadVoid = 5;

module island(){
difference(){
    union(){ 
        //main circular platform to support plinths
        translate([0,0,islandCircleZ-minkRadVoid]){
            color("Blue")
            cylinder(islandCircleHeight+minkRadVoid, gutterRadius+islandRadius, gutterRadius+islandRadius); 
        }
    
        //island cubes
        color("LightBlue")
        minkowski(){
            translate([0,0,statueHeight/2]){
                cube([islandLength,islandWidth,statueHeight],true);
            }
            translate([0,0,0-minkRadPlinth]){
                sphere(minkRadPlinth);
            }
        }
        
        color("LightBlue")
        minkowski(){
            translate([0,0,statueHeight/2]){
                cube([islandWidth,islandLength,statueHeight],true);
            }
            translate([0,0,0-minkRadPlinth]){
                sphere(minkRadPlinth);
            }
        }
    }//end union
    
    
    //subtraction cylinder to create void for fan vent  
    translate([33,33,islandCircleZ]){
        color("Green")
        cylinder(islandCircleHeight, 14, 14);
    }
    
    
    //remove bottom of plints and chamfer bottom edge of island
    minkowski(){
        translate([0,0,-minkRadVoid*2]){
            cylinder(islandCircleZ+minkRadVoid*2,gutterRadius+islandRadius-minkRadVoid,gutterRadius+islandRadius-minkRadVoid);
        }
        translate([0,0,-minkRadVoid]){
            sphere(minkRadVoid);
        }
    }
} //end difference

//28.25 inner diameter fan ring
//29.8 length swaure of fan
//2 width of fan central bars, so use 3

//fan outflow vent supports/struts
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
} //end fan vent struts

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
            //
            translate([0,0,baseHeight-wallInsetRingDepth+wallInsetRingGap]){
                cylinder(wallHeight-baseHeight, wallMinThickness+gutterRadius+islandRadius, wallMinThickness+gutterRadius+islandRadius);
            }
//            //bottom ridge - not used here now - bottom rid is now part of base cylinder that basin sits on top of (or slightly in trench on base cylinder)
//            cylinder(wallUprightsThickness, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
            //top ridge
            translate([0,0,wallHeight-wallUprightsThickness]){
                cylinder(wallUprightsThickness, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
            }
            //top ridge graduated overhang (so no supports needed when printing)
            translate([0,0,wallHeight-wallUprightsThickness*2+0.5]){
                cylinder(wallUprightsThickness-0.5,wallMinThickness+gutterRadius+islandRadius,wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
            }
            
            //iterate and create vertical upright walls with cube/slabs - extend beyond outer wall and chop them off below.
            //outer wall suprights ar spaced according to cicumference / height (wallHeight - wallUprightsThickness*2) so they make squares (ish)
            for (i = [0:9]){
                rotate([0,0,36*i]){
                    translate([0,-wallUprightsThickness/2,wallUprightsThickness]){
                        cube([wholeRadius*1.1,wallUprightsThickness,wallHeight-wallUprightsThickness]);
                    }
                }
            }
            
            //iterate and create spheres inside center of these squares to create boss effect (done in code here, so the part of sphere inside the fountain basin is differenced away)
            
            for (i = [0:9]){
                rotate([0,0,36*i+36/2+2]){
                    translate([wallMinThickness+gutterRadius+islandRadius-wallHeight/4+wallUprightsThickness-0.2,-wallUprightsThickness/2,wallHeight/2-1.5]){
                        sphere(wallHeight/4);
                    }
                }
            }
            
        }//end union
        
        //main interior void
        cylinder(wallHeight+1, gutterRadius+islandRadius, gutterRadius+islandRadius);
        
//        //fan vents
//        for (i = [-5:5]){
//            translate([i*3,(gutterRadius+islandRadius)-(1*abs(i))-1,wallUprightsThickness]){
//                cube([1.5,(wallMinThickness+wallUprightsThickness)*2,fanWidth-2]); //FIXME magic number, from fanwidth - base - height - wall thickness or some such
//            }
//        }
        
        //intake vents 
        //ugh magic numbers for not cutting out columns
        for (i = [-8,-7,-6,-5,-4,-3,-2,0,1,2,3,4,5,6,7,8,9,10,12,13,14,15,16,17,18,19,20,21,22]){
            rotate([0,0,3.75+i*3]){
                translate([-(gutterRadius+islandRadius)-6,0,wallUprightsThickness]){
                    cube([(wallMinThickness+wallUprightsThickness)*2,2,8.5]); //FIXME magic number, from fanwidth - base - height - wall thickness or some such
                }
            }
        }
        
        //usb passthrough hole
        usbPassThroughRadius = 4;
        usbPassThroughWidth = 20; //TODO check this
        translate([-usbPassThroughRadius-12.5,-(gutterRadius+islandRadius)+4,usbPassThroughRadius-3+baseHeight+mountingPegBaseHeight]){
            rotate([90,0,0]){
                hull(){
                    cylinder((wallMinThickness+wallUprightsThickness)*2,usbPassThroughRadius,usbPassThroughRadius);
                    translate([usbPassThroughWidth-usbPassThroughRadius*2,0,0]){
                        cylinder((wallMinThickness+wallUprightsThickness)*2,usbPassThroughRadius,usbPassThroughRadius);
                    }
                    translate([-usbPassThroughRadius,-(usbPassThroughRadius+5),0]){
                        cube([usbPassThroughWidth,usbPassThroughRadius+5,(wallMinThickness+wallUprightsThickness)*3]);
                    }
                }
            }
        }
        
        //power passthrough hole
        //15.1mm from mounting hole
        //usb cable is around 5mm DIAMETER, so how about 4mm radius hole x 5 cables

        powerPassThroughRadius = 4;
        powerPassThroughWidth = 10; // TODO check this fits 2 or more cables well
        //translate([-powerPassThroughRadius,-(gutterRadius+islandRadius)+4,powerPassThroughRadius+2+baseHeight+mountingPegBaseHeight]){
        //FIXME magic number of 60, correct way is to use trig. fix later...
        translate([-60,55-15.1-1.5,powerPassThroughRadius-3+baseHeight+mountingPegBaseHeight]){
            rotate([90,0,-90]){
                hull(){
                    cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
                    translate([powerPassThroughWidth-powerPassThroughRadius*2,0,0]){
                        cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
                    }
                    translate([-powerPassThroughRadius,-(powerPassThroughRadius+5),0]){
                        cube([powerPassThroughWidth,powerPassThroughRadius+5,(wallMinThickness+wallUprightsThickness)*3]);
                    }
                }
            }
        }
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
    difference(){
        //base cylinder itself
        color("Grey")
        cylinder(baseHeight, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius, wallUprightsThickness+wallMinThickness+gutterRadius+islandRadius);
        
        //subtract area from base for melted plastic from heat insert to go into  
        translate([-14.5,55,baseHeight+mountingPegBaseHeight-voidInsertHeight-voidInsertHeightBottomPadding]){
            color("Green")
            cylinder(voidInsertHeightBottomPadding+voidInsertHeight, voidInsertRadius-0.1, voidInsertRadius-0.1);
        }
        
        //baseHeight-wallInsetRingDepth+wallInsetRingGap
        translate([0,0,baseHeight-wallInsetRingDepth]){
            //trench for basin to sit in - make a donut, with tolerance
            difference(){
                //main wall
                cylinder(wallInsetRingDepth, wallMinThickness+gutterRadius+islandRadius+wallInsetTolerance, wallMinThickness+gutterRadius+islandRadius+wallInsetTolerance);
                
                //main interior void
                cylinder(wallInsetRingDepth, gutterRadius+islandRadius-wallInsetTolerance, gutterRadius+islandRadius-wallInsetTolerance);
            
            }
        }
    } 
       
    
    //usb/audio corner mounting peg   
    translate([-14.5,-3,baseHeight]){
        color("Green")
        cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
        translate([0,0,mountingPegBaseHeight]){
            color("Green")
            cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
        }
    }
    //ethernet/gpio corner mounting peg
    translate([34.5,-3,baseHeight]){
        color("Green")
        cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
        translate([0,0,mountingPegBaseHeight]){
            color("Green")
            cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
        }
    }
    //gpio/sd card corner mounting peg 
    translate([34.5,55,baseHeight]){
        color("Green")
        cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
        translate([0,0,mountingPegBaseHeight]){
            color("Green")
            cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
        }
    }
    
//    //power/sd card corner mounting peg
//    translate([-14.5,55,baseHeight]){
//        color("Green")
//        cylinder(mountingPegBaseHeight, mountingPegBaseRadius, mountingPegBaseRadius);
//        translate([0,0,mountingPegBaseHeight]){
//            color("Green")
//            cylinder(mountingPegHeight, mountingPegRadius, mountingPegRadius*0.9);
//        }
//    }
    //OR power/sd card corner heat insert //ugh tired, this is going to magic numbers
    translate([-14.5,55,baseHeight+mountingPegBaseHeight-voidInsertHeight]){
        difference(){
            color("Green")
            cylinder(voidInsertHeight, voidInsertRadius+voidInsertWallThickness, voidInsertRadius+voidInsertWallThickness);
            translate([0,0,0]){
                //NB: subtraction from base occurs higher up, this ujst subtracts from above base cylinder
                color("Green")
                cylinder(voidInsertHeight, voidInsertRadius-0.1, voidInsertRadius);
            }
        }
    }
  

}// end module base
//whitespace




base();
//basin();
      
island();
//frictionFitPosts();

//showStatues();


 
//        powerPassThroughRadius = 4;
//        powerPassThroughWidth = 20; 
////
//                hull(){
//                cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
//                    translate([powerPassThroughWidth-powerPassThroughRadius*2,0,0]){
//                        cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
//                    }
//                
//                
//                    translate([-powerPassThroughRadius,-(powerPassThroughRadius+5),0]){
//                        cube([powerPassThroughWidth,powerPassThroughRadius+5,(wallMinThickness+wallUprightsThickness)*3]);
//                    }
//                }


//                hull(){
//                    cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
//                    translate([powerPassThroughRadius*2,0,0]){
//                        cylinder((wallMinThickness+wallUprightsThickness)*3,powerPassThroughRadius,powerPassThroughRadius);
//                    }
//                    translate([-powerPassThroughRadius,-(powerPassThroughRadius+5),0]){
//                        cube([powerPassThroughWidth,powerPassThroughRadius+5,(wallMinThickness+wallUprightsThickness)*3]);
//                    }
//                }
