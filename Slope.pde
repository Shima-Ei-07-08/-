void Slope(int topX, int topY, int underX, int underY){
  beginShape();
  vertex(topX, topY);
  vertex(underX, underY);
  vertex(topX, underY);
  endShape(CLOSE);
}