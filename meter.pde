/*void meter(int centerX, int centerY, int sidediam, int vertdiam, int startrad, int endrad){
  
  pushMatrix();
  translate(centerX, centerY);
  arc(0, 40, sidediam, vertdiam, radians(startrad), radians(endrad));//メーターの上の弧
  arc(0, 90, sidediam - 70, vertdiam - 70, radians(startrad) , radians(endrad) );//メーターの下の弧
  popMatrix();
  pushMatrix();
  translate(centerX, centerY + 50);
  //rotate(30);
  stroke(255, 0, 0);
  line(0, vertdiam/2, 0, vertdiam/2 + 80);
  stroke(0);
  //rotate(30);
  popMatrix();
}*/