
class Cylinder{
  final private float radius;
  final private float height;
  final private int cylinderResolution;
  final private PVector location;
  private PShape openCylinder = new PShape();
  
  
 // location of the center of the center of the cylindre in the board coordonnate
 Cylinder(float height, float radius, int cylinderResolution, float xc, float yc, float zc){
  this.height = height;
  this.radius = radius;
  this.cylinderResolution = cylinderResolution;
  location = new PVector(xc, yc, zc);
 }
 
 void setupCyinder(){
  float angle;
  float[] x = new float[cylinderResolution + 1];
  float[] y = new float[cylinderResolution + 1];
  
  //get the x and y position on a circle for all the sides
  for(int i = 0; i < x.length; i++) {
    angle = (TWO_PI / cylinderResolution) * i;
    x[i] = sin(angle) * radius;
    y[i] = cos(angle) * radius;
  }
  
  openCylinder = createShape();
  openCylinder.beginShape(QUAD_STRIP);
  
  //draw the border of the cylinder
  for(int i = 0; i < x.length; i++) {
    openCylinder.vertex(x[i], y[i] , 0);
    openCylinder.vertex(x[i], y[i], height);
  }
  openCylinder.vertex(x[0], y[0] , 0);
  openCylinder.vertex(x[0], y[0], height);
    
  //draw the top of the cylinder
  openCylinder.vertex(0, 0, height);
  for(int i = 0; i < x.length; i++) {
    if(i%2 == 0) openCylinder.vertex(x[i], y[i], height);
    else openCylinder.vertex(0, 0, height);
  }
  openCylinder.vertex(0, 0, height);
  openCylinder.vertex(x[0], y[0], height);
  
  openCylinder.endShape();
 }
 
 void display(){
    pushMatrix();
    translate(location.x, location.y, location.z);
    fill(127);
    shape(openCylinder);
    popMatrix();
  }
  
  PVector normal(PVector p){
    PVector n = new PVector();
    n.x = p.x - location.x;
    n.z = p.z - location.y;
    n.normalize();
    return n;
  }
  
  float x(){ return location.x;}
  float y(){ return location.y;}
  float radius(){return radius;}
   
 }
   
   
   
   
//   displayTheta(PI/20);
//   rotateZ(-PI/20);
//   displayTheta(PI/20);
   
 
// private void displayTheta(float theta){
//   fill(127);
//   line(1, height/2, 1, -height/2);
//   displayTriangle(theta, height/2);
//   displayTriangle(theta, -height/2);
// }
// 
// private void displayTriangle(float theta, float height){
//  pushMatrix();
//  rotateX(PI/2);
//  translate(0, 0, height);
//    beginShape(TRIANGLE);
//      vertex(0, 0);
//      vertex(0, radius);
//      vertex(sin(theta) * radius, cos(theta) * radius);
//    endShape();
//  popMatrix();
// }
  
  


