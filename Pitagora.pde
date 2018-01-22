import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する//serialEvent,sendServoにて使用

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval[] = {99, 99};
int mousei= 0;

PImage Grape, Factory, House, Hito;
int fx = 0;
int hx = 1000;
int running = 0;

int lx = 0, cy = -50, cx;

int BeltHeight = 100;

int scenes = -1;
int bg = 0;

int case1count = 0, case3count = 0, case5count = 0;

int gx = 100, gy = displayHeight - 400;

int bx = 720, bx2 = -100;
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
  Grape = loadImage("grape.png");
  Factory = loadImage("runL.png");
  House = loadImage("runR.png");
  Hito = loadImage("hito.png");

  printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  String portName = Serial.list()[0]; // 使用するシリアルポート名
  serialPort = new Serial(this, portName, 9600);
  serialPort.buffer(inByte.length); // 読み込むバッファの長さを指定

  
}

void draw(){
  
  if(bg == 0){
  background(180);    
  
  } else {
  background(180 + r, 180 + g, 180 + g);
  }

  if(running == 0){
  image(Factory,  fx,height - 245, 200, 150);
  image(Grape, fx + 150, height - 260, 100, 100);
  
  image(House, hx, height - 245, 200, 150);
  image(Grape, hx - 45, height - 260, 100, 100);
  
  fx+=40;
  hx-=40;
  
     if(fx > displayWidth + 100){
    fx = -20;
  }
  
if(hx <  - 100){
    hx = 1500;
  }
  
  } else {
    image(Factory,  fx,height - 245, 200, 150);
  image(Grape, fx + 150, height - 260, 100, 100);
  
  image(House, hx, height - 245, 200, 150);
  image(Grape, hx - 45, height - 260, 100, 100);
  
     if(fx <= displayWidth + 100){
    fx+=40;
  }
  
if(hx >=  -150){
    hx-=40;
  }
  }

  
   
  switch(scenes){
    case -1:
    BeltStop=1;
      rect(bx - 60, height - 170, 120, 70);
    Belt(BeltHeight);
    
    if(mouseButton == RIGHT){
      scenes = 10;
    }
    
  image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  
    break;
    
  case 0://最初のanimation
  BeltStop = 1;
  Belt(BeltHeight);
  fill(255);
  ellipse(bx, by, 50, 50);
  rect(bx - 60, height - 170, 120, 70);
  
  if(by < height - 130){

    by+=50;
  
  } else {
  
    scenes++;
    BeltStop = 0;
  
  }
  
  image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  
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
  
  image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  
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
    px+=50;
  } else {
    BeltStop = 1;
    pdown++;
  }
  
  if(px > bx - 80 && py <= height - 220 && pdown >= 10 && py < height - 150){
    BeltStop = 1;
   py+=50;
   
  } 
  
  
    if(py >= height - 220 && scenes < 4){
      scenes++;
    } 
 
 image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
 
   break; 
   
   case 3:
  
  /*
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
   
   */
   
   image(Grape, bx - 60, pe, 130, 100);
   
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
     pe+=50;
   }
   
   if(pe >= height && case3count < 3){
       pe = -50;
       case3count++;
   }
   
   if(case3count == 3){
     scenes++;
   }
   
   image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
   
    break; 
   
   case 4://ピストン上げる
   
  fill(255, 0, 200);
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
   
   py-=50;
   
   if(py < -60)
   {
     BeltStop = 0;
     scenes++;
   }
   
   image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
   
   break;
   
   case 5:
 
  fill(255, 0, 200);
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
  
  image(Hito, bx2 - 220, height - 200, 200, 150);
  rect(bx2 -40, height - 200, 140, 120);
  fill(0);
  textSize(100);
  text("?", bx2 + 15, height - 110);
  fill(255);
  
  break;
  
  case 6:
  
  fill(255, 0, 200);
  rect(bx - 60, height - 170, 120, 70);
  fill(255);
  
  image(Hito, bx2 - 220, height - 200, 200, 150);
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
   bx2+=50;
  } else { 
    BeltStop++;
    scenes++;
  }
  

  break;
  
  case 7:
  
  fill(255, 0, 200);
  rect(bx - 60, height - 170, 120, 70);
  image(Hito, bx2 - 220, height - 200, 200, 150);
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
 BeltStop=0;
  fill(255, 0 , 200);
  ellipse(bx - 60, height - 150, 100, 100);
  
  image(Hito, bx2 - 220, height - 200, 200, 150);
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
  
  //image(Grape, gx, gy, 100, 100);
  
  
  if(bx2 < displayWidth + 50){
  
    bx2+=30;
    
  } else {
    scenes++;
    running++;
  }
  
  
  break;
  
   case 9:
  
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

  fill(255, 0 , 200);
  ellipse(bx - 60, height - 150, 100, 100);
  
  if(fx > displayWidth + 100 &&  hx <  - 100){
    scenes++;
  }
  
  break;
  
  case 10:
  
  ;
  
  BeltStop=1;
  
  fill(255, 0 , 200);
  ellipse(bx - 60, height - 150, 100, 100);
  
  image(Factory, lx,height - 245, 200, 150);
  fill(255, 0, 255);
  
  lx+=40;
  
  if(lx > bx - 250){
    bx+=40;
  }
   
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
  
  if(lx > width + 100){
    scenes++;
    lx = -100;
  }
  
  break;
  
  case 11:
  
  fill(255);
  rect(0, height / 2, 600, height / 2);  
  beginShape();
  vertex(600, height / 2);
  vertex(width, height / 2 + 70);
  vertex(width, height);
  vertex(600, height);
  endShape(CLOSE);
   
     
  
  
  image(Factory, lx,height / 2 - 150, 200, 150);
  fill(255, 0, 255);
  
  if(lx < 450){
    fill(255, 0 , 200);
  ellipse(lx + 200, height / 2 + cy, 100, 100);
 
  lx+=40;
  cx = lx;
  } else {
    fill(255, 0 , 200);
  ellipse(cx + 200, height / 2 + cy, 100, 100);
    cx+=10;
    cy+=1;
  }
  
  break;
  
  
  
  
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
  
  