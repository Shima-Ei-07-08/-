int dx, dy;//ボールのdxとdy(変化量)
float ry = 0;

void setup(){
  //size(displayHeight, displayWidth , P3D);
  fullScreen(P3D);
  dx = 510;
  dy = -10;
}
void draw(){
  background(20);
  pushMatrix();
  
  translate(width/2, height/2);
  stroke(0);
   if(dy > 50){
    rotateY(ry);
    if(ry < 90){
    ry+=0.01;
    }
  }
  powder(dx, dy, 40);
  rect(10, 10 , 500, 300);
  
  
  if(dx > -20){
  dx-=3;
  }
  
  if(dx <= -20){
    dy+=3;
  }
 
  popMatrix();  
  
  }