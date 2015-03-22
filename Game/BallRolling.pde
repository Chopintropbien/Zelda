
final static float g = 10; 
final float step = 0.05;
final float mu = 0.1;
final float coefReb = 0.7;

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
    
    normallForce.y = -gravityForce.y;
    
    friction = velocity.get();
    friction.mult(-1);
    friction.normalize();
    friction.mult(normallForce.y * mu);
    
    velocity.x += (gravityForce.x - friction.x) * step;
    velocity.z -= (gravityForce.z + friction.z) * step;
    
  }
  
  public void display(){
    pushMatrix();
    translate(location.x, toTranslateY, location.z);
    fill(127);
    sphere(radius);
    popMatrix();
  }
  
  public void checkedge(){
    float borderX = (BOARDLENGTH/2 - radius);
    float borderZ = (BOARDWIDTH/2 - radius);
    if(abs(location.x) >= borderX){
      velocity.x *= -coefReb;
      location.x = location.x < 0 ? -borderX : borderX;
    }
    if(abs(location.z) >= borderZ){
      velocity.z *= -coefReb;
      location.z = location.z < 0 ? -borderZ : borderZ;
    }
  }
  
  public void checkedgeCylinder(Cylinder c){
    if( pow((location.x - c.x()), 2) +  pow((location.z - c.y()), 2) <= pow(c.radius + radius, 2) ) {
       PVector newVelocity = new PVector(0, 0, 0);
       PVector normal = c.normal(location);
       normal.mult(2* normal.dot(velocity));
       
       newVelocity.add(velocity);
       newVelocity.sub(normal);
       
       velocity.x = newVelocity.x * coefReb;
       velocity.z = newVelocity.z * coefReb;
       
       normal.normalize();
       normal.mult(c.radius + radius);
       location.x = c.x() - normal.x;
       location.z = c.y() - normal.z;
    }
  }
  
}
