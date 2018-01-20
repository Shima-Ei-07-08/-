import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する//serialEvent,sendServoにて使用

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval1;

PImage Grape;

int BeltHeight = 100;

int scenes = -1;
int bg = 0;

int case1count = 0, case3count = 0, case5count = 0;

int gx = 0, gy = 0;

int bx = 700, bx2 = 0;
int by = 0;

int px = 0, py = 200;
int pdown = 0, pe = -30;

int R = 0, G = 0, B = 0, r = 0, g = 0;
int case7color = 0;

//ベルトコンベアに関する変数　始
int Beltswitch = 0;
int BeltTurning = 10;
int BeltStop = 0;
//終

void setup(){
  fullScreen();
  noCursor();
  Grape = loadImage("grape.jpeg");

  printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  //String portName = Serial.list()[0]; // 使用するシリアルポート名
  //serialPort = new Serial(this, portName, 9600);
  //serialPort.buffer(inByte.length); // 読み込むバッファの長さを指定

  oval1 = 99;
}

void draw(){
  
  if(bg == 0){
  background(180);
  } else {
  background(180 + r, 180 + g, 180 + g);
  }
  
  switch(scenes){
    case -1:
    
      rect(bx - 60, height - 170, 120, 70);
    Belt(BeltHeight);
    
    if(mouseButton == RIGHT){
      scenes = 0;
    }
    
    break;
    
  case 0://最初のanimation
  BeltStop = 1;
  Belt(BeltHeight);
  fill(255);
  ellipse(bx, by, 50, 50);
  rect(bx - 60, height - 170, 120, 70);
  
  if(by < height - 130){

    by+=20;
  
  } else {
  
    scenes++;
    BeltStop = 0;
  
  }
  break;
  case 1://二番目のアニメーション
  fill(255);
  rect(bx - 60, height - 170, 120, 70);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(BeltHeight);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終
  
  case1count++;
  
  if(case1count >= 60){//シーン遷移
    scenes++;
  }
  break;
  
  case 2://ピストン下す
  
  fill(255);
  
  rect(bx - 60, height - 170, 120, 70);
  
  Piston(px, py);
  
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      
      Belt(BeltHeight);
  
  } 
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  } 
  
  //終
  
  if(px <= bx - 80){
    px+=15;
  } else {
    BeltStop = 1;
    pdown++;
  }
  
  if(px > bx - 80 && py <= height - 220 && pdown >= 10 && py < height - 150){
    BeltStop = 1;
   py+=15;
   
  } 
  
  
    if(py >= height - 220 && scenes < 4){
      scenes++;
    } 
 
   break; 
   
   case 3:
  
   switch(case3count){
   case 0:
   fill(255, 0, 0);
   break;
   case 1:
   fill(0, 255, 0);
   break;
   case 2:
   fill(0,0,255);
   break;
   }
   
   
   
   rect(bx - 70, pe, 130, 30);
   
   fill(255);
  
    rect(bx - 60, height - 170, 120, 70);
  
    Piston(px, py);
  
   //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      Belt(BeltHeight);
  
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終
    
   if(pe< height){
     pe+=40;
   }
   
   if(pe >= height && case3count < 3){
       pe = -30;
       case3count++;
   }
   
   if(case3count == 3){
     scenes++;
   }
   
    break; 
   
   case 4://ピストン上げる
   
  fill(255, 100, 0);
  rect(bx - 60, height - 170, 120, 70);
  
  fill(255);
  Piston(px, py);
   
   //始
     if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      
      Belt(BeltHeight);
  
  } 
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  } 
  
  //終
   
   py-=20;
   
   if(py < -60)
   {
     BeltStop = 0;
     scenes++;
   }
   
   break;
   
   case 5:
 
  fill(255, 100, 0);
  rect(bx - 60, height - 170, 120, 70);
  fill(255);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(BeltHeight);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終
  
  case5count++;
  
  if(case5count >= 30){//シーン遷移
    scenes++;
  }
  break;
  
  case 6:
  
   fill(255, 100, 0);
  rect(bx - 60, height - 170, 120, 70);
  fill(255);
  
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(BeltHeight);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終
  if(bx2 < bx - 30){
   bx2+=20;
  } else { 
    BeltStop++;
    scenes++;
  }
  
  break;
  
  case 7:
  
   fill(255, 0, 100);
  rect(bx - 60, height - 170, 120, 70);
  
  fill(255 - R, 255 - G, 255 - B);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(BeltHeight);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終わり
  
  if(case7color == 0 && G < 255 && B < 255){
    G+=15;
    B+=15;
  }
  
  if(case7color == 1 && R < 255 && G > 0){
    R+=15;
    G-=15;
  }
  
  if(case7color == 2 && G < 255 && B > 0){
   G+=15;
   B-=15;
  }
  
  if(case7color == 3 && G > 0 && R > 0){
     R-=15;
    G-=15;
     }
  
  if(G == 255 && B == 255) case7color++;
  if(R == 255 && G == 0) case7color++;
  if(B == 0 && G == 255) case7color++;
  if(G == 0 && R == 0) case7color++;
  
  if(case7color > 3 && R == 0 && G == 0 && B == 0){
    scenes++;
    bg++;
  }
  
  break;
  
  case 8:
 
    fill(255, 0, 200);
  ellipse(bx - 60, height - 170, 70, 70);
  
  fill(255, 255, 255);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(BeltHeight);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(BeltHeight);
  }
  } else {
    Belt(BeltHeight);
  }
  //終わり
  
  if(r != 75){
    r+=5;
  }
  
  if(g != 20){
    g+=5;
  }
  
  if(bx2 != displayWidth + 50){
  
    bx2+=30;
    
  }
  
  break;
  
 
  

  /*
  Boxedit(0, 300, 0, 200, 0, 0, 0);
  Boxedit(300, 300, 0, 200, 0, 0, 0);
  Boxedit(600, 300, 0, 200, 0, 0 ,0);
  */
  //rect(width - 500, height - 400, width, height);
  //Slope(width - 500, height - 400,width - 700, height);
  //meter(200, 200, 150, 150, 220, 320);
  //fill(0);
  //text("Output port: "+oval1, 10, 100);
  //text(width, 10, 30);画面幅は1366
  //text(height, 10, 30); 画面の高さは768
 
  }
   //ベルトコンベアの描画に関する記述
  Beltswitch++;
  if(Beltswitch > BeltTurning + 10){
    Beltswitch = 0;
  }
  //ベルトコンベアここまで
  
  }