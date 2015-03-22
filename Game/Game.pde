
final int BOARDWIDTH = 400;
final int BOARDLENGTH = 400;
final int BOARDHEIGHT = 20;

final float ROTY_COEFF = PI/64;
final float DEFAULT_TILT_COEFF = 0.01;
final float MAX_TILT_COEFF = 1.5*DEFAULT_TILT_COEFF;
final float MIN_TILT_COEFF = 0.2*DEFAULT_TILT_COEFF;
final float TILT_MAX = PI/3;
final int MAXCYLINDER = 10;

float tilt_coeff = DEFAULT_TILT_COEFF;

float rotation = 0.0;
float tiltX = 0.0;
float tiltZ = 0.0;


final float ballRadius = 30;
final BallRolling ball = new BallRolling(ballRadius, BOARDHEIGHT);
final ArrayList<Cylinder> cylinders = new ArrayList();
final float cylinderHeight = 150;
final float cylinderRadius = 40;
final int cylinderPrecision = 40;


Boolean addCylinder = false;
final float distanceZCamera = 1000; 
final float constProp = 85000;
// distanceZCamera = 1/ distanceSeenOnTheScreen * const
// const = 85000

void setup() {
  size(500, 500, P3D);
  noStroke();
  //cylinders.add( new Cylinder(200, 40, 40, -70, 70, BOARDHEIGHT /2));
}

void cameraAndLightSetup(){
  camera(width/2, height/2, distanceZCamera, width/2, height/2, 0, 0, 1, 0);
  directionalLight(50, 100, 125, 0, -1, -1);
  ambientLight(102, 102, 102);
}

void draw() {
  cameraAndLightSetup();
  background(200);
  
  pushMatrix();
    translate(width/2, height/2, 0);

    rotateX(tiltX);
    rotateZ(tiltZ);
    rotateY(rotation);
    box(BOARDLENGTH, BOARDHEIGHT, BOARDWIDTH);
  
    ball.display();
    ball.update(tiltX, tiltZ);
    ball.checkedge();
    for(int i=0; i<cylinders.size(); ++i){
        ball.checkedgeCylinder(cylinders.get(i));
      }
    
    pushMatrix();
      rotateX(PI/2);
      for(int i=0; i<cylinders.size(); ++i){
        cylinders.get(i).setupCyinder();
        cylinders.get(i).display();
      }
    popMatrix();
  popMatrix();
  
}
void keyPressed() {
  if(key == CODED) {
    if(keyCode == LEFT) {
      rotation += ROTY_COEFF;
    }
    else if(keyCode == RIGHT) {
      rotation -= ROTY_COEFF;
    }
    // shift
    else if(keyCode == 16){
      diplayTopVueBord();
    }
  }
}

void keyReleased(){
  // shift
  if(keyCode == 16){
    comeBackGame();
  }
}

void mouseDragged() {
  float tiltXIncrement = -tilt_coeff*(mouseY - pmouseY);
  float tiltZIncrement = tilt_coeff*(mouseX - pmouseX);
  
  if(abs(tiltX + tiltXIncrement) < TILT_MAX)
    tiltX += tiltXIncrement;
  if(abs(tiltZ + tiltZIncrement) < TILT_MAX)
    tiltZ += tiltZIncrement;
}

void mouseWheel(MouseEvent event) {
  float newTilt = tilt_coeff + event.getCount()*0.1*DEFAULT_TILT_COEFF;
  
  if(newTilt > MIN_TILT_COEFF && newTilt < MAX_TILT_COEFF)
    tilt_coeff = newTilt;
}

void diplayTopVueBord(){
  noLoop();
  background(200);
  addCylinder = true;
  
  pushMatrix();
    translate(width/2, height/2, 0);
    box(BOARDLENGTH, BOARDWIDTH, 0);
    pushMatrix();
      rotateX(-PI/2);
      ball.display();
    popMatrix();
    // display the cylinder in top view
    for(int i=0; i<cylinders.size(); ++i){
      cylinders.get(i).display();
    }
  popMatrix();
}

void comeBackGame(){
 addCylinder = false;
 loop(); 
}

void mouseClicked(){
  if(addCylinder){
    // distanceZCamera = 1/ distanceSeenOnTheScreen * const
    // const = 85000
    
    float errorMargin = 10;
    float distanceSeenOnTheScreen = constProp / distanceZCamera;
    float x = (mouseX - height/2) * BOARDLENGTH /2 / distanceSeenOnTheScreen;
    float y = (mouseY - width/2) * BOARDWIDTH /2 / distanceSeenOnTheScreen; 

    // alow error of positionning and replace the cylinder in the box
    if(abs(x) + cylinderRadius > BOARDLENGTH /2 + errorMargin) x = BOARDLENGTH /2 - cylinderRadius;
    if(abs(y) + cylinderRadius > BOARDWIDTH /2 + errorMargin) x = BOARDWIDTH /2 - cylinderRadius;
    
    // if the cilynder is in the box
    if(abs(x) + cylinderRadius <= BOARDLENGTH /2 || abs(y) + cylinderRadius <= BOARDWIDTH /2 ){
      Cylinder c = new Cylinder(cylinderHeight, cylinderRadius, cylinderPrecision, x, y, BOARDHEIGHT /2);
      cylinders.add(c);
      c.setupCyinder();
      diplayTopVueBord();
    }
    
    
  }
}

void dd(){
  background(100);
}
