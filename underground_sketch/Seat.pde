


class Seat
{
  float x;
  float y;
  float w;
  float h;
  float an;


  Body b;

  Seat(float x_, float y_, float w_, float h_, float an)
  {
    x=x_;
    y=y_;
    w=w_;
    h=h_;

    //Define the polygon
    PolygonShape sd=new PolygonShape();

    //box2d coord
    float box2dW=box2d.scalarPixelsToWorld(w/2);
    float box2dH=box2d.scalarPixelsToWorld(h/2);

    sd.setAsBox(box2dW, box2dH);


    //create the body
    BodyDef bd = new BodyDef();
    bd.type=BodyType.STATIC;

    bd.angle=an;
    //set angle of seat
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    b=box2d.createBody(bd);


    //attached the shape
    b.createFixture(sd, 1);
  }

  void display()
  {


    fill(82, 166, 255);
    noStroke();
    rectMode(CENTER);

    float an=b.getAngle();
    pushMatrix();
    translate(x, y);
    rotate(-an);

    rect(0, 0, w, h);
    popMatrix();
  }
}
