//Mover mover;
//
//void setup() {
//  size(800,200);
//  mover = new Mover();
//}
//
//void draw() {
//  background(255);
//  mover.update();
//  mover.checkEdges();
//  mover.display();
//}
//void setup() {
//  size(400, 400, P3D);
//}

//void draw() {
//  background(0);
//  translate(mouseX, mouseY);
//  beginShape(TRIANGLES);
//  vertex(0, 0);
//  vertex(50, 0);
//  vertex(50, 50);
//  endShape();
//}

//PShape triangle = new PShape();
//void setup() {
//size(400, 400, P3D);
//triangle = createShape();
//triangle.beginShape(TRIANGLES);
//triangle.vertex(0, 0);
//triangle.vertex(50, 0);
//triangle.vertex(50, 50);
//triangle.endShape();
//}
//void draw() {
//background(0);
//translate(mouseX, mouseY);
//shape(triangle);
//}

float cylinderBaseSize = 50;
float cylinderHeight = 50;
int cylinderResolution = 40;
PShape openCylinder = new PShape();

void setup() {
  size(400, 400, P3D);
  float angle;
  float[] x = new float[cylinderResolution + 1];
  float[] y = new float[cylinderResolution + 1];
  
  //get the x and y position on a circle for all the sides
  for(int i = 0; i < x.length; i++) {
    angle = (TWO_PI / cylinderResolution) * i;
    x[i] = sin(angle) * cylinderBaseSize;
    y[i] = cos(angle) * cylinderBaseSize;
  }
  openCylinder = createShape();
  openCylinder.beginShape(QUAD_STRIP);
  
  //draw the border of the cylinder
  for(int i = 0; i < x.length; i++) {
    openCylinder.vertex(x[i], y[i] , 0);
    openCylinder.vertex(x[i], y[i], cylinderHeight);
  }
  openCylinder.endShape();
}

void draw() {
  background(255);
  translate(mouseX, mouseY, 0);
//  rotateX(PI/2);
  translate(0, 0, 50);
  shape(openCylinder);
}
