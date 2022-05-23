
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Passenger> passengers;
ArrayList<Wall> walls;
ArrayList<Seat> seats;


void setup()
{
  size(1500, 720);
  smooth();

  box2d=new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  //NO GRAVITY
  //box2d.setGravity(0, 0);

  passengers=new ArrayList<Passenger>();
  walls=new ArrayList<Wall>();
  seats=new ArrayList<Seat>();

  //add devider
  walls.add(new Wall(660,250,960,2));
  walls.add(new Wall(660,471,960,2));
  
  //add walls and side seats
  
  drawWalls(240, 432, 664, 896, 1087, 285);
  drawSideSeats(213, 365, 597, 831, 1060, 303,0);

  drawWalls(240, 432, 664, 896, 1087, 435);
  drawSideSeats(213, 365, 597, 831, 1060, 418,0);



  
  
  
}

void draw()
{
  background(245,246,255);

  box2d.step();

  if (mousePressed)
  {
    Passenger p=new Passenger(12, mouseX, mouseY);
    passengers.add(p);
  }

  for (Passenger p : passengers)
  {
    Vec2 force = new Vec2(10, 0);
    //giving a force to move rightward
    p.applyForce(force);
    p.display();
  }

  for (Wall w : walls)
  {
    w.display();
  }

  for (Seat s : seats)
  {
    s.display();
  }
}

//collision enent function
void beginContact(Contact cp)
{
  Fixture f1=cp.getFixtureA();
  Fixture f2=cp.getFixtureB();

  Body b1=f1.getBody();
  Body b2=f2.getBody();

  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1==null || o2==null)
    return;

  if (o1.getClass() == Passenger.class &&
    o2.getClass() == Passenger.class)
  {
    Passenger p1 = (Passenger) o1;
    p1.change();
    Passenger p2 = (Passenger) o2;
    p2.change();
  }
}

void endContact(Contact cp)
{
}

void drawSideSeats(float x1, float x2, float x3, float x4, float x5, float y, float an)
{
  for (int i=0; i<3; i++)
  {
    seats.add(new Seat(x1+27*i, y, 24.4, 24, -an));
  }
  for (int i=0; i<6; i++)
  {
    seats.add(new Seat(x2+27*i, y, 24.4, 24, -an));
  }
  for (int i=0; i<6; i++)
  {
    seats.add(new Seat(x3+27*i, y, 24.4, 24, -an));
  }
  for (int i=0; i<6; i++)
  {
    seats.add(new Seat(x4+27*i, y, 24.4, 24, -an));
  }
  for (int i=0; i<3; i++)
  {
    seats.add(new Seat(x5+27*i, y, 24.4, 24, -an));
  }
}

void drawWalls(float x1, float x2, float x3, float x4, float x5, float y)
{
  walls.add(new Wall(x1, y, 82, 10));
  walls.add(new Wall(x2, y, 164, 10));
  walls.add(new Wall(x3, y, 164, 10));
  walls.add(new Wall(x4, y, 164, 10));
  walls.add(new Wall(x5, y, 82, 10));
}
