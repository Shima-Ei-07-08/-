void meter(int centerX, int centerY, int sidediam, int vertdiam, int startrad, int endrad){
  
  arc(centerX, centerY, sidediam, vertdiam, radians(startrad), radians(endrad));
  arc(centerX, centerY + 50, sidediam - 70, vertdiam - 70, radians(startrad) , radians(endrad) );
  stroke(255, 0, 0);
  line(centerX, centerY - vertdiam/2, centerX, centerY - vertdiam/2 + 80);
  stroke(0);  
}