
class Passenger
{
  Body body;
  float r;//set the radius r
  color col;
  int mood=0;

  Passenger(float r_, float x, float y)
  {
    
    r=r_;
    makeBody(r,x,y);
    body.setUserData(this);
    col=color(0,189,31);
    
  }
  
  void change()
  {
    mood=mood+1;
    if(mood>=1&&mood<=7)
    {
      
    }
      else if (mood>=8&&mood<=29)
      {
        col=color(255,199,0);
          
      }
          else if(mood>=30)
          {
            col=color(230,40,40);
          }
              
    //println(mood);
  }

  void applyForce(Vec2 v)
  {
    body.applyForce(v, body.getWorldCenter());
  }

  void display()
  {
    //get each body's screen position
    Vec2 pos=box2d.getBodyPixelCoord(body);
    //get angle
    float a=body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }
  
  void makeBody(float r,float x,float y)
  {
    //define a body
    BodyDef bd=new BodyDef();
    bd.type=BodyType.DYNAMIC;

    //set position
    bd.position=box2d.coordPixelsToWorld(x, y);
    body=box2d.world.createBody(bd);

    //make the shape of body
    CircleShape cs= new CircleShape();
    cs.m_radius=box2d.scalarPixelsToWorld(r);

    //Define a fixture
    FixtureDef fd=new FixtureDef();
    fd.shape=cs;

    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;

    body.createFixture(fd);

    body.setLinearVelocity(new Vec2(5, 0));
    body.setAngularVelocity(random(-1, 1));
  }
  
}
