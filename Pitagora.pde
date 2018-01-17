import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する//serialEvent,sendServoにて使用

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval1;

int scenes = 0;

int case1count = 0, case3count = 0;

int bx = 700;
int by = 0;

int px = 0, py = 200;
int pdown = 0, pe = -30;

//ベルトコンベアに関する変数　始
int Beltswitch = 0;
int BeltTurning = 10;
int BeltStop = 0;
//終

void setup(){
  fullScreen();
  noCursor();
  //printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  //String portName = Serial.list()[0]; // 使用するシリアルポート名
  //serialPort = new Serial(this, portName, 9600);
  //serialPort.buffer(inByte.length); // 読み込むバッファの長さを指定

  oval1 = 99;
}

void draw(){
  background(180);
  
  switch(scenes){
  case 0://最初のanimation
  BeltStop = 1;
  Belt(50);
  fill(255);
  ellipse(bx, by, 50, 50);
  rect(bx - 30, height - 110, 60, 60);
  
  if(by < height - 75){

    by+=10;
  
  } else {
  
    scenes++;
    BeltStop = 0;
  
  }
  break;
  case 1://二番目のアニメーション
  fill(255);
  rect(bx - 30, height - 111, 60, 60);
  //Piston(500, 500);
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    Belt(50);
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(50);
  }
  } else {
    Belt(50);
  }
  //終
  
  case1count++;
  
  if(case1count >= 150){//シーン遷移
    scenes++;
  }
  break;
  
  case 2://ピストン下す
  
  fill(255);
  
  rect(bx - 30, height - 111, 60, 60);
  
  Piston(px, py);
  
  //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      
      Belt(50);
  
  } 
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(50);
  }
  } else {
    Belt(50);
  } 
  
  //終
  
  if(px <= bx - 60){
    px+=15;
  } else {
    BeltStop = 1;
    pdown++;
  }
  
  if(px > bx - 60 && py <= height - 50 && pdown >= 120 && py < height - 150){
    BeltStop = 1;
   py+=15;
   
  } 
  
  
    if(py >= height - 150 && scenes < 4){
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
   
   
   
   rect(bx -30, pe, 60, 30);
   
   fill(255);
  
    rect(bx - 30, height - 111, 60, 60);
  
    Piston(px, py);
  
   //ベルトコンベアの移動速度についての記述　始
  if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      Belt(50);
  
  }
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(50);
  }
  } else {
    Belt(50);
  }
  //終
    
   if(pe < height){
     pe+=20;
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
   
  fill(255);
  
  rect(bx - 30, height - 111, 60, 60);
  
  Piston(px, py);
   
   //始
     if(BeltStop == 0){
  
    if(Beltswitch <=  BeltTurning){
    
      
      Belt(50);
  
  } 
  
  if(Beltswitch <= BeltTurning + 10 && Beltswitch > BeltTurning){ 
    Belt2(50);
  }
  } else {
    Belt(50);
  } 
  
  //終
   
   py-=20;
   
   if(py < -60)
   {
     scenes++;
   }
   
   break;
   
   case 5:
   
   
   
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