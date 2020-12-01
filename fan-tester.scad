//fan width tester


cube([10,10,3],true);

difference(){
    translate([0,1,3/2+10/2]){
        cube([10,8,10],true);
    }

    translate([-10/2+1,1-2,3/2+7.8/2]){
        color("Blue")
        cube([2,8,7.8],true);
    }  
    translate([-10/2+3,1-2,3/2+8/2]){
        color("Grey")
        cube([2,8,8],true);
    }
        
    translate([-10/2+5,1-2,3/2+8.2/2]){
        color("Grey")
        cube([2,8,8.2],true);
    }    
    translate([-10/2+7,1-2,3/2+8.4/2]){
        color("Grey")
        cube([2,8,8.4],true);
    }    
    translate([-10/2+9,1-2,3/2+8.6/2]){
        color("Grey")
        cube([2,8,8.6],true);
    }
}