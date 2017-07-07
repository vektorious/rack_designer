//Created by Alexander Kutschera(alexander.kutschera@googlemail.com)
//05.07.2017
 
//Settings
bd=5; //bottom thickness in mm
d_vials=12; //vial diameter in mm (real diameter!)
min_abstand=5; //min distance between holes in mm
x_y_z_rack=[45, 45, 17]; //dimensions of the rack [length, width, heigth] in mm
hv=x_y_z_rack[2]-bd;


rv=(d_vials/2)+0.5;

anzahl_x=floor(((x_y_z_rack[0]-min_abstand)/(2*rv+min_abstand)));
anzahl_y=floor(((x_y_z_rack[1]-min_abstand)/(2*rv+min_abstand)));

abstand_x=(x_y_z_rack[0]-anzahl_x*rv*2)/(anzahl_x+1);
abstand_y=(x_y_z_rack[1]-anzahl_y*rv*2)/(anzahl_y+1);

   module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
   }

for(i=[1:anzahl_x]){
    x_pos=(abstand_x*i)+(rv*2*(i-1)+rv);
    for(iy=[1:anzahl_y]) {
        y_pos=(abstand_y*i)+(rv*2*(i-1)+rv);
                          } 
                    }
 

difference() {
	union() {
        translate([0, 0, 0])
            cube(x_y_z_rack, center = false);
        translate([0, -10, 0])
            prism(x_y_z_rack[0], 10, x_y_z_rack[2]);
        translate([ x_y_z_rack[0], x_y_z_rack[1]+10, 0])
            rotate(180, [0, 0, 1]) prism(x_y_z_rack[0], 10, x_y_z_rack[2]);
            }
    
	union() {
        for(i=[1:anzahl_x]){
            x_pos=(abstand_x*i)+(rv*2*(i-1)+rv);
            for(iy=[1:anzahl_y]) {
                y_pos=(abstand_y*iy)+(rv*2*(iy-1)+rv);
                translate([x_pos, y_pos, bd])
                    cylinder(hv, rv, rv, center = false, $fn = 100);
                                    } 
                            }
            }
	}
