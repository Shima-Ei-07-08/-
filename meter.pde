void meter1(int x, int y){
  
  fill(200);
 rect(x, y, 100, 700);
  
 
for(int i = 0;i < count1;i++){
  fill(255, 255 - 12 * i, 0);
   rect(x + 25, displayHeight - 25 * i, 50, 25);
   fill(255);
}
  
  if(count1 < 20){
  count1++;
  } else {
    count1 = 0;
  }
   
}