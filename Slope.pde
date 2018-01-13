void Slope(int topX, int topY/*こっちは値小さく*/, int underX, int underY/*こっちは値を大きく*/){
  beginShape();
  vertex(topX, topY);//坂の頂上
  vertex(underX, underY);//坂のふもと
  vertex(topX, underY);//山頂の真下
  endShape(CLOSE);
}