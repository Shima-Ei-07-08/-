void setup(){
  size(displayWidth, displayHeight, P3D);
}

void draw(){
  background(255);
  pushMatrix();
  translate(width/2, height/2);
  rotateX(radians(120));
  stroke(0);
  box(150, 150, 150);
  popMatrix();
  pushMatrix();
  fill(0);
  ellipse(50, 50 ,50,50); 
  translate(50, 50);
  sphere(100);
  popMatrix();
  fill(255);
  }