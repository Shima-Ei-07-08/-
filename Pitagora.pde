import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する//serialEvent,sendServoにて使用

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval[] = {99, 99};
int mousei= 0;
int scenes = 0;
int bx, by = 0;
int cx = -1000, cy, cback = 0;
int gcount = 0;
int gx = 0;
int my;
int n = 5;
int rx;
int count1 = 0, count2 = 0;

int mouseCount = 0;

void setup(){
  fullScreen();
  noCursor();
  bx = displayWidth/2;
  my = displayHeight;
  
/*
  printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  String portName = Serial.list()[0]; // 使用するシリアルポート名
  serialPort = new Serial(this, portName, 9600);
  serialPort.buffer(inByte.length); // 読み込むバッファの長さを指定
*/
  
}

void draw(){
  
  background(255, 200, 200); 
  
  fill(255);
  rect(displayWidth / 2 - 300, displayHeight / 2 - 3, 600, 50);
  rect(displayWidth / 2 - 25, displayHeight / 2 + 47, 50, 1000);
  meter1(100, 250);
  meter2(1100, 250);
  
  switch(scenes){
  case 0:
  
  if(mouseButton == RIGHT && mouseCount == 0){
    scenes = 1;
    mouseCount = 1;
  }
  
  
  break;
  
  case 1:
  
  ellipse(bx, by, 100, 100);
  
  if(by <= displayHeight/2 - 57){
   by+=10; 
  } else {
    scenes = 2;
    cy = by - 40;
  }
  
    fill(100);
  rect(cx, cy, 1000, 50);
  rect(displayWidth / 2 + 350, my, 100, 100);
  rect(displayWidth / 2 + 385, my + 100, 25, 1000); 
  textSize(80);
  fill(255);
  text(n - gcount ,displayWidth / 2 + 370, my + 75);
  
  break;
 
  case 2:
  
  ellipse(bx, by, 100, 100);
  
    fill(100);
  rect(cx, cy, 1000, 50);
  rect(displayWidth / 2 + 330, my, 100, 100);
  rect(displayWidth / 2 + 365, my + 100, 25, 1000); 
  textSize(80);
  fill(255);
  text(n - gcount ,displayWidth / 2 + 350, my + 75);
  
  if(cx < -1000 + displayWidth / 2 -100){
    cx+=10;
    my-=10;
  } else {
   scenes = 3; 
  }
  
  break;
  
  case 3:
  
  fill(255, 255 - gcount*51, 255);
  ellipse(bx, by, 100, 100);
  
  fill(255, 0, 255);
  ellipse(gx, cy + 10, 50, 50);
  
  fill(100);
  rect(cx, cy, 1000, 50);
  rect(displayWidth / 2 + 330, my, 100, 100);
  rect(displayWidth / 2 + 365, my + 100, 25, 1000); 
  textSize(80);
  fill(255);
  text(n - gcount ,displayWidth / 2 + 350, my + 75);
  
  if(gcount < 5 &&  gx < displayWidth/2){
       gx+=20;
     } else {
       gx = -30;
       gcount++;
     }
     
     if(gcount == 5){
      scenes = 4; 
     }
  
  break;
  
  case 4:
  
  fill(255, 255 - gcount*51, 255);
  ellipse(bx, by, 100, 100);
  
  fill(255, 0, 255);
  ellipse(gx, cy + 10, 50, 50);
  
  
  fill(100);
  rect(cx, cy, 1000, 50);
  rect(displayWidth / 2 + 330, my, 100, 100);
  rect(displayWidth / 2 + 365, my + 100, 25, 1000); 
  textSize(80);
  fill(255);
  text(n - gcount ,displayWidth / 2 + 350, my + 75);
  
  if(my < displayHeight + 100){
   my+=10; 
  } else {
   scenes = 5; 
  }
  
  break;
  
  case 5:
  
    fill(255, 255 - gcount*51, 255);
  ellipse(bx, by, 100, 100);
  
  fill(255, 0, 255);
  ellipse(gx, cy + 10, 50, 50);
  
  
  fill(100);
  rect(cx, cy, 1000, 50);
  
  fill(255);
  rect(displayWidth - rx, displayHeight / 2 - 3,1000, 25);
  
  if(displayWidth - rx >= displayHeight / 2 + 601){
    rx+=10;
  }
  
  cback++;
  
  if(cback <= 120 && cback % 10 == 0){
   cx-=10; 
  } 
  
  if(cback > 120){
    scenes = 6;
  }
  
  break;
  
  case 6:
  
      fill(255, 255 - gcount*51, 255);
  ellipse(bx, by, 100, 100);
  
  fill(255, 0, 255);
  ellipse(gx, cy + 10, 50, 50);
  
  
  fill(100);
  rect(cx, cy, 1000, 50);
  
  fill(255);
  rect(displayWidth - rx, displayHeight / 2 - 3,1000, 25);
  
  if(cx <= displayWidth / 2 - 700){
    cx+=20;
  }

  if(cx > -1000 + displayWidth / 2){
  bx+=30;
  }
  
  
  break;
  
  
  }
   
}
  
  