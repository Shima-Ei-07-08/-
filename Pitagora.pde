import processing.serial.*;

Serial serialPort; // Arduinoにデータを送るシリアルポート
boolean firstContact = false;  //Arduinoからのはじめの送信を確認する

byte[] inByte = new byte[3]; // 受信データ用バッファ

int oval1;

void setup(){
  fullScreen();
  printArray(Serial.list()); // 使用可能なシリアルポート一覧の出力。デバッグ用
  String portName = Serial.list()[0]; // 使用するシリアルポート名
  serialPort = new Serial(this, portName, 9600);
  serialPort.buffer(inByte.length); // 読み込むバッファの長さをの指定

  oval1 = 99;
}

void draw(){
  background(255);
  //meter(200, 200, 150, 150, 220, 320);
  fill(0);
  text("Output port: "+oval1, 10, 100);
}

void serialEvent(Serial port) {
  inByte = port.readBytes();

  if(firstContact == false) {
    if(inByte[0] == 'C') { // Arduinoとの接続確認
      port.clear();
      firstContact = true;
      sendServo(1, 99);
    } 
  }
}


// キー入力メソッド ボール落とす用とオチ用
void keyPressed() {
  switch(key){
  case 'z':
    oval1 += 1; // zキーがおされたら値を1増やす。
    sendServo(1, oval1);
    break;
  case 'x':
    oval1 -= 1; // xキーがおされたら値を1減らす。
    sendServo(1, oval1);
    break;
  case 'c':
    oval1 = 15;
    sendServo(1, oval1);
    break;
  case 'v':
    oval1 = 125;
    sendServo(1, oval1);
    break;
  default:
    break;
  }
}