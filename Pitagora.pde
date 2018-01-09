void setup(){
  size(displayWidth, displayHeight, P3D);
}

void draw(){
  background(0);
  
  translate(width/2, height/2);
  rotateY(radians(120));
  box(150, 150, 150);
}