void meter(int centerX, int centerY, int sidediam, int vertdiam, int startrad, int endrad){
  arc(centerX, centerY, sidediam, vertdiam, startrad, endrad);
  arc(centerX, centerY + 20, sidediam - 15, vertdiam - 15, startrad, endrad);
  }