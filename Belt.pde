void Belt(int dy){//ベルトコンベアパターン1
  
  
  stroke(255);
  fill(100);
  rect(0, height - dy, width, height - dy);
  for(int i = 10; i < width; i+=10){
  line(i, height - dy, i, height);
  }
  stroke(0);
}