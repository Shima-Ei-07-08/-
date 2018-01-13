void Belt2(int dy){//ベルトコンベアパターン2
  
  
  stroke(255);
  fill(100);
  rect(0, height - dy, width, height - dy);
  for(int i = 5; i < width; i+=10){
  line(i, height - dy, i, height);
  }
  stroke(0);
}