
final static float g = 10; 
//final float normalForce = 1;
final float mu = 0.01;
//final float frictionMagnitude = normalForce * mu;

class BallRolling{
  private PVector location;
  private PVector velocity; 
  
  private PVector gravityForce;
  private PVector normallForce;
  private PVector friction;
  
  private final float toTranslateY;
  private final float radius;
  
  BallRolling(float radius, float boardheight){    
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    
    normallForce = new PVector(0, 0, 0);
    gravityForce = new PVector(0, 0, g);
    toTranslateY = -radius - boardheight / 2;
    this.radius = radius;
    
    
  }
     
  public void update(float rotX, float rotZ){
    location.add(velocity);
    
    gravityForce.x = sin(rotZ) * g;
    gravityForce.y = cos(rotZ) * g;
    gravityForce.z = sin(rotX) * g;
    
    normallForce.y = -gravityForce.y
    
    friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(normallForce.y * mu);
    
    velocity.x += (gravityForce.x + friction.x) * 0.01;
    println(gravityForce.x);
    velocity.z -= (gravityForce.z + friction.z) * 0.01;
    
  }
  
  public void display(){
    pushMatrix();
    translate(location.x, toTranslateY, location.z);
    fill(127);
    sphere(radius);
    popMatrix();
  }
  
}
