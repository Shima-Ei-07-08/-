import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する//serialEvent,sendServoにて使用

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval1;
//int bx = 0;
//ベルトコンベアに関する変数　始
int Beltswitch = 0;
int BeltTurning = 10;
int BeltStop = 0;
//終

void setup(){
  fullScreen(P3D);
  //printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  //String portName = Serial.list()[0]; // 使用するシリアルポート名
  //serialPort = new Serial(this, portName, 9600);
  //serialPort.buffer(inByte.length); // 読み込むバッファの長さをの指定

  oval1 = 99;
}

void draw(){
  background(180);
  fill(255);
  Piston(500, 500);
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
  
  fill(255);
  Boxedit(0, 300, 0, 200, 0, 0, 0);
  Boxedit(300, 300, 0, 200, 0, 0, 0);
  Boxedit(600, 300, 0, 200, 0, 0 ,0);
  //rect(width - 500, height - 400, width, height);
  //Slope(width - 500, height - 400,width - 700, height);
  //meter(200, 200, 150, 150, 220, 320);
  fill(0);
  text("Output port: "+oval1, 10, 100);
  //text(width, 10, 30);画面幅は1366
  //text(height, 10, 30); 画面の高さは768
   
   //ベルトコンベアの描画に関する記述
  Beltswitch++;
  if(Beltswitch > BeltTurning + 10){
    Beltswitch = 0;
  }
  //ベルトコンベアここまで
  
  }