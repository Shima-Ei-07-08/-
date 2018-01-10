int balldx, balldy;//ボールのdxとdy(変化量)

void setup(){
  //size(displayHeight, displayWidth , P3D);
  fullScreen(P3D);
  balldx = 510;
  balldy = -10;
}
void draw(){
  background(255);
  pushMatrix();
  translate(width/2, height/2);
  stroke(0);
  ellipse(balldx, balldy ,40,40);
  rect(10, 10 , 500, 300);
  popMatrix();
  balldx-=3;
  }